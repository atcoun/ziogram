const types = @import("types");

pub const Result = bool;
pub const method_name = "deleteEphemeralMessage";

chat_id: types.ChatId,
receiver_user_id: i64,
ephemeral_message_id: i32,
