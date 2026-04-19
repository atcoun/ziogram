const types = @import("types");

chat: types.Chat,
from: types.User,
date: i32,
old_chat_member: types.ChatMember,
new_chat_member: types.ChatMember,
invite_link: ?types.ChatInviteLink = null,
via_join_request: ?bool = null,
via_chat_folder_invite_link: ?bool = null,
