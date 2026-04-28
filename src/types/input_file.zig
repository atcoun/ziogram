const std = @import("std");
const Io = std.Io;

pub const default_chunk_size: usize = 64 * 1024;

pub const InputFile = union(enum) {
    fs: struct {
        path: []const u8,
        filename: ?[]const u8 = null,
        chunk_size: usize = default_chunk_size,
    },
    buffer: struct {
        data: []const u8,
        filename: ?[]const u8 = null,
        chunk_size: usize = default_chunk_size,
    },
    url: struct {
        url: []const u8,
        headers: std.http.Client.Request.Headers = .{},
        filename: ?[]const u8 = null,
        chunk_size: usize = default_chunk_size,
    },
    file_id: []const u8,

    pub fn getFilename(self: InputFile, buf: []u8) []const u8 {
        switch (self) {
            .fs => |f| {
                if (f.filename) |name| return name;
                const name = std.fs.path.basename(f.path);
                return if (name.len == 0) "file" else name;
            },
            .buffer => |b| return b.filename orelse "file",
            .file_id => return "file",
            .url => |u| {
                const uri = std.Uri.parse(u.url) catch return "file";
                const encoded_name = switch (uri.path) {
                    .raw, .percent_encoded => |s| std.fs.path.basenamePosix(s),
                };
                if (encoded_name.len == 0) return "file";

                const component: std.Uri.Component = .{ .percent_encoded = encoded_name };

                return component.toRaw(buf) catch encoded_name;
            },
        }
    }

    pub fn writeTo(self: InputFile, io: Io, w: *Io.Writer, client: *std.http.Client) !void {
        switch (self) {
            .fs => |f| {
                const file = try std.Io.Dir.cwd().openFile(
                    io,
                    f.path,
                    .{ .mode = .read_only, .allow_directory = false },
                );
                defer file.close(io);

                var file_buf: [default_chunk_size]u8 = undefined;
                var file_reader = file.reader(io, &file_buf);

                _ = try w.sendFileAll(&file_reader, .unlimited);
            },
            .buffer => |b| try w.writeAll(b.data),
            .url => |u| {
                const uri = try std.Uri.parse(u.url);

                var req = try client.request(.GET, uri, .{
                    .headers = u.headers,
                });
                defer req.deinit();

                try req.sendBodiless();

                var redirect_buf: [8000]u8 = undefined;
                var res = try req.receiveHead(&redirect_buf);

                if (res.head.status.class() != .success) return error.HttpDownloadFailed;

                const buf = try client.allocator.alloc(u8, u.chunk_size);
                defer client.allocator.free(buf);

                var response_reader = res.reader(buf);

                while (true) {
                    const n = try response_reader.readSliceShort(buf);
                    if (n == 0) break;

                    try w.writeAll(buf[0..n]);
                }
            },
            .file_id => unreachable,
        }
    }
};
