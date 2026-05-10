const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const enums = b.addModule("enums", .{
        .root_source_file = b.path("src/enums/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const errors = b.addModule("errors", .{
        .root_source_file = b.path("src/errors.zig"),
        .target = target,
        .optimize = optimize,
    });

    const methods = b.addModule("methods", .{
        .root_source_file = b.path("src/methods/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const types = b.addModule("types", .{
        .root_source_file = b.path("src/types/root.zig"),
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
    types.addImport("types", types);

    ziogram.addImport("enums", enums);
    ziogram.addImport("errors", errors);
    ziogram.addImport("methods", methods);
    ziogram.addImport("types", types);

    const ziogram_tests = b.addTest(.{
        .root_module = ziogram,
    });
    const run_ziogram_tests = b.addRunArtifact(ziogram_tests);

    const errors_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/errors.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "types", .module = types },
            },
        }),
    });
    const run_errors_tests = b.addRunArtifact(errors_tests);

    const api_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/client/api.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{},
        }),
    });
    const run_api_tests = b.addRunArtifact(api_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_ziogram_tests.step);
    test_step.dependOn(&run_errors_tests.step);
    test_step.dependOn(&run_api_tests.step);
}
