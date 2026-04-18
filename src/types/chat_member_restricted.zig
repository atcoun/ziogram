const types = @import("../types.zig");

pub const ChatMemberRestricted = struct {
    status: []const u8 = "restricted",
    tag: ?[]const u8 = null,
    user: types.User,
    is_member: bool,
    can_send_messages: bool,
    can_send_audios: bool,
    can_send_documents: bool,
    can_send_photos: bool,
    can_send_videos: bool,
    can_send_video_notes: bool,
    can_send_voice_notes: bool,
    can_send_polls: bool,
    can_send_other_messages: bool,
    can_add_web_page_previews: bool,
    can_edit_tag: bool,
    can_change_info: bool,
    can_invite_users: bool,
    can_pin_messages: bool,
    can_manage_topics: bool,
    until_date: i32,
};
