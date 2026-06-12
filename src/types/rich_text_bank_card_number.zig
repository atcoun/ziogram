const std = @import("std");

const enums = @import("enums");
const types = @import("types");

type: enums.RichTextType = .bank_card_number,
text: *const types.RichText,
bank_card_number: []const u8,

pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
    const value = try std.json.innerParse(std.json.Value, allocator, source, options);
    return jsonParseFromValue(allocator, value, options);
}

pub fn jsonParseFromValue(allocator: std.mem.Allocator, value: std.json.Value, options: std.json.ParseOptions) !@This() {
    return .{
        .text = try types.RichText.parseTextPointer(allocator, value, options),
        .bank_card_number = try std.json.innerParseFromValue([]const u8, allocator, value.object.get("bank_card_number") orelse return error.MissingField, options),
    };
}
