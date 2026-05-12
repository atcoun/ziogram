const Bot = @This();

const std = @import("std");

const enums = @import("enums");
const methods = @import("methods");
const types = @import("types");

const ClientSession = @import("../client/session/client.zig");

const extractBotId = @import("../utils/token.zig").extractBotId;

id: i64,
token: []const u8,
session: *ClientSession,

pub fn init(token: []const u8, session: *ClientSession) !Bot {
    const bot_id = try extractBotId(token);
    const allocator = session.allocator;
    return .{
        .id = bot_id,
        .token = try allocator.dupe(u8, token),
        .session = session,
    };
}

pub fn deinit(self: *Bot) void {
    self.session.allocator.free(self.token);
}

pub fn downloadFile(
    self: Bot,
    arena: *std.heap.ArenaAllocator,
    file_path: []const u8,
    writer: *std.Io.Writer,
) !void {
    if (self.session.options.api.is_local) {
        const local_path = try self.session.options.api.wrap_local_file.toLocal(arena.allocator(), file_path);

        const file = try std.Io.Dir.openFile(.cwd(), self.session.io, local_path, .{});
        defer file.close(self.session.io);

        var read_buf: [64 * 1024]u8 = undefined;
        var file_reader = file.reader(self.session.io, &read_buf);

        _ = try writer.sendFileReadingAll(&file_reader, .unlimited);
        return;
    }

    const url_str = try self.session.options.api.fileUrl(arena.allocator(), self.token, file_path);
    return self.session.streamContent(url_str, writer);
}

pub fn download(
    self: Bot,
    arena: *std.heap.ArenaAllocator,
    file_id: []const u8,
    writer: *std.Io.Writer,
) !void {
    const file = try self.getFile(arena, .{ .file_id = file_id });
    const path = file.file_path orelse return error.TelegramFileTooLarge;
    return self.downloadFile(arena, path, writer);
}

