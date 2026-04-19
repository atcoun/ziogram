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
