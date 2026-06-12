const std = @import("std");

const enums = @import("enums");
const types = @import("types");

type: enums.RichTextType = .date_time,
text: *const types.RichText,
unix_time: i64,
date_time_format: []const u8,

pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
    const value = try std.json.innerParse(std.json.Value, allocator, source, options);
    return jsonParseFromValue(allocator, value, options);
}

pub fn jsonParseFromValue(allocator: std.mem.Allocator, value: std.json.Value, options: std.json.ParseOptions) !@This() {
    return .{
        .text = try types.RichText.parseTextPointer(allocator, value, options),
        .unix_time = try std.json.innerParseFromValue(i64, allocator, value.object.get("unix_time") orelse return error.MissingField, options),
        .date_time_format = try std.json.innerParseFromValue([]const u8, allocator, value.object.get("date_time_format") orelse return error.MissingField, options),
    };
}
