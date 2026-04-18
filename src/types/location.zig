pub const Location = struct {
    latitude: f32,
    longitude: f32,
    horizontal_accuracy: ?f32 = null,
    live_period: ?i32 = null,
    heading: ?i32 = null,
    proximity_alert_radius: ?i32 = null,
};
