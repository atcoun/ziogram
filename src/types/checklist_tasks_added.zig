const types = @import("../types.zig");

pub const ChecklistTasksAdded = struct {
    checklist_message: ?*types.Message = null,
    tasks: []const types.ChecklistTask,
};
