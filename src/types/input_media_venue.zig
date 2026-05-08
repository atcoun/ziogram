const enums = @import("enums");
const types = @import("types");

type: enums.InputMediaType = .venue,
latitude: f32,
longitude: f32,
title: []const u8,
address: []const u8,
foursquare_id: ?[]const u8 = null,
foursquare_type: ?[]const u8 = null,
google_place_id: ?[]const u8 = null,
google_place_type: ?[]const u8 = null,
