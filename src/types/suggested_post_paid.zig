const enums = @import("enums");
const types = @import("types");

suggested_post_message: ?*types.Message = null,
currency: enums.Currency,
amount: ?i32 = null,
star_amount: ?types.StarAmount = null,
