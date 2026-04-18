const std = @import("std");
const log = std.log.scoped(.token_validation);

pub const TokenError = error{
    InvalidCharacter,
    NoSeparator,
    InvalidId,
    EmptyToken,
};

pub fn validateToken(token: []const u8) TokenError!void {
    if (token.len == 0) {
        log.err("Token is invalid! It's empty.", .{});
        return TokenError.EmptyToken;
    }

    for (token) |char| {
        if (std.ascii.isWhitespace(char)) {
            log.err("Token is invalid! It can't contain spaces.", .{});
            return TokenError.InvalidCharacter;
        }
    }

    var parts = std.mem.splitScalar(u8, token, ':');

    const left = parts.next() orelse {
        log.err("Token is invalid! Missing separator ':'", .{});
        return TokenError.NoSeparator;
    };

    if (left.len == 0) {
        log.err("Token is invalid! ID part is empty.", .{});
        return TokenError.InvalidId;
    }

    for (left) |char| {
        if (!std.ascii.isDigit(char)) {
            log.err("Token is invalid! ID must be numeric, found: '{c}'", .{char});
            return TokenError.InvalidId;
        }
    }

    const right = parts.next() orelse {
        log.err("Token is invalid! Missing part after ':'", .{});
        return TokenError.NoSeparator;
    };

    if (right.len == 0) {
        log.err("Token is invalid! Secret part is empty.", .{});
        return TokenError.NoSeparator;
    }
}

pub fn extractBotId(token: []const u8) !i64 {
    try validateToken(token);
    var parts = std.mem.splitScalar(u8, token, ':');
    const id_str = parts.first();
    return std.fmt.parseInt(i64, id_str, 10);
}
