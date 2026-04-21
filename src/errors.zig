const std = @import("std");

const types = @import("types");
const ChatId = types.ChatId;

pub const ZiogramError = error{
    CallbackAnswerException,
    SceneException,
    UnsupportedKeywordArgument,
    NameServerFailure,
    TelegramNetworkError,
    TelegramEntityTooLarge,
    TelegramBadRequest,
    TelegramNotFound,
    TelegramConflictError,
    TelegramUnauthorizedError,
    TelegramForbiddenError,
    TelegramServerError,
    ClientDecodeError,
    DataNotDictLikeError,
    TelegramRetryAfter,
    TelegramMigrateToChat,
    OutOfMemory,
    TelegramAPIError,
};

label: []const u8 = "ziogram",
message: []const u8,
url: ?[]const u8 = null,
url_owned: bool = false,
allocator: ?std.mem.Allocator = null,
extra: Extra = .none,

pub const Extra = union(enum) {
    none: void,
    retry_after: u32,
    migrate_to_chat_id: i64,
    decode_info: struct {
        err_name: []const u8,
        content: []const u8,
    },
};

pub fn deinit(self: *@This()) void {
    if (self.allocator) |alloc| {
        alloc.free(self.message);
        if (self.url_owned) {
            if (self.url) |url| alloc.free(url);
        }
        self.* = undefined;
    }
}

pub fn makeRetryAfter(
    allocator: std.mem.Allocator,
    method_name: []const u8,
    chat_id: ?ChatId,
    retry_after: u32,
    original_desc: []const u8,
) !@This() {
    const msg = if (chat_id) |cid| switch (cid) {
        .id => |id| try std.fmt.allocPrint(allocator, "Flood control exceeded on method '{s}' in chat {d}. Retry in {d} seconds. Original description: {s}", .{ method_name, id, retry_after, original_desc }),
        .username => |un| try std.fmt.allocPrint(allocator, "Flood control exceeded on method '{s}' in chat {s}. Retry in {d} seconds. Original description: {s}", .{ method_name, un, retry_after, original_desc }),
    } else try std.fmt.allocPrint(allocator, "Flood control exceeded on method '{s}'. Retry in {d} seconds. Original description: {s}", .{ method_name, retry_after, original_desc });

    return @This(){
        .label = "Telegram server says",
        .message = msg,
        .url = "https://core.telegram.org/bots/faq#my-bot-is-hitting-limits-how-do-i-avoid-this",
        .allocator = allocator,
        .extra = .{ .retry_after = retry_after },
    };
}

pub fn makeMigrateToChat(
    allocator: std.mem.Allocator,
    chat_id: ?ChatId,
    migrate_id: i64,
    original_desc: []const u8,
) !@This() {
    const msg = if (chat_id) |cid| switch (cid) {
        .id => |old_id| try std.fmt.allocPrint(allocator, "The group has been migrated to a supergroup with id {d} from {d}\nOriginal description: {s}", .{ migrate_id, old_id, original_desc }),
        .username => |old_un| try std.fmt.allocPrint(allocator, "The group has been migrated to a supergroup with id {d} from {s}\nOriginal description: {s}", .{ migrate_id, old_un, original_desc }),
    } else try std.fmt.allocPrint(allocator, "The group has been migrated to a supergroup with id {d}\nOriginal description: {s}", .{ migrate_id, original_desc });

    return @This(){
        .label = "Telegram server says",
        .message = msg,
        .url = "https://core.telegram.org/bots/api#responseparameters",
        .allocator = allocator,
        .extra = .{ .migrate_to_chat_id = migrate_id },
    };
}

pub fn makeDecodeError(
    allocator: std.mem.Allocator,
    err: anyerror,
    content: []const u8,
) !@This() {
    const msg = try std.fmt.allocPrint(allocator, "Failed to decode object\nCaused from error: {s}\nContent: {s}", .{ @errorName(err), content });

    return @This(){
        .label = "Client Error",
        .message = msg,
        .allocator = allocator,
        .extra = .{ .decode_info = .{
            .err_name = @errorName(err),
            .content = content,
        } },
    };
}

