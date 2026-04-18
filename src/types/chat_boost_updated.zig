const types = @import("../types.zig");

pub const ChatBoostUpdated = struct {
    chat: types.Chat,
    boost: types.ChatBoost,
};
