const enums = @import("enums");
const types = @import("../types.zig");

state: enums.SuggestedPostState,
price: ?types.SuggestedPostPrice = null,
send_date: ?i32 = null,
