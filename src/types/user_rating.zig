pub const UserRating = struct {
    level: i32,
    rating: i32,
    current_level_rating: i32,
    next_level_rating: ?i32 = null,
};
