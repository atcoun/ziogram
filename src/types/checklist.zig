const types = @import("../types.zig");

title: []const u8,
title_entities: ?[]const types.MessageEntity = null,
tasks: []const types.ChecklistTask,
others_can_add_tasks: ?bool = null,
others_can_mark_tasks_as_done: ?bool = null,