pub fn call(
    self: *const Bot,
    allocator: std.mem.Allocator,
    method: anytype,
    request_timeout: ?i32,
) !@TypeOf(method).Result {
    return self.session.makeRequest(
        allocator,
        self.*,
        method,
        request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#addstickertoset
pub fn addStickerToSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        name: []const u8,
        sticker: types.InputSticker,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.AddStickerToSet{
            .user_id = options.user_id,
            .name = options.name,
            .sticker = options.sticker,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#answercallbackquery
pub fn answerCallbackQuery(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        callback_query_id: []const u8,
        text: ?[]const u8 = null,
        show_alert: ?bool = null,
        url: ?[]const u8 = null,
        cache_time: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.AnswerCallbackQuery{
            .callback_query_id = options.callback_query_id,
            .text = options.text,
            .show_alert = options.show_alert,
            .url = options.url,
            .cache_time = options.cache_time,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#answer_guest_query
pub fn answerGuestQuery(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        guest_query_id: []const u8,
        result: types.InlineQueryResult,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.AnswerGuestQuery{
            .guest_query_id = options.guest_query_id,
            .result = options.result,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#answerinlinequery
pub fn answerInlineQuery(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        inline_query_id: []const u8,
        results: []const types.InlineQueryResult,
        cache_time: ?i32 = null,
        is_personal: ?bool = null,
        next_offset: ?[]const u8 = null,
        button: ?types.InlineQueryResultsButton = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.AnswerInlineQuery{
            .inline_query_id = options.inline_query_id,
            .results = options.results,
            .cache_time = options.cache_time,
            .is_personal = options.is_personal,
            .next_offset = options.next_offset,
            .button = options.button,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#answerprecheckoutquery
pub fn answerPreCheckoutQuery(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        pre_checkout_query_id: []const u8,
        ok: bool,
        error_message: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.AnswerPreCheckoutQuery{
            .pre_checkout_query_id = options.pre_checkout_query_id,
            .ok = options.ok,
            .error_message = options.error_message,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#answershippingquery
pub fn answerShippingQuery(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        shipping_query_id: []const u8,
        ok: bool,
        shipping_options: ?[]const types.ShippingOption = null,
        error_message: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.AnswerShippingQuery{
            .shipping_query_id = options.shipping_query_id,
            .ok = options.ok,
            .shipping_options = options.shipping_options,
            .error_message = options.error_message,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#answerwebappquery
pub fn answerWebAppQuery(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        web_app_query_id: []const u8,
        result: types.InlineQueryResult,
        request_timeout: ?i32 = null,
    },
) !types.SentWebAppMessage {
    return self.call(
        arena.allocator(),
        methods.AnswerWebAppQuery{
            .web_app_query_id = options.web_app_query_id,
            .result = options.result,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#approvechatjoinrequest
pub fn approveChatJoinRequest(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ApproveChatJoinRequest{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#approvesuggestedpost
pub fn approveSuggestedPost(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: i64,
        message_id: i32,
        send_date: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ApproveSuggestedPost{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .send_date = options.send_date,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#banchatmember
pub fn banChatMember(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        until_date: ?i32 = null,
        revoke_messages: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.BanChatMember{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .until_date = options.until_date,
            .revoke_messages = options.revoke_messages,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#banchatsenderchat
pub fn banChatSenderChat(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        sender_chat_id: i64,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.BanChatSenderChat{
            .chat_id = options.chat_id,
            .sender_chat_id = options.sender_chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#closeforumtopic
pub fn closeForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_thread_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.CloseForumTopic{
            .chat_id = options.chat_id,
            .message_thread_id = options.message_thread_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#closegeneralforumtopic
pub fn closeGeneralForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.CloseGeneralForumTopic{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#close
pub fn close(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.Close{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#convertgifttostars
pub fn convertGiftToStars(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        owned_gift_id: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ConvertGiftToStars{
            .business_connection_id = options.business_connection_id,
            .owned_gift_id = options.owned_gift_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#copymessage
pub fn copyMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        from_chat_id: types.ChatId,
        message_id: i32,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        video_start_timestamp: ?i32 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageId {
    return self.call(
        arena.allocator(),
        methods.CopyMessage{
            .chat_id = options.chat_id,
            .from_chat_id = options.from_chat_id,
            .message_id = options.message_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .video_start_timestamp = options.video_start_timestamp,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#copymessages
pub fn copyMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        from_chat_id: types.ChatId,
        message_ids: []const i32,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        remove_caption: ?bool = null,
        request_timeout: ?i32 = null,
    },
) ![]const types.MessageId {
    return self.call(
        arena.allocator(),
        methods.CopyMessages{
            .chat_id = options.chat_id,
            .from_chat_id = options.from_chat_id,
            .message_ids = options.message_ids,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .remove_caption = options.remove_caption,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#createchatinvitelink
pub fn createChatInviteLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        name: ?[]const u8 = null,
        expire_date: ?i32 = null,
        member_limit: ?i32 = null,
        creates_join_request: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !types.ChatInviteLink {
    return self.call(
        arena.allocator(),
        methods.CreateChatInviteLink{
            .chat_id = options.chat_id,
            .name = options.name,
            .expire_date = options.expire_date,
            .member_limit = options.member_limit,
            .creates_join_request = options.creates_join_request,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#createchatsubscriptioninvitelink
pub fn createChatSubscriptionInviteLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        subscription_period: i32,
        subscription_price: i32,
        name: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.ChatInviteLink {
    return self.call(
        arena.allocator(),
        methods.CreateChatSubscriptionInviteLink{
            .chat_id = options.chat_id,
            .subscription_period = options.subscription_period,
            .subscription_price = options.subscription_price,
            .name = options.name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#createforumtopic
pub fn createForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        name: []const u8,
        icon_color: ?i32 = null,
        icon_custom_emoji_id: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.ForumTopic {
    return self.call(
        arena.allocator(),
        methods.CreateForumTopic{
            .chat_id = options.chat_id,
            .name = options.name,
            .icon_color = options.icon_color,
            .icon_custom_emoji_id = options.icon_custom_emoji_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#createinvoicelink
pub fn createInvoiceLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        title: []const u8,
        description: []const u8,
        payload: []const u8,
        currency: []const u8,
        prices: []const types.LabeledPrice,
        business_connection_id: ?[]const u8 = null,
        provider_token: ?[]const u8 = null,
        subscription_period: ?i32 = null,
        max_tip_amount: ?i32 = null,
        suggested_tip_amounts: ?[]const i32 = null,
        provider_data: ?[]const u8 = null,
        photo_url: ?[]const u8 = null,
        photo_size: ?i32 = null,
        photo_width: ?i32 = null,
        photo_height: ?i32 = null,
        need_name: ?bool = null,
        need_phone_number: ?bool = null,
        need_email: ?bool = null,
        need_shipping_address: ?bool = null,
        send_phone_number_to_provider: ?bool = null,
        send_email_to_provider: ?bool = null,
        is_flexible: ?bool = null,
        request_timeout: ?i32 = null,
    },
) ![]const u8 {
    return self.call(
        arena.allocator(),
        methods.CreateInvoiceLink{
            .title = options.title,
            .description = options.description,
            .payload = options.payload,
            .currency = options.currency,
            .prices = options.prices,
            .business_connection_id = options.business_connection_id,
            .provider_token = options.provider_token,
            .subscription_period = options.subscription_period,
            .max_tip_amount = options.max_tip_amount,
            .suggested_tip_amounts = options.suggested_tip_amounts,
            .provider_data = options.provider_data,
            .photo_url = options.photo_url,
            .photo_size = options.photo_size,
            .photo_width = options.photo_width,
            .photo_height = options.photo_height,
            .need_name = options.need_name,
            .need_phone_number = options.need_phone_number,
            .need_email = options.need_email,
            .need_shipping_address = options.need_shipping_address,
            .send_phone_number_to_provider = options.send_phone_number_to_provider,
            .send_email_to_provider = options.send_email_to_provider,
            .is_flexible = options.is_flexible,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#createnewstickerset
pub fn createNewStickerSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        name: []const u8,
        title: []const u8,
        stickers: []const types.InputSticker,
        sticker_type: ?enums.StickerType = null,
        needs_repainting: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.CreateNewStickerSet{
            .user_id = options.user_id,
            .name = options.name,
            .title = options.title,
            .stickers = options.stickers,
            .sticker_type = options.sticker_type,
            .needs_repainting = options.needs_repainting,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#declinechatjoinrequest
pub fn declineChatJoinRequest(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeclineChatJoinRequest{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#declinesuggestedpost
pub fn declineSuggestedPost(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: i64,
        message_id: i32,
        comment: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeclineSuggestedPost{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .comment = options.comment,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deleteallmessagereactions
pub fn deleteAllMessageReactions(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: ?i64 = null,
        actor_chat_id: ?i64 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteAllMessageReactions{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .actor_chat_id = options.actor_chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletebusinessmessages
pub fn deleteBusinessMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        message_ids: []const i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteBusinessMessages{
            .business_connection_id = options.business_connection_id,
            .message_ids = options.message_ids,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletechatphoto
pub fn deleteChatPhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteChatPhoto{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletechatstickerset
pub fn deleteChatStickerSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteChatStickerSet{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deleteforumtopic
pub fn deleteForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_thread_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteForumTopic{
            .chat_id = options.chat_id,
            .message_thread_id = options.message_thread_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletemessagereaction
pub fn deleteMessageReaction(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_id: i32,
        user_id: ?i64 = null,
        actor_chat_id: ?i64 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteMessageReaction{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .user_id = options.user_id,
            .actor_chat_id = options.actor_chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletemessage
pub fn deleteMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteMessage{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletemessages
pub fn deleteMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_ids: []const i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteMessages{
            .chat_id = options.chat_id,
            .message_ids = options.message_ids,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletemycommands
pub fn deleteMyCommands(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        scope: ?types.BotCommandScope = null,
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteMyCommands{
            .scope = options.scope,
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletestickerfromset
pub fn deleteStickerFromSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        sticker: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteStickerFromSet{
            .sticker = options.sticker,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletestickerset
pub fn deleteStickerSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        name: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteStickerSet{
            .name = options.name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletestory
pub fn deleteStory(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        story_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteStory{
            .business_connection_id = options.business_connection_id,
            .story_id = options.story_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#deletewebhook
pub fn deleteWebhook(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        drop_pending_updates: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.DeleteWebhook{
            .drop_pending_updates = options.drop_pending_updates,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editchatinvitelink
pub fn editChatInviteLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        invite_link: []const u8,
        name: ?[]const u8 = null,
        expire_date: ?i32 = null,
        member_limit: ?i32 = null,
        creates_join_request: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !types.ChatInviteLink {
    return self.call(
        arena.allocator(),
        methods.EditChatInviteLink{
            .chat_id = options.chat_id,
            .invite_link = options.invite_link,
            .name = options.name,
            .expire_date = options.expire_date,
            .member_limit = options.member_limit,
            .creates_join_request = options.creates_join_request,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editchatsubscriptioninvitelink
pub fn editChatSubscriptionInviteLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        invite_link: []const u8,
        name: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.ChatInviteLink {
    return self.call(
        arena.allocator(),
        methods.EditChatSubscriptionInviteLink{
            .chat_id = options.chat_id,
            .invite_link = options.invite_link,
            .name = options.name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editforumtopic
pub fn editForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_thread_id: i32,
        name: ?[]const u8 = null,
        icon_custom_emoji_id: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.EditForumTopic{
            .chat_id = options.chat_id,
            .message_thread_id = options.message_thread_id,
            .name = options.name,
            .icon_custom_emoji_id = options.icon_custom_emoji_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editgeneralforumtopic
pub fn editGeneralForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        name: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.EditGeneralForumTopic{
            .chat_id = options.chat_id,
            .name = options.name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editmessagecaption
pub fn editMessageCaption(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: ?[]const u8 = null,
        chat_id: ?types.ChatId = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.EditMessageCaption{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editmessagechecklist
pub fn editMessageChecklist(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        chat_id: i64,
        message_id: i32,
        checklist: types.InputChecklist,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.EditMessageChecklist{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .checklist = options.checklist,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editmessagelivelocation
pub fn editMessageLiveLocation(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        latitude: f64,
        longitude: f64,
        business_connection_id: ?[]const u8 = null,
        chat_id: ?types.ChatId = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        live_period: ?i32 = null,
        horizontal_accuracy: ?f64 = null,
        heading: ?i32 = null,
        proximity_alert_radius: ?i32 = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.EditMessageLiveLocation{
            .latitude = options.latitude,
            .longitude = options.longitude,
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
            .live_period = options.live_period,
            .horizontal_accuracy = options.horizontal_accuracy,
            .heading = options.heading,
            .proximity_alert_radius = options.proximity_alert_radius,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editmessagemedia
pub fn editMessageMedia(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        media: types.InputMedia,
        business_connection_id: ?[]const u8 = null,
        chat_id: ?types.ChatId = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.EditMessageMedia{
            .media = options.media,
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editmessagereplymarkup
pub fn editMessageReplyMarkup(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: ?[]const u8 = null,
        chat_id: ?types.ChatId = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.EditMessageReplyMarkup{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editmessagetext
pub fn editMessageText(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        text: []const u8,
        business_connection_id: ?[]const u8 = null,
        chat_id: ?types.ChatId = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        entities: ?[]const types.MessageEntity = null,
        link_preview_options: ?types.LinkPreviewOptions = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.EditMessageText{
            .text = options.text,
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
            .parse_mode = options.parse_mode,
            .entities = options.entities,
            .link_preview_options = options.link_preview_options,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#editstory
pub fn editStory(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        story_id: i32,
        content: ?types.InputStoryContent = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        areas: ?[]const types.StoryArea = null,
        request_timeout: ?i32 = null,
    },
) !types.Story {
    return self.call(
        arena.allocator(),
        methods.EditStory{
            .business_connection_id = options.business_connection_id,
            .story_id = options.story_id,
            .content = options.content,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .areas = options.areas,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#edituserstarsubscription
pub fn editUserStarSubscription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        telegram_payment_charge_id: []const u8,
        is_canceled: bool,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.EditUserStarSubscription{
            .user_id = options.user_id,
            .telegram_payment_charge_id = options.telegram_payment_charge_id,
            .is_canceled = options.is_canceled,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#exportchatinvitelink
pub fn exportChatInviteLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) ![]const u8 {
    return self.call(
        arena.allocator(),
        methods.ExportChatInviteLink{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#forwardmessage
pub fn forwardMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        from_chat_id: types.ChatId,
        message_id: i32,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        video_start_timestamp: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.ForwardMessage{
            .chat_id = options.chat_id,
            .from_chat_id = options.from_chat_id,
            .message_id = options.message_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .video_start_timestamp = options.video_start_timestamp,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#forwardmessages
pub fn forwardMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        from_chat_id: types.ChatId,
        message_ids: []const i32,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        request_timeout: ?i32 = null,
    },
) ![]const types.MessageId {
    return self.call(
        arena.allocator(),
        methods.ForwardMessages{
            .chat_id = options.chat_id,
            .from_chat_id = options.from_chat_id,
            .message_ids = options.message_ids,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getavailablegifts
pub fn getAvailableGifts(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !types.Gifts {
    return self.call(
        arena.allocator(),
        methods.GetAvailableGifts{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getbusinessaccountgifts
pub fn getBusinessAccountGifts(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        exclude_unsaved: ?bool = null,
        exclude_saved: ?bool = null,
        exclude_unlimited: ?bool = null,
        exclude_limited_upgradable: ?bool = null,
        exclude_limited_non_upgradable: ?bool = null,
        exclude_unique: ?bool = null,
        exclude_from_blockchain: ?bool = null,
        sort_by_price: ?bool = null,
        offset: ?[]const u8 = null,
        limit: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !types.OwnedGifts {
    return self.call(
        arena.allocator(),
        methods.GetBusinessAccountGifts{
            .business_connection_id = options.business_connection_id,
            .exclude_unsaved = options.exclude_unsaved,
            .exclude_saved = options.exclude_saved,
            .exclude_unlimited = options.exclude_unlimited,
            .exclude_limited_upgradable = options.exclude_limited_upgradable,
            .exclude_limited_non_upgradable = options.exclude_limited_non_upgradable,
            .exclude_unique = options.exclude_unique,
            .exclude_from_blockchain = options.exclude_from_blockchain,
            .sort_by_price = options.sort_by_price,
            .offset = options.offset,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getbusinessaccountstarbalance
pub fn getBusinessAccountStarBalance(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        request_timeout: ?i32 = null,
    },
) !types.StarAmount {
    return self.call(
        arena.allocator(),
        methods.GetBusinessAccountStarBalance{
            .business_connection_id = options.business_connection_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getbusinessconnection
pub fn getBusinessConnection(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        request_timeout: ?i32 = null,
    },
) !types.BusinessConnection {
    return self.call(
        arena.allocator(),
        methods.GetBusinessConnection{
            .business_connection_id = options.business_connection_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getchatadministrators
pub fn getChatAdministrators(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        return_bots: ?bool = null,
        request_timeout: ?i32 = null,
    },
) ![]const types.ChatMember {
    return self.call(
        arena.allocator(),
        methods.GetChatAdministrators{
            .chat_id = options.chat_id,
            .return_bots = options.return_bots,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getchatgifts
pub fn getChatGifts(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        exclude_unsaved: ?bool = null,
        exclude_saved: ?bool = null,
        exclude_unlimited: ?bool = null,
        exclude_limited_upgradable: ?bool = null,
        exclude_limited_non_upgradable: ?bool = null,
        exclude_from_blockchain: ?bool = null,
        exclude_unique: ?bool = null,
        sort_by_price: ?bool = null,
        offset: ?[]const u8 = null,
        limit: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !types.OwnedGifts {
    return self.call(
        arena.allocator(),
        methods.GetChatGifts{
            .chat_id = options.chat_id,
            .exclude_unsaved = options.exclude_unsaved,
            .exclude_saved = options.exclude_saved,
            .exclude_unlimited = options.exclude_unlimited,
            .exclude_limited_upgradable = options.exclude_limited_upgradable,
            .exclude_limited_non_upgradable = options.exclude_limited_non_upgradable,
            .exclude_from_blockchain = options.exclude_from_blockchain,
            .exclude_unique = options.exclude_unique,
            .sort_by_price = options.sort_by_price,
            .offset = options.offset,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getchatmembercount
pub fn getChatMemberCount(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !i32 {
    return self.call(
        arena.allocator(),
        methods.GetChatMemberCount{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getchatmember
pub fn getChatMember(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) !types.ChatMember {
    return self.call(
        arena.allocator(),
        methods.GetChatMember{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getchatmenubutton
pub fn getChatMenuButton(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: ?i64 = null,
        request_timeout: ?i32 = null,
    },
) !types.MenuButton {
    return self.call(
        arena.allocator(),
        methods.GetChatMenuButton{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getchat
pub fn getChat(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !types.ChatFullInfo {
    return self.call(
        arena.allocator(),
        methods.GetChat{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getcustomemojistickers
pub fn getCustomEmojiStickers(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        custom_emoji_ids: []const []const u8,
        request_timeout: ?i32 = null,
    },
) ![]const types.Sticker {
    return self.call(
        arena.allocator(),
        methods.GetCustomEmojiStickers{
            .custom_emoji_ids = options.custom_emoji_ids,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getfile
pub fn getFile(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        file_id: []const u8,
        request_timeout: ?i32 = null,
    },
) !types.File {
    return self.call(
        arena.allocator(),
        methods.GetFile{
            .file_id = options.file_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getforumtopiciconstickers
pub fn getForumTopicIconStickers(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) ![]const types.Sticker {
    return self.call(
        arena.allocator(),
        methods.GetForumTopicIconStickers{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getgamehighscores
pub fn getGameHighScores(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        chat_id: ?i64 = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) ![]const types.GameHighScore {
    return self.call(
        arena.allocator(),
        methods.GetGameHighScores{
            .user_id = options.user_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmanagedbotaccesssettings
pub fn getManagedBotAccessSettings(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) ![]const types.GameHighScore {
    return self.call(
        arena.allocator(),
        methods.GetManagedBotAccessSettings{
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmanagedbottoken
pub fn getManagedBotToken(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) ![]const u8 {
    return self.call(
        arena.allocator(),
        methods.GetManagedBotToken{
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getme
pub fn getMe(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !types.User {
    return self.call(
        arena.allocator(),
        methods.GetMe{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmycommands
pub fn getMyCommands(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        scope: ?types.BotCommandScope = null,
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) ![]const types.BotCommand {
    return self.call(
        arena.allocator(),
        methods.GetMyCommands{
            .scope = options.scope,
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmydefaultadministratorrights
pub fn getMyDefaultAdministratorRights(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        for_channels: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !types.ChatAdministratorRights {
    return self.call(
        arena.allocator(),
        methods.GetMyDefaultAdministratorRights{
            .for_channels = options.for_channels,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmydescription
pub fn getMyDescription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.BotDescription {
    return self.call(
        arena.allocator(),
        methods.GetMyDescription{
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmyname
pub fn getMyName(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.BotName {
    return self.call(
        arena.allocator(),
        methods.GetMyName{
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmyshortdescription
pub fn getMyShortDescription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.BotShortDescription {
    return self.call(
        arena.allocator(),
        methods.GetMyShortDescription{
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getmystarbalance
pub fn getMyStarBalance(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !types.StarAmount {
    return self.call(
        arena.allocator(),
        methods.GetMyStarBalance{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getstartransactions
pub fn getStarTransactions(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        offset: ?i32 = null,
        limit: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !types.StarTransactions {
    return self.call(
        arena.allocator(),
        methods.GetStarTransactions{
            .offset = options.offset,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getstickerset
pub fn getStickerSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        name: []const u8,
        request_timeout: ?i32 = null,
    },
) !types.StickerSet {
    return self.call(
        arena.allocator(),
        methods.GetStickerSet{
            .name = options.name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getupdates
pub fn getUpdates(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        offset: ?i32 = null,
        limit: ?i32 = null,
        timeout: ?i32 = null,
        allowed_updates: ?[]const enums.UpdateType = null,
        request_timeout: ?i32 = null,
    },
) ![]const types.Update {
    return self.call(
        arena.allocator(),
        methods.GetUpdates{
            .offset = options.offset,
            .limit = options.limit,
            .timeout = options.timeout,
            .allowed_updates = options.allowed_updates,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getuserchatboosts
pub fn getUserChatBoosts(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) !types.UserChatBoosts {
    return self.call(
        arena.allocator(),
        methods.GetUserChatBoosts{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getusergifts
pub fn getUserGifts(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        exclude_unlimited: ?bool = null,
        exclude_limited_upgradable: ?bool = null,
        exclude_limited_non_upgradable: ?bool = null,
        exclude_from_blockchain: ?bool = null,
        exclude_unique: ?bool = null,
        sort_by_price: ?bool = null,
        offset: ?[]const u8 = null,
        limit: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !types.OwnedGifts {
    return self.call(
        arena.allocator(),
        methods.GetUserGifts{
            .user_id = options.user_id,
            .exclude_unlimited = options.exclude_unlimited,
            .exclude_limited_upgradable = options.exclude_limited_upgradable,
            .exclude_limited_non_upgradable = options.exclude_limited_non_upgradable,
            .exclude_from_blockchain = options.exclude_from_blockchain,
            .exclude_unique = options.exclude_unique,
            .sort_by_price = options.sort_by_price,
            .offset = options.offset,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getuserpersonalchatmessages
pub fn getUserPersonalChatMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        limit: i32,
        request_timeout: ?i32 = null,
    },
) !types.OwnedGifts {
    return self.call(
        arena.allocator(),
        methods.GetUserPersonalChatMessages{
            .user_id = options.user_id,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getuserprofileaudios
pub fn getUserProfileAudios(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        offset: ?i32 = null,
        limit: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !types.UserProfileAudios {
    return self.call(
        arena.allocator(),
        methods.GetUserProfileAudios{
            .user_id = options.user_id,
            .offset = options.offset,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getuserprofilephotos
pub fn getUserProfilePhotos(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        offset: ?i32 = null,
        limit: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !types.UserProfilePhotos {
    return self.call(
        arena.allocator(),
        methods.GetUserProfilePhotos{
            .user_id = options.user_id,
            .offset = options.offset,
            .limit = options.limit,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#getwebhookinfo
pub fn getWebhookInfo(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !types.WebhookInfo {
    return self.call(
        arena.allocator(),
        methods.GetWebhookInfo{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#giftpremiumsubscription
pub fn giftPremiumSubscription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        month_count: i32,
        star_count: i32,
        text: ?[]const u8 = null,
        text_parse_mode: ?enums.ParseMode = null,
        text_entities: ?[]const types.MessageEntity = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.GiftPremiumSubscription{
            .user_id = options.user_id,
            .month_count = options.month_count,
            .star_count = options.star_count,
            .text = options.text,
            .text_parse_mode = options.text_parse_mode,
            .text_entities = options.text_entities,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#hidegeneralforumtopic
pub fn hideGeneralForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.HideGeneralForumTopic{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#leavechat
pub fn leaveChat(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.LeaveChat{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#logout
pub fn logOut(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.LogOut{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#pinchatmessage
pub fn pinChatMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_id: i32,
        business_connection_id: ?[]const u8 = null,
        disable_notification: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.PinChatMessage{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .business_connection_id = options.business_connection_id,
            .disable_notification = options.disable_notification,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#poststory
pub fn postStory(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        content: types.InputStoryContent,
        active_period: i32,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        areas: ?[]const types.StoryArea = null,
        post_to_chat_page: ?bool = null,
        protect_content: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !types.Story {
    return self.call(
        arena.allocator(),
        methods.PostStory{
            .business_connection_id = options.business_connection_id,
            .content = options.content,
            .active_period = options.active_period,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .areas = options.areas,
            .post_to_chat_page = options.post_to_chat_page,
            .protect_content = options.protect_content,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#promotechatmember
pub fn promoteChatMember(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        is_anonymous: ?bool = null,
        can_manage_chat: ?bool = null,
        can_delete_messages: ?bool = null,
        can_manage_video_chats: ?bool = null,
        can_restrict_members: ?bool = null,
        can_promote_members: ?bool = null,
        can_change_info: ?bool = null,
        can_invite_users: ?bool = null,
        can_post_stories: ?bool = null,
        can_edit_stories: ?bool = null,
        can_delete_stories: ?bool = null,
        can_post_messages: ?bool = null,
        can_edit_messages: ?bool = null,
        can_pin_messages: ?bool = null,
        can_manage_topics: ?bool = null,
        can_manage_direct_messages: ?bool = null,
        can_manage_tags: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.PromoteChatMember{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .is_anonymous = options.is_anonymous,
            .can_manage_chat = options.can_manage_chat,
            .can_delete_messages = options.can_delete_messages,
            .can_manage_video_chats = options.can_manage_video_chats,
            .can_restrict_members = options.can_restrict_members,
            .can_promote_members = options.can_promote_members,
            .can_change_info = options.can_change_info,
            .can_invite_users = options.can_invite_users,
            .can_post_stories = options.can_post_stories,
            .can_edit_stories = options.can_edit_stories,
            .can_delete_stories = options.can_delete_stories,
            .can_post_messages = options.can_post_messages,
            .can_edit_messages = options.can_edit_messages,
            .can_pin_messages = options.can_pin_messages,
            .can_manage_topics = options.can_manage_topics,
            .can_manage_direct_messages = options.can_manage_direct_messages,
            .can_manage_tags = options.can_manage_tags,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#readbusinessmessage
pub fn readBusinessMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        chat_id: i64,
        message_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ReadBusinessMessage{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#refundstarpayment
pub fn refundStarPayment(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        telegram_payment_charge_id: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.RefundStarPayment{
            .user_id = options.user_id,
            .telegram_payment_charge_id = options.telegram_payment_charge_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#removebusinessaccountprofilephoto
pub fn removeBusinessAccountProfilePhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        is_public: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.RemoveBusinessAccountProfilePhoto{
            .business_connection_id = options.business_connection_id,
            .is_public = options.is_public,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#removechatverification
pub fn removeChatVerification(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.RemoveChatVerification{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#removemyprofilephoto
pub fn removeMyProfilePhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.RemoveMyProfilePhoto{},
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#removeuserverification
pub fn removeUserVerification(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.RemoveUserVerification{
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#reopenforumtopic
pub fn reopenForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_thread_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ReopenForumTopic{
            .chat_id = options.chat_id,
            .message_thread_id = options.message_thread_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#reopengeneralforumtopic
pub fn reopenGeneralForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ReopenGeneralForumTopic{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#replacemanagedbottoken
pub fn replaceManagedBotToken(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        request_timeout: ?i32 = null,
    },
) ![]const u8 {
    return self.call(
        arena.allocator(),
        methods.ReplaceManagedBotToken{
            .user_id = options.user_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#replacestickerinset
pub fn replaceStickerInSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        name: []const u8,
        old_sticker: []const u8,
        sticker: types.InputSticker,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.ReplaceStickerInSet{
            .user_id = options.user_id,
            .name = options.name,
            .old_sticker = options.old_sticker,
            .sticker = options.sticker,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#repoststory
pub fn repostStory(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        from_chat_id: i64,
        from_story_id: i32,
        active_period: i32,
        post_to_chat_page: ?bool = null,
        protect_content: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !types.Story {
    return self.call(
        arena.allocator(),
        methods.RepostStory{
            .business_connection_id = options.business_connection_id,
            .from_chat_id = options.from_chat_id,
            .from_story_id = options.from_story_id,
            .active_period = options.active_period,
            .post_to_chat_page = options.post_to_chat_page,
            .protect_content = options.protect_content,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#restrictchatmember
pub fn restrictChatMember(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        permissions: types.ChatPermissions,
        use_independent_chat_permissions: ?bool = null,
        until_date: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.RestrictChatMember{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .permissions = options.permissions,
            .use_independent_chat_permissions = options.use_independent_chat_permissions,
            .until_date = options.until_date,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#revokechatinvitelink
pub fn revokeChatInviteLink(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        invite_link: []const u8,
        request_timeout: ?i32 = null,
    },
) !types.ChatInviteLink {
    return self.call(
        arena.allocator(),
        methods.RevokeChatInviteLink{
            .chat_id = options.chat_id,
            .invite_link = options.invite_link,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#savepreparedinlinemessage
pub fn savePreparedInlineMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        result: types.InlineQueryResult,
        allow_user_chats: ?bool = null,
        allow_bot_chats: ?bool = null,
        allow_group_chats: ?bool = null,
        allow_channel_chats: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !types.PreparedInlineMessage {
    return self.call(
        arena.allocator(),
        methods.SavePreparedInlineMessage{
            .user_id = options.user_id,
            .result = options.result,
            .allow_user_chats = options.allow_user_chats,
            .allow_bot_chats = options.allow_bot_chats,
            .allow_group_chats = options.allow_group_chats,
            .allow_channel_chats = options.allow_channel_chats,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#savepreparedkeyboardbutton
pub fn savePreparedKeyboardButton(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        button: types.KeyboardButton,
        request_timeout: ?i32 = null,
    },
) !types.PreparedKeyboardButton {
    return self.call(
        arena.allocator(),
        methods.SavePreparedKeyboardButton{
            .user_id = options.user_id,
            .button = options.button,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendanimation
pub fn sendAnimation(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        animation: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        duration: ?i32 = null,
        width: ?i32 = null,
        height: ?i32 = null,
        thumbnail: ?types.InputFile = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        has_spoiler: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendAnimation{
            .chat_id = options.chat_id,
            .animation = options.animation,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .duration = options.duration,
            .width = options.width,
            .height = options.height,
            .thumbnail = options.thumbnail,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .has_spoiler = options.has_spoiler,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendaudio
pub fn sendAudio(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        audio: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        duration: ?i32 = null,
        performer: ?[]const u8 = null,
        title: ?[]const u8 = null,
        thumbnail: ?types.InputFile = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendAudio{
            .chat_id = options.chat_id,
            .audio = options.audio,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .duration = options.duration,
            .performer = options.performer,
            .title = options.title,
            .thumbnail = options.thumbnail,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendchataction
pub fn sendChatAction(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        action: enums.ChatAction,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SendChatAction{
            .chat_id = options.chat_id,
            .action = options.action,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendchecklist
pub fn sendChecklist(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        chat_id: types.ChatId,
        checklist: types.InputChecklist,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendChecklist{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .checklist = options.checklist,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .message_effect_id = options.message_effect_id,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendcontact
pub fn sendContact(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        phone_number: []const u8,
        first_name: []const u8,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        last_name: ?[]const u8 = null,
        vcard: ?[]const u8 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendContact{
            .chat_id = options.chat_id,
            .phone_number = options.phone_number,
            .first_name = options.first_name,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .last_name = options.last_name,
            .vcard = options.vcard,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#senddice
pub fn sendDice(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        emoji: ?enums.DiceEmoji = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendDice{
            .chat_id = options.chat_id,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .emoji = options.emoji,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#senddocument
pub fn sendDocument(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        document: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        thumbnail: ?types.InputFile = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        disable_content_type_detection: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendDocument{
            .chat_id = options.chat_id,
            .document = options.document,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .thumbnail = options.thumbnail,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .disable_content_type_detection = options.disable_content_type_detection,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendgame
pub fn sendGame(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: i64,
        game_short_name: []const u8,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendGame{
            .chat_id = options.chat_id,
            .game_short_name = options.game_short_name,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendgift
pub fn sendGift(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        gift_id: []const u8,
        user_id: ?i64 = null,
        chat_id: ?types.ChatId = null,
        pay_for_upgrade: ?bool = null,
        text: ?[]const u8 = null,
        text_parse_mode: ?enums.ParseMode = null,
        text_entities: ?[]const types.MessageEntity = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SendGift{
            .gift_id = options.gift_id,
            .user_id = options.user_id,
            .chat_id = options.chat_id,
            .pay_for_upgrade = options.pay_for_upgrade,
            .text = options.text,
            .text_parse_mode = options.text_parse_mode,
            .text_entities = options.text_entities,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendinvoice
pub fn sendInvoice(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        title: []const u8,
        description: []const u8,
        payload: []const u8,
        currency: []const u8,
        prices: []const types.LabeledPrice,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        provider_token: ?[]const u8 = null,
        max_tip_amount: ?i32 = null,
        suggested_tip_amounts: ?[]const i32 = null,
        start_parameter: ?[]const u8 = null,
        provider_data: ?[]const u8 = null,
        photo_url: ?[]const u8 = null,
        photo_size: ?i32 = null,
        photo_width: ?i32 = null,
        photo_height: ?i32 = null,
        need_name: ?bool = null,
        need_phone_number: ?bool = null,
        need_email: ?bool = null,
        need_shipping_address: ?bool = null,
        send_phone_number_to_provider: ?bool = null,
        send_email_to_provider: ?bool = null,
        is_flexible: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendInvoice{
            .chat_id = options.chat_id,
            .title = options.title,
            .description = options.description,
            .payload = options.payload,
            .currency = options.currency,
            .prices = options.prices,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .provider_token = options.provider_token,
            .max_tip_amount = options.max_tip_amount,
            .suggested_tip_amounts = options.suggested_tip_amounts,
            .start_parameter = options.start_parameter,
            .provider_data = options.provider_data,
            .photo_url = options.photo_url,
            .photo_size = options.photo_size,
            .photo_width = options.photo_width,
            .photo_height = options.photo_height,
            .need_name = options.need_name,
            .need_phone_number = options.need_phone_number,
            .need_email = options.need_email,
            .need_shipping_address = options.need_shipping_address,
            .send_phone_number_to_provider = options.send_phone_number_to_provider,
            .send_email_to_provider = options.send_email_to_provider,
            .is_flexible = options.is_flexible,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendlivephoto
pub fn sendLivePhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: ?[]const u8 = null,
        chat_id: types.ChatId,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        live_photo: types.InputFile,
        photo: types.InputFile,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        has_spoiler: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendLivePhoto{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .live_photo = options.live_photo,
            .photo = options.photo,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .has_spoiler = options.has_spoiler,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendlocation
pub fn sendLocation(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        latitude: f64,
        longitude: f64,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        horizontal_accuracy: ?f64 = null,
        live_period: ?i32 = null,
        heading: ?i32 = null,
        proximity_alert_radius: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendLocation{
            .chat_id = options.chat_id,
            .latitude = options.latitude,
            .longitude = options.longitude,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .horizontal_accuracy = options.horizontal_accuracy,
            .live_period = options.live_period,
            .heading = options.heading,
            .proximity_alert_radius = options.proximity_alert_radius,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendmediagroup
pub fn sendMediaGroup(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        media: []const types.InputMedia,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        reply_parameters: ?types.ReplyParameters = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendMediaGroup{
            .chat_id = options.chat_id,
            .media = options.media,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .reply_parameters = options.reply_parameters,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendmessagedraft
pub fn sendMessageDraft(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: i64,
        draft_id: i32,
        text: []const u8,
        message_thread_id: ?i32 = null,
        parse_mode: ?enums.ParseMode = null,
        entities: ?[]const types.MessageEntity = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SendMessageDraft{
            .chat_id = options.chat_id,
            .draft_id = options.draft_id,
            .text = options.text,
            .message_thread_id = options.message_thread_id,
            .parse_mode = options.parse_mode,
            .entities = options.entities,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendmessage
pub fn sendMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        text: []const u8,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        parse_mode: ?enums.ParseMode = null,
        entities: ?[]const types.MessageEntity = null,
        link_preview_options: ?types.LinkPreviewOptions = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendMessage{
            .chat_id = options.chat_id,
            .text = options.text,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .parse_mode = options.parse_mode,
            .entities = options.entities,
            .link_preview_options = options.link_preview_options,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendpaidmedia
pub fn sendPaidMedia(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        star_count: i32,
        media: []const types.InputPaidMedia,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        payload: ?[]const u8 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendPaidMedia{
            .chat_id = options.chat_id,
            .star_count = options.star_count,
            .media = options.media,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .payload = options.payload,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendphoto
pub fn sendPhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        photo: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        has_spoiler: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendPhoto{
            .chat_id = options.chat_id,
            .photo = options.photo,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .has_spoiler = options.has_spoiler,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendpoll
pub fn sendPoll(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        question: []const u8,
        options: []const types.InputPollOption,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        question_parse_mode: ?enums.ParseMode = null,
        question_entities: ?[]const types.MessageEntity = null,
        is_anonymous: ?bool = null,
        type: ?[]const u8 = null,
        allows_multiple_answers: ?bool = null,
        allows_revoting: ?bool = null,
        shuffle_options: ?bool = null,
        allow_adding_options: ?bool = null,
        hide_results_until_closes: ?bool = null,
        members_only: ?bool = null,
        country_codes: ?[]const []const u8 = null,
        correct_option_ids: ?[]const i32 = null,
        explanation: ?[]const u8 = null,
        explanation_parse_mode: ?enums.ParseMode = null,
        explanation_entities: ?[]const types.MessageEntity = null,
        explanation_media: ?types.InputPollMedia = null,
        open_period: ?i32 = null,
        close_date: ?i32 = null,
        is_closed: ?bool = null,
        description: ?[]const u8 = null,
        description_parse_mode: ?enums.ParseMode = null,
        description_entities: ?[]const types.MessageEntity = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendPoll{
            .chat_id = options.chat_id,
            .question = options.question,
            .options = options.options,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .question_parse_mode = options.question_parse_mode,
            .question_entities = options.question_entities,
            .is_anonymous = options.is_anonymous,
            .type = options.type,
            .allows_multiple_answers = options.allows_multiple_answers,
            .allows_revoting = options.allows_revoting,
            .shuffle_options = options.shuffle_options,
            .allow_adding_options = options.allow_adding_options,
            .hide_results_until_closes = options.hide_results_until_closes,
            .members_only = options.members_only,
            .country_codes = options.country_codes,
            .correct_option_ids = options.correct_option_ids,
            .explanation = options.explanation,
            .explanation_parse_mode = options.explanation_parse_mode,
            .explanation_entities = options.explanation_entities,
            .explanation_media = options.explanation_media,
            .open_period = options.open_period,
            .close_date = options.close_date,
            .is_closed = options.is_closed,
            .description = options.description,
            .description_parse_mode = options.description_parse_mode,
            .description_entities = options.description_entities,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendsticker
pub fn sendSticker(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        sticker: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        emoji: ?[]const u8 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendSticker{
            .chat_id = options.chat_id,
            .sticker = options.sticker,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .emoji = options.emoji,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendvenue
pub fn sendVenue(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        latitude: f64,
        longitude: f64,
        title: []const u8,
        address: []const u8,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        foursquare_id: ?[]const u8 = null,
        foursquare_type: ?[]const u8 = null,
        google_place_id: ?[]const u8 = null,
        google_place_type: ?[]const u8 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendVenue{
            .chat_id = options.chat_id,
            .latitude = options.latitude,
            .longitude = options.longitude,
            .title = options.title,
            .address = options.address,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .foursquare_id = options.foursquare_id,
            .foursquare_type = options.foursquare_type,
            .google_place_id = options.google_place_id,
            .google_place_type = options.google_place_type,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendvideonote
pub fn sendVideoNote(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        video_note: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        duration: ?i32 = null,
        length: ?i32 = null,
        thumbnail: ?types.InputFile = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendVideoNote{
            .chat_id = options.chat_id,
            .video_note = options.video_note,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .duration = options.duration,
            .length = options.length,
            .thumbnail = options.thumbnail,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendvideo
pub fn sendVideo(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        video: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        duration: ?i32 = null,
        width: ?i32 = null,
        height: ?i32 = null,
        thumbnail: ?types.InputFile = null,
        cover: ?types.InputFile = null,
        start_timestamp: ?i32 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        show_caption_above_media: ?bool = null,
        has_spoiler: ?bool = null,
        supports_streaming: ?bool = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendVideo{
            .chat_id = options.chat_id,
            .video = options.video,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .duration = options.duration,
            .width = options.width,
            .height = options.height,
            .thumbnail = options.thumbnail,
            .cover = options.cover,
            .start_timestamp = options.start_timestamp,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .show_caption_above_media = options.show_caption_above_media,
            .has_spoiler = options.has_spoiler,
            .supports_streaming = options.supports_streaming,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#sendvoice
pub fn sendVoice(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        voice: types.InputFile,
        business_connection_id: ?[]const u8 = null,
        message_thread_id: ?i32 = null,
        direct_messages_topic_id: ?i32 = null,
        caption: ?[]const u8 = null,
        parse_mode: ?enums.ParseMode = null,
        caption_entities: ?[]const types.MessageEntity = null,
        duration: ?i32 = null,
        disable_notification: ?bool = null,
        protect_content: ?bool = null,
        allow_paid_broadcast: ?bool = null,
        message_effect_id: ?[]const u8 = null,
        suggested_post_parameters: ?types.SuggestedPostParameters = null,
        reply_parameters: ?types.ReplyParameters = null,
        reply_markup: ?types.ReplyMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Message {
    return self.call(
        arena.allocator(),
        methods.SendVoice{
            .chat_id = options.chat_id,
            .voice = options.voice,
            .business_connection_id = options.business_connection_id,
            .message_thread_id = options.message_thread_id,
            .direct_messages_topic_id = options.direct_messages_topic_id,
            .caption = options.caption,
            .parse_mode = options.parse_mode,
            .caption_entities = options.caption_entities,
            .duration = options.duration,
            .disable_notification = options.disable_notification,
            .protect_content = options.protect_content,
            .allow_paid_broadcast = options.allow_paid_broadcast,
            .message_effect_id = options.message_effect_id,
            .suggested_post_parameters = options.suggested_post_parameters,
            .reply_parameters = options.reply_parameters,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountbio
pub fn setBusinessAccountBio(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        bio: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetBusinessAccountBio{
            .business_connection_id = options.business_connection_id,
            .bio = options.bio,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountgiftsettings
pub fn setBusinessAccountGiftSettings(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        show_gift_button: bool,
        accepted_gift_types: types.AcceptedGiftTypes,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetBusinessAccountGiftSettings{
            .business_connection_id = options.business_connection_id,
            .show_gift_button = options.show_gift_button,
            .accepted_gift_types = options.accepted_gift_types,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountname
pub fn setBusinessAccountName(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        first_name: []const u8,
        last_name: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetBusinessAccountName{
            .business_connection_id = options.business_connection_id,
            .first_name = options.first_name,
            .last_name = options.last_name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountprofilephoto
pub fn setBusinessAccountProfilePhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        photo: types.InputProfilePhoto,
        is_public: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetBusinessAccountProfilePhoto{
            .business_connection_id = options.business_connection_id,
            .photo = options.photo,
            .is_public = options.is_public,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountusername
pub fn setBusinessAccountUsername(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        username: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetBusinessAccountUsername{
            .business_connection_id = options.business_connection_id,
            .username = options.username,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatadministratorcustomtitle
pub fn setChatAdministratorCustomTitle(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        custom_title: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatAdministratorCustomTitle{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .custom_title = options.custom_title,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatdescription
pub fn setChatDescription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        description: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatDescription{
            .chat_id = options.chat_id,
            .description = options.description,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatmembertag
pub fn setChatMemberTag(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        tag: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatMemberTag{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .tag = options.tag,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatmenubutton
pub fn setChatMenuButton(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: ?i64 = null,
        menu_button: ?types.MenuButton = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatMenuButton{
            .chat_id = options.chat_id,
            .menu_button = options.menu_button,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatpermissions
pub fn setChatPermissions(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        permissions: types.ChatPermissions,
        use_independent_chat_permissions: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatPermissions{
            .chat_id = options.chat_id,
            .permissions = options.permissions,
            .use_independent_chat_permissions = options.use_independent_chat_permissions,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatphoto
pub fn setChatPhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        photo: types.InputFile,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatPhoto{
            .chat_id = options.chat_id,
            .photo = options.photo,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchatstickerset
pub fn setChatStickerSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        sticker_set_name: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatStickerSet{
            .chat_id = options.chat_id,
            .sticker_set_name = options.sticker_set_name,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setchattitle
pub fn setChatTitle(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        title: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetChatTitle{
            .chat_id = options.chat_id,
            .title = options.title,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setcustomemojistickersetthumbnail
pub fn setCustomEmojiStickerSetThumbnail(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        name: []const u8,
        custom_emoji_id: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetCustomEmojiStickerSetThumbnail{
            .name = options.name,
            .custom_emoji_id = options.custom_emoji_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setgamescore
pub fn setGameScore(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        score: i32,
        force: ?bool = null,
        disable_edit_message: ?bool = null,
        chat_id: ?i64 = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.SetGameScore{
            .user_id = options.user_id,
            .score = options.score,
            .force = options.force,
            .disable_edit_message = options.disable_edit_message,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmanagedbotaccesssettings
pub fn setManagedBotAccessSettings(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        is_access_restricted: bool,
        added_user_ids: ?[]const i64 = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.SetManagedBotAccessSettings{
            .user_id = options.user_id,
            .is_access_restricted = options.is_access_restricted,
            .added_user_ids = options.added_user_ids,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmessagereaction
pub fn setMessageReaction(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_id: i32,
        reaction: ?[]const types.ReactionType = null,
        is_big: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMessageReaction{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .reaction = options.reaction,
            .is_big = options.is_big,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmycommands
pub fn setMyCommands(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        commands: []const types.BotCommand,
        scope: ?types.BotCommandScope = null,
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMyCommands{
            .commands = options.commands,
            .scope = options.scope,
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmydefaultadministratorrights
pub fn setMyDefaultAdministratorRights(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        rights: ?types.ChatAdministratorRights = null,
        for_channels: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMyDefaultAdministratorRights{
            .rights = options.rights,
            .for_channels = options.for_channels,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmydescription
pub fn setMyDescription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        description: ?[]const u8 = null,
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMyDescription{
            .description = options.description,
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmyname
pub fn setMyName(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        name: ?[]const u8 = null,
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMyName{
            .name = options.name,
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmyprofilephoto
pub fn setMyProfilePhoto(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        photo: types.InputProfilePhoto,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMyProfilePhoto{
            .photo = options.photo,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setmyshortdescription
pub fn setMyShortDescription(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        short_description: ?[]const u8 = null,
        language_code: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetMyShortDescription{
            .short_description = options.short_description,
            .language_code = options.language_code,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setpassportdataerrors
pub fn setPassportDataErrors(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        errors: []const types.PassportElementError,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetPassportDataErrors{
            .user_id = options.user_id,
            .errors = options.errors,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setstickeremojilist
pub fn setStickerEmojiList(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        sticker: []const u8,
        emoji_list: []const []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetStickerEmojiList{
            .sticker = options.sticker,
            .emoji_list = options.emoji_list,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setstickerkeywords
pub fn setStickerKeywords(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        sticker: []const u8,
        keywords: ?[]const []const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetStickerKeywords{
            .sticker = options.sticker,
            .keywords = options.keywords,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setstickermaskposition
pub fn setStickerMaskPosition(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        sticker: []const u8,
        mask_position: ?types.MaskPosition = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetStickerMaskPosition{
            .sticker = options.sticker,
            .mask_position = options.mask_position,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setstickerpositioninset
pub fn setStickerPositionInSet(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        sticker: []const u8,
        position: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetStickerPositionInSet{
            .sticker = options.sticker,
            .position = options.position,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setstickersetthumbnail
pub fn setStickerSetThumbnail(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        name: []const u8,
        user_id: i64,
        format: enums.StickerFormat,
        thumbnail: ?types.InputFile = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetStickerSetThumbnail{
            .name = options.name,
            .user_id = options.user_id,
            .format = options.format,
            .thumbnail = options.thumbnail,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setstickersettitle
pub fn setStickerSetTitle(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        name: []const u8,
        title: []const u8,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetStickerSetTitle{
            .name = options.name,
            .title = options.title,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setuseremojistatus
pub fn setUserEmojiStatus(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        emoji_status_custom_emoji_id: ?[]const u8 = null,
        emoji_status_expiration_date: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetUserEmojiStatus{
            .user_id = options.user_id,
            .emoji_status_custom_emoji_id = options.emoji_status_custom_emoji_id,
            .emoji_status_expiration_date = options.emoji_status_expiration_date,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#setwebhook
pub fn setWebhook(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        url: []const u8,
        certificate: ?types.InputFile = null,
        ip_address: ?[]const u8 = null,
        max_connections: ?i32 = null,
        allowed_updates: ?[]const enums.UpdateType = null,
        drop_pending_updates: ?bool = null,
        secret_token: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SetWebhook{
            .url = options.url,
            .certificate = options.certificate,
            .ip_address = options.ip_address,
            .max_connections = options.max_connections,
            .allowed_updates = options.allowed_updates,
            .drop_pending_updates = options.drop_pending_updates,
            .secret_token = options.secret_token,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#stopmessagelivelocation
pub fn stopMessageLiveLocation(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: ?[]const u8 = null,
        chat_id: ?types.ChatId = null,
        message_id: ?i32 = null,
        inline_message_id: ?[]const u8 = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.MessageOrBool {
    return self.call(
        arena.allocator(),
        methods.StopMessageLiveLocation{
            .business_connection_id = options.business_connection_id,
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .inline_message_id = options.inline_message_id,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#stoppoll
pub fn stopPoll(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_id: i32,
        business_connection_id: ?[]const u8 = null,
        reply_markup: ?types.InlineKeyboardMarkup = null,
        request_timeout: ?i32 = null,
    },
) !types.Poll {
    return self.call(
        arena.allocator(),
        methods.StopPoll{
            .chat_id = options.chat_id,
            .message_id = options.message_id,
            .business_connection_id = options.business_connection_id,
            .reply_markup = options.reply_markup,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#transferbusinessaccountstars
pub fn transferBusinessAccountStars(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        star_count: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.TransferBusinessAccountStars{
            .business_connection_id = options.business_connection_id,
            .star_count = options.star_count,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#transfergift
pub fn transferGift(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        owned_gift_id: []const u8,
        new_owner_chat_id: i64,
        star_count: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.TransferGift{
            .business_connection_id = options.business_connection_id,
            .owned_gift_id = options.owned_gift_id,
            .new_owner_chat_id = options.new_owner_chat_id,
            .star_count = options.star_count,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unbanchatmember
pub fn unbanChatMember(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        user_id: i64,
        only_if_banned: ?bool = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnbanChatMember{
            .chat_id = options.chat_id,
            .user_id = options.user_id,
            .only_if_banned = options.only_if_banned,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unbanchatsenderchat
pub fn unbanChatSenderChat(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        sender_chat_id: i64,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnbanChatSenderChat{
            .chat_id = options.chat_id,
            .sender_chat_id = options.sender_chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unhidegeneralforumtopic
pub fn unhideGeneralForumTopic(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnhideGeneralForumTopic{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unpinallchatmessages
pub fn unpinAllChatMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnpinAllChatMessages{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unpinallforumtopicmessages
pub fn unpinAllForumTopicMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        message_thread_id: i32,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnpinAllForumTopicMessages{
            .chat_id = options.chat_id,
            .message_thread_id = options.message_thread_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unpinallgeneralforumtopicmessages
pub fn unpinAllGeneralForumTopicMessages(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnpinAllGeneralForumTopicMessages{
            .chat_id = options.chat_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#unpinchatmessage
pub fn unpinChatMessage(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        business_connection_id: ?[]const u8 = null,
        message_id: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UnpinChatMessage{
            .chat_id = options.chat_id,
            .business_connection_id = options.business_connection_id,
            .message_id = options.message_id,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#upgradegift
pub fn upgradeGift(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        business_connection_id: []const u8,
        owned_gift_id: []const u8,
        keep_original_details: ?bool = null,
        star_count: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.UpgradeGift{
            .business_connection_id = options.business_connection_id,
            .owned_gift_id = options.owned_gift_id,
            .keep_original_details = options.keep_original_details,
            .star_count = options.star_count,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#uploadstickerfile
pub fn uploadStickerFile(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        sticker: types.InputFile,
        sticker_format: enums.InputStickerFormat,
        request_timeout: ?i32 = null,
    },
) !types.File {
    return self.call(
        arena.allocator(),
        methods.UploadStickerFile{
            .user_id = options.user_id,
            .sticker = options.sticker,
            .sticker_format = options.sticker_format,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#verifychat
pub fn verifyChat(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        custom_description: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.VerifyChat{
            .chat_id = options.chat_id,
            .custom_description = options.custom_description,
        },
        options.request_timeout,
    );
}

/// Source: https://core.telegram.org/bots/api#verifychat
pub fn verifyUser(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        user_id: i64,
        custom_description: ?[]const u8 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.VerifyUser{
            .user_id = options.user_id,
            .custom_description = options.custom_description,
        },
        options.request_timeout,
    );
}
