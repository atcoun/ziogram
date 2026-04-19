const std = @import("std");
const enums = @import("enums");
const types = @import("types");

parse_mode: ?enums.ParseMode = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_sending_without_reply: ?bool = null,
link_preview_options: ?types.LinkPreviewOptions = null,
show_caption_above_media: ?bool = null,

link_preview_is_disabled: ?bool = null,
link_preview_prefer_small_media: ?bool = null,
link_preview_prefer_large_media: ?bool = null,
link_preview_show_above_text: ?bool = null,

pub fn resolve(self: *@This()) void {
    if (self.link_preview_options != null) return;

    if (self.link_preview_is_disabled != null or
        self.link_preview_prefer_small_media != null or
        self.link_preview_prefer_large_media != null or
        self.link_preview_show_above_text != null)
    {
        self.link_preview_options = .{
            .is_disabled = self.link_preview_is_disabled,
            .prefer_small_media = self.link_preview_prefer_small_media,
            .prefer_large_media = self.link_preview_prefer_large_media,
            .show_above_text = self.link_preview_show_above_text,
        };
    }
}
