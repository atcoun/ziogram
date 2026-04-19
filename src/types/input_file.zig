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

    pub fn fromPathBuffered(io: Io, allocator: std.mem.Allocator, path: []const u8) !InputFile {
        const limit: Io.Limit = .limited(50 * 1024 * 1024);
        const data = try std.Io.Dir.cwd().readFileAlloc(io, path, allocator, limit);
        return .{
            .buffer = .{
                .data = data,
                .filename = std.fs.path.basename(path),
            },
        };
    }

    pub fn fromBuffer(data: []const u8, filename: []const u8) InputFile {
        return .{ .buffer = .{ .data = data, .filename = filename } };
    }

    pub fn getFilename(self: InputFile, buf: []u8) []const u8 {
        switch (self) {
            .fs => |f| return f.filename,
            .buffer => |b| return b.filename,
            .file_id => return "file",
            .url => |u| {
                const uri = std.Uri.parse(u) catch return "file";
                const raw_path = switch (uri.path) {
                    .raw, .percent_encoded => |s| s,
                };
                const encoded_name = std.fs.path.basenamePosix(raw_path);
                if (encoded_name.len == 0) return "file";
                const component: std.Uri.Component = .{ .percent_encoded = encoded_name };
                return component.toRaw(buf) catch encoded_name;
            },
        }
    }

    pub fn writeTo(self: InputFile, io: Io, w: *Io.Writer) !void {
        switch (self) {
            .buffer => |b| try w.writeAll(b.data),
            .fs => |f| {
                const file = try std.Io.Dir.cwd().openFile(io, f.path, .{});
                defer file.close(io);

                var buf: [64 * 1024]u8 = undefined;
                var reader = file.reader(io, &buf);

                _ = try w.sendFileAll(&reader, .unlimited);
            },
            .url, .file_id => unreachable,
        }
    }
};
