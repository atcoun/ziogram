pub const ChatId = union(enum) {
    id: i64,
    username: []const u8,
};
