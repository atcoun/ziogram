const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputChecklist = struct {
    title: []const u8,
    parse_mode: ?enums.ParseMode = null,
    title_entities: ?[]const types.MessageEntity = null,
    tasks: []const types.InputChecklistTask,
    others_can_add_tasks: ?bool = null,
    others_can_mark_tasks_as_done: ?bool = null,
};
