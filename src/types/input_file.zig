const std = @import("std");
const Io = std.Io;

pub const InputFile = union(enum) {
    fs: struct {
        path: []const u8,
        filename: []const u8,
    },
    buffer: struct {
        data: []const u8,
        filename: []const u8,
    },
    url: []const u8,
    file_id: []const u8,

    pub fn fromPath(path: []const u8) InputFile {
        return .{
            .fs = .{
                .path = path,
                .filename = std.fs.path.basename(path),
            },
        };
    }

    pub fn fromBuffer(io: Io, allocator: std.mem.Allocator, path: []const u8) !InputFile {
        const dir = std.Io.Dir.cwd();

        const limit = Io.Limit.limited(50 * 1024 * 1024);
        const data = try dir.readFileAlloc(io, path, allocator, limit);

        return .{
            .buffer = .{
                .data = data,
                .filename = std.fs.path.basename(path),
            },
        };
    }

    pub fn getFilename(self: InputFile) []const u8 {
        return switch (self) {
            .fs => |f| f.filename,
            .buffer => |b| b.filename,
            .url => |u| std.fs.path.basename(u),
            .file_id => "file",
        };
    }

    pub fn writeTo(self: InputFile, io: Io, w: *Io.Writer) !void {
        switch (self) {
            .buffer => |b| try w.writeAll(b.data),
            .fs => |f| {
                const cwd = std.Io.Dir.cwd();
                const file = try cwd.openFile(io, f.path, .{ .mode = .read_only });
                defer file.close(io);

                var buf: [64 * 1024]u8 = undefined;
                var r = file.reader(io, &buf);

                _ = try r.interface.streamRemaining(w);
            },
            .url => |u| try w.writeAll(u),
            .file_id => |id| try w.writeAll(id),
        }
    }
};
