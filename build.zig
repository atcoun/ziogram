const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const enums = b.addModule("enums", .{
        .root_source_file = b.path("src/enums.zig"),
        .target = target,
        .optimize = optimize,
    });

    const errors = b.addModule("errors", .{
        .root_source_file = b.path("src/errors.zig"),
        .target = target,
        .optimize = optimize,
    });

    const methods = b.addModule("methods", .{
        .root_source_file = b.path("src/methods.zig"),
        .target = target,
        .optimize = optimize,
    });

    const types = b.addModule("types", .{
        .root_source_file = b.path("src/types.zig"),
        .target = target,
        .optimize = optimize,
    });

    const ziogram = b.addModule("ziogram", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    errors.addImport("types", types);

    methods.addImport("enums", enums);
    methods.addImport("types", types);

    types.addImport("enums", enums);

    ziogram.addImport("enums", enums);
    ziogram.addImport("errors", errors);
    ziogram.addImport("methods", methods);
    ziogram.addImport("types", types);

    const exe = b.addExecutable(.{
        .name = "ziogram",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "ziogram", .module = ziogram },
            },
        }),
    });

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
}