pub fn makeTelegramError(
    allocator: std.mem.Allocator,
    method_name: []const u8,
    error_code: i32,
    description: []const u8,
) !@This() {
    const msg = try std.fmt.allocPrint(
        allocator,
        "Method '{s}' failed ({d}): {s}",
        .{ method_name, error_code, description },
    );

    const lower_name = try allocator.dupe(u8, method_name);
    defer allocator.free(lower_name);
    _ = std.ascii.lowerString(lower_name, method_name);

    const url = try std.fmt.allocPrint(
        allocator,
        "https://core.telegram.org/bots/api#{s}",
        .{lower_name},
    );

    return @This(){
        .label = "Telegram API Error",
        .message = msg,
        .allocator = allocator,
        .url = url,
        .url_owned = true,
    };
}

test "makeTelegramError message contains method name and code" {
    const allocator = std.testing.allocator;
    var err = try makeTelegramError(allocator, "sendMessage", 403, "Forbidden");
    defer err.deinit();

    try std.testing.expectEqualStrings("Telegram API Error", err.label);
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "sendMessage"));
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "403"));
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "Forbidden"));
}

test "makeTelegramError url points to lowercase method" {
    const allocator = std.testing.allocator;
    var err = try makeTelegramError(allocator, "sendMessage", 400, "Bad Request");
    defer err.deinit();

    const url = err.url orelse return error.MissingUrl;
    try std.testing.expect(std.mem.containsAtLeast(u8, url, 1, "sendmessage"));
    try std.testing.expect(std.mem.startsWith(u8, url, "https://core.telegram.org/bots/api#"));
}

test "makeRetryAfter no chat_id" {
    const allocator = std.testing.allocator;
    var err = try makeRetryAfter(allocator, "sendMessage", null, 30, "Too Many Requests");
    defer err.deinit();

    try std.testing.expectEqualStrings("Telegram server says", err.label);
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "30"));
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "sendMessage"));
    try std.testing.expectEqual(@as(u32, 30), err.extra.retry_after);
}

test "makeRetryAfter with numeric chat_id" {
    const allocator = std.testing.allocator;
    var err = try makeRetryAfter(allocator, "sendMessage", .{ .id = 123456 }, 15, "Too Many Requests");
    defer err.deinit();

    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "123456"));
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "15"));
    try std.testing.expectEqual(@as(u32, 15), err.extra.retry_after);
}

test "makeRetryAfter with username chat_id" {
    const allocator = std.testing.allocator;
    var err = try makeRetryAfter(allocator, "sendMessage", .{ .username = "@mychannel" }, 5, "Too Many Requests");
    defer err.deinit();

    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "@mychannel"));
}

test "makeMigrateToChat no chat_id" {
    const allocator = std.testing.allocator;
    var err = try makeMigrateToChat(allocator, null, 9999999, "Migrate");
    defer err.deinit();

    try std.testing.expectEqualStrings("Telegram server says", err.label);
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "9999999"));
    try std.testing.expectEqual(@as(i64, 9999999), err.extra.migrate_to_chat_id);
}

test "makeMigrateToChat with numeric chat_id" {
    const allocator = std.testing.allocator;
    var err = try makeMigrateToChat(allocator, .{ .id = 111 }, 9999999, "Migrate");
    defer err.deinit();

    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "111"));
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "9999999"));
}

test "makeDecodeError contains error name and content" {
    const allocator = std.testing.allocator;
    var err = try makeDecodeError(allocator, error.UnexpectedToken, "{bad json}");
    defer err.deinit();

    try std.testing.expectEqualStrings("Client Error", err.label);
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "UnexpectedToken"));
    try std.testing.expect(std.mem.containsAtLeast(u8, err.message, 1, "{bad json}"));
    try std.testing.expectEqualStrings("UnexpectedToken", err.extra.decode_info.err_name);
}
