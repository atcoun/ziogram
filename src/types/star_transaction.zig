const types = @import("types");

id: []const u8,
amount: i32,
nanostar_amount: ?i32 = null,
date: i32,
source: ?types.TransactionPartner = null,
receiver: ?types.TransactionPartner = null,
