const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .buttons,
buttons: []const types.RichMessageButton,
@"align": ?enums.ButtonsAlign = null,
