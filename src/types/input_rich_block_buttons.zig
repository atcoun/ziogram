const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .buttons,
buttons: []const types.RichMessageButton,
@"align": ?enums.ButtonsAlign = null,
