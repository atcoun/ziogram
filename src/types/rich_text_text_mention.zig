const std = @import("std");

const enums = @import("enums");
const types = @import("types");

type: enums.RichTextType = .text_mention,
text: *const types.RichText,
user: types.User,

pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
    const value = try std.json.innerParse(std.json.Value, allocator, source, options);
    return jsonParseFromValue(allocator, value, options);
}

pub fn jsonParseFromValue(allocator: std.mem.Allocator, value: std.json.Value, options: std.json.ParseOptions) !@This() {
    return .{
        .text = try types.RichText.parseTextPointer(allocator, value, options),
        .user = try std.json.innerParseFromValue(types.User, allocator, value.object.get("user") orelse return error.MissingField, options),
    };
}
