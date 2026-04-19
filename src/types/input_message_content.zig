const std = @import("std");

const types = @import("types");

pub const InputMessageContent = union(enum) {
    text: types.InputTextMessageContent,
    location: types.InputLocationMessageContent,
    venue: types.InputVenueMessageContent,
    contact: types.InputContactMessageContent,
    invoice: types.InputInvoiceMessageContent,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);

        if (value.object.get("message_text")) |_| {
            return .{ .text = try std.json.innerParseFromValue(types.InputTextMessageContent, allocator, value, options) };
        } else if (value.object.get("address")) |_| {
            return .{ .venue = try std.json.innerParseFromValue(types.InputVenueMessageContent, allocator, value, options) };
        } else if (value.object.get("phone_number")) |_| {
            return .{ .contact = try std.json.innerParseFromValue(types.InputContactMessageContent, allocator, value, options) };
        } else if (value.object.get("title")) |_| {
            return .{ .invoice = try std.json.innerParseFromValue(types.InputInvoiceMessageContent, allocator, value, options) };
        } else if (value.object.get("latitude")) |_| {
            return .{ .location = try std.json.innerParseFromValue(types.InputLocationMessageContent, allocator, value, options) };
        }

        return error.UnknownInputMessageContent;
    }
};
