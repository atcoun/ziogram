const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const RichText = union(enum) {
    plain: []const u8,
    array: []const RichText,
    bold: types.RichTextBold,
    italic: types.RichTextItalic,
    underline: types.RichTextUnderline,
    strikethrough: types.RichTextStrikethrough,
    spoiler: types.RichTextSpoiler,
    date_time: types.RichTextDateTime,
    text_mention: types.RichTextTextMention,
    subscript: types.RichTextSubscript,
    superscript: types.RichTextSuperscript,
    marked: types.RichTextMarked,
    code: types.RichTextCode,
    custom_emoji: types.RichTextCustomEmoji,
    mathematical_expression: types.RichTextMathematicalExpression,
    url: types.RichTextUrl,
    email_address: types.RichTextEmailAddress,
    phone_number: types.RichTextPhoneNumber,
    bank_card_number: types.RichTextBankCardNumber,
    mention: types.RichTextMention,
    hashtag: types.RichTextHashtag,
    cashtag: types.RichTextCashtag,
    bot_command: types.RichTextBotCommand,
    anchor: types.RichTextAnchor,
    anchor_link: types.RichTextAnchorLink,
    reference: types.RichTextReference,
    reference_link: types.RichTextReferenceLink,

    pub fn parseTextPointer(allocator: std.mem.Allocator, value: std.json.Value, options: std.json.ParseOptions) !*const RichText {
        const text_value = value.object.get("text") orelse return error.MissingField;
        const ptr = try allocator.create(RichText);
        ptr.* = try jsonParseFromValue(allocator, text_value, options);
        return ptr;
    }

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        return jsonParseFromValue(allocator, value, options);
    }

    pub fn jsonParseFromValue(allocator: std.mem.Allocator, value: std.json.Value, options: std.json.ParseOptions) !@This() {
        return switch (value) {
            .string => |s| .{ .plain = s },
            .array => |arr| blk: {
                const list = try allocator.alloc(RichText, arr.items.len);
                for (arr.items, list) |item, *out| {
                    out.* = try jsonParseFromValue(allocator, item, options);
                }
                break :blk .{ .array = list };
            },
            .object => {
                const rich_type = std.meta.stringToEnum(
                    enums.RichTextType,
                    if (value.object.get("type")) |t| t.string else return error.MissingField,
                ) orelse return error.UnexpectedToken;

                return switch (rich_type) {
                    .bold => .{ .bold = try std.json.innerParseFromValue(types.RichTextBold, allocator, value, options) },
                    .italic => .{ .italic = try std.json.innerParseFromValue(types.RichTextItalic, allocator, value, options) },
                    .underline => .{ .underline = try std.json.innerParseFromValue(types.RichTextUnderline, allocator, value, options) },
                    .strikethrough => .{ .strikethrough = try std.json.innerParseFromValue(types.RichTextStrikethrough, allocator, value, options) },
                    .spoiler => .{ .spoiler = try std.json.innerParseFromValue(types.RichTextSpoiler, allocator, value, options) },
                    .date_time => .{ .date_time = try std.json.innerParseFromValue(types.RichTextDateTime, allocator, value, options) },
                    .text_mention => .{ .text_mention = try std.json.innerParseFromValue(types.RichTextTextMention, allocator, value, options) },
                    .subscript => .{ .subscript = try std.json.innerParseFromValue(types.RichTextSubscript, allocator, value, options) },
                    .superscript => .{ .superscript = try std.json.innerParseFromValue(types.RichTextSuperscript, allocator, value, options) },
                    .marked => .{ .marked = try std.json.innerParseFromValue(types.RichTextMarked, allocator, value, options) },
                    .code => .{ .code = try std.json.innerParseFromValue(types.RichTextCode, allocator, value, options) },
                    .custom_emoji => .{ .custom_emoji = try std.json.innerParseFromValue(types.RichTextCustomEmoji, allocator, value, options) },
                    .mathematical_expression => .{ .mathematical_expression = try std.json.innerParseFromValue(types.RichTextMathematicalExpression, allocator, value, options) },
                    .url => .{ .url = try std.json.innerParseFromValue(types.RichTextUrl, allocator, value, options) },
                    .email_address => .{ .email_address = try std.json.innerParseFromValue(types.RichTextEmailAddress, allocator, value, options) },
                    .phone_number => .{ .phone_number = try std.json.innerParseFromValue(types.RichTextPhoneNumber, allocator, value, options) },
                    .bank_card_number => .{ .bank_card_number = try std.json.innerParseFromValue(types.RichTextBankCardNumber, allocator, value, options) },
                    .mention => .{ .mention = try std.json.innerParseFromValue(types.RichTextMention, allocator, value, options) },
                    .hashtag => .{ .hashtag = try std.json.innerParseFromValue(types.RichTextHashtag, allocator, value, options) },
                    .cashtag => .{ .cashtag = try std.json.innerParseFromValue(types.RichTextCashtag, allocator, value, options) },
                    .bot_command => .{ .bot_command = try std.json.innerParseFromValue(types.RichTextBotCommand, allocator, value, options) },
                    .anchor => .{ .anchor = try std.json.innerParseFromValue(types.RichTextAnchor, allocator, value, options) },
                    .anchor_link => .{ .anchor_link = try std.json.innerParseFromValue(types.RichTextAnchorLink, allocator, value, options) },
                    .reference => .{ .reference = try std.json.innerParseFromValue(types.RichTextReference, allocator, value, options) },
                    .reference_link => .{ .reference_link = try std.json.innerParseFromValue(types.RichTextReferenceLink, allocator, value, options) },
                };
            },
            else => error.UnexpectedToken,
        };
    }
};
