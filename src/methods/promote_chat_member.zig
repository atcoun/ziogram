const types = @import("types");

pub const Result = bool;
pub const method_name = "promoteChatMember";

chat_id: types.ChatId,
user_id: i64,
is_anonymous: ?bool = null,
can_manage_chat: ?bool = null,
can_delete_messages: ?bool = null,
can_manage_video_chats: ?bool = null,
can_restrict_members: ?bool = null,
can_promote_members: ?bool = null,
can_change_info: ?bool = null,
can_invite_users: ?bool = null,
can_post_stories: ?bool = null,
can_edit_stories: ?bool = null,
can_delete_stories: ?bool = null,
can_post_messages: ?bool = null,
can_edit_messages: ?bool = null,
can_pin_messages: ?bool = null,
can_manage_topics: ?bool = null,
can_manage_direct_messages: ?bool = null,
can_manage_tags: ?bool = null,
