const std = @import("std");

const enums = @import("enums");
const types = @import("types");

type: enums.RichTextType = .subscript,
text: *const types.RichText,

pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
    const value = try std.json.innerParse(std.json.Value, allocator, source, options);
    return jsonParseFromValue(allocator, value, options);
}

pub fn jsonParseFromValue(allocator: std.mem.Allocator, value: std.json.Value, options: std.json.ParseOptions) !@This() {
    return .{ .text = try types.RichText.parseTextPointer(allocator, value, options) };
}
