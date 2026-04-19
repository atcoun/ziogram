const enums = @import("enums");
const types = @import("types");

title: []const u8,
parse_mode: ?enums.ParseMode = null,
title_entities: ?[]const types.MessageEntity = null,
tasks: []const types.InputChecklistTask,
others_can_add_tasks: ?bool = null,
others_can_mark_tasks_as_done: ?bool = null,
