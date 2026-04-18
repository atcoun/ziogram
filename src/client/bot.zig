const std = @import("std");

const methods = @import("../methods.zig");
const types = @import("../types.zig");

const ClientSession = @import("../client/session/http_client.zig").ClientSession;
const BotOptions = @import("../client/bot_options.zig").BotOptions;

const extractBotId = @import("../utils/token.zig").extractBotId;

pub const Bot = struct {
    allocator: std.mem.Allocator,
    token: []const u8,
    id: i64,
    session: *ClientSession,
    bot_options: ?BotOptions = null,

    pub fn init(token: []const u8, session: *ClientSession, options: ?BotOptions) !Bot {
        const bot_id = try extractBotId(token);

        const allocator = session.allocator;
        var bot_options = options;
        if (bot_options) |*o| o.resolve();
        return Bot{
            .allocator = allocator,
            .token = try allocator.dupe(u8, token),
            .id = bot_id,
            .session = session,
            .bot_options = bot_options,
        };
    }

    pub fn deinit(self: *const Bot) void {
        self.allocator.free(self.token);
    }

    pub fn call(
        self: *const Bot,
        allocator: std.mem.Allocator,
        comptime Method: type,
        method: Method,
    ) !Method.ReturnType {
        return self.session.makeRequest(allocator, self.token, Method, method, self.bot_options);
    }

    pub fn addStickerToSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.AddStickerToSet,
    ) !bool {
        return try self.call(allocator, methods.AddStickerToSet, options);
    }

    pub fn answerCallbackQuery(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.AnswerCallbackQuery,
    ) !bool {
        return try self.call(allocator, methods.AnswerCallbackQuery, options);
    }

    pub fn answerInlineQuery(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.AnswerInlineQuery,
    ) !bool {
        return try self.call(allocator, methods.AnswerInlineQuery, options);
    }

    pub fn answerPreCheckoutQuery(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.AnswerPreCheckoutQuery,
    ) !bool {
        return try self.call(allocator, methods.AnswerPreCheckoutQuery, options);
    }

    pub fn answerShippingQuery(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.AnswerShippingQuery,
    ) !bool {
        return try self.call(allocator, methods.AnswerShippingQuery, options);
    }

    pub fn answerWebAppQuery(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.AnswerWebAppQuery,
    ) !types.SentWebAppMessage {
        return try self.call(allocator, methods.AnswerWebAppQuery, options);
    }

    pub fn approveChatJoinRequest(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ApproveChatJoinRequest,
    ) !bool {
        return try self.call(allocator, methods.ApproveChatJoinRequest, options);
    }

    pub fn approveSuggestedPost(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ApproveSuggestedPost,
    ) !bool {
        return try self.call(allocator, methods.ApproveSuggestedPost, options);
    }

    pub fn banChatMember(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.BanChatMember,
    ) !bool {
        return try self.call(allocator, methods.BanChatMember, options);
    }

    pub fn banChatSenderChat(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.BanChatSenderChat,
    ) !bool {
        return try self.call(allocator, methods.BanChatSenderChat, options);
    }

    pub fn closeForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CloseForumTopic,
    ) !bool {
        return try self.call(allocator, methods.CloseForumTopic, options);
    }

    pub fn closeGeneralForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CloseGeneralForumTopic,
    ) !bool {
        return try self.call(allocator, methods.CloseGeneralForumTopic, options);
    }

    pub fn close(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) !bool {
        return try self.call(allocator, methods.Close, methods.Close{});
    }

    pub fn convertGiftToStars(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ConvertGiftToStars,
    ) !bool {
        return try self.call(allocator, methods.ConvertGiftToStars, options);
    }

    pub fn copyMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CopyMessage,
    ) !types.MessageId {
        return try self.call(allocator, methods.CopyMessage, options);
    }

    pub fn copyMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CopyMessages,
    ) ![]const types.MessageId {
        return try self.call(allocator, methods.CopyMessages, options);
    }

    pub fn createChatInviteLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CreateChatInviteLink,
    ) !types.ChatInviteLink {
        return try self.call(allocator, methods.CreateChatInviteLink, options);
    }

    pub fn createChatSubscriptionInviteLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CreateChatSubscriptionInviteLink,
    ) !types.ChatInviteLink {
        return try self.call(allocator, methods.CreateChatSubscriptionInviteLink, options);
    }

    pub fn createForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CreateForumTopic,
    ) !types.ForumTopic {
        return try self.call(allocator, methods.CreateForumTopic, options);
    }

    pub fn createInvoiceLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CreateInvoiceLink,
    ) ![]const u8 {
        return try self.call(allocator, methods.CreateInvoiceLink, options);
    }

    pub fn createNewStickerSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.CreateNewStickerSet,
    ) !bool {
        return try self.call(allocator, methods.CreateNewStickerSet, options);
    }

    pub fn declineChatJoinRequest(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeclineChatJoinRequest,
    ) !bool {
        return try self.call(allocator, methods.DeclineChatJoinRequest, options);
    }

    pub fn declineSuggestedPost(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeclineSuggestedPost,
    ) !bool {
        return try self.call(allocator, methods.DeclineSuggestedPost, options);
    }

    pub fn deleteBusinessMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteBusinessMessages,
    ) !bool {
        return try self.call(allocator, methods.DeleteBusinessMessages, options);
    }

    pub fn deleteChatPhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteChatPhoto,
    ) !bool {
        return try self.call(allocator, methods.DeleteChatPhoto, options);
    }

    pub fn deleteChatStickerSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteChatStickerSet,
    ) !bool {
        return try self.call(allocator, methods.DeleteChatStickerSet, options);
    }

    pub fn deleteForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteForumTopic,
    ) !bool {
        return try self.call(allocator, methods.DeleteForumTopic, options);
    }

    pub fn deleteMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteMessage,
    ) !bool {
        return try self.call(allocator, methods.DeleteMessage, options);
    }

    pub fn deleteMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteMessages,
    ) !bool {
        return try self.call(allocator, methods.DeleteMessages, options);
    }

    pub fn deleteMyCommands(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteMyCommands,
    ) !bool {
        return try self.call(allocator, methods.DeleteMyCommands, options);
    }

    pub fn deleteStickerFromSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteStickerFromSet,
    ) !bool {
        return try self.call(allocator, methods.DeleteStickerFromSet, options);
    }

    pub fn deleteStickerSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteStickerSet,
    ) !bool {
        return try self.call(allocator, methods.DeleteStickerSet, options);
    }

    pub fn deleteStory(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteStory,
    ) !bool {
        return try self.call(allocator, methods.DeleteStory, options);
    }

    pub fn deleteWebhook(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.DeleteWebhook,
    ) !bool {
        return try self.call(allocator, methods.DeleteWebhook, options);
    }

    pub fn editChatInviteLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditChatInviteLink,
    ) !types.ChatInviteLink {
        return try self.call(allocator, methods.EditChatInviteLink, options);
    }

    pub fn editChatSubscriptionInviteLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditChatSubscriptionInviteLink,
    ) !types.ChatInviteLink {
        return try self.call(allocator, methods.EditChatSubscriptionInviteLink, options);
    }

    pub fn editForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditForumTopic,
    ) !bool {
        return try self.call(allocator, methods.EditForumTopic, options);
    }

    pub fn editGeneralForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditGeneralForumTopic,
    ) !bool {
        return try self.call(allocator, methods.EditGeneralForumTopic, options);
    }

    pub fn editMessageCaption(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditMessageCaption,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.EditMessageCaption, options);
    }

    pub fn editMessageChecklist(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditMessageChecklist,
    ) !types.Message {
        return try self.call(allocator, methods.EditMessageChecklist, options);
    }

    pub fn editMessageLiveLocation(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditMessageLiveLocation,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.EditMessageLiveLocation, options);
    }

    pub fn editMessageMedia(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditMessageMedia,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.EditMessageMedia, options);
    }

    pub fn editMessageReplyMarkup(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditMessageReplyMarkup,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.EditMessageReplyMarkup, options);
    }

    pub fn editMessageText(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditMessageText,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.EditMessageText, options);
    }

    pub fn editStory(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditStory,
    ) !types.Story {
        return try self.call(allocator, methods.EditStory, options);
    }

    pub fn editUserStarSubscription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.EditUserStarSubscription,
    ) !bool {
        return try self.call(allocator, methods.EditUserStarSubscription, options);
    }

    pub fn exportChatInviteLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ExportChatInviteLink,
    ) ![]const u8 {
        return try self.call(allocator, methods.ExportChatInviteLink, options);
    }

    pub fn forwardMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ForwardMessage,
    ) !types.Message {
        return try self.call(allocator, methods.ForwardMessage, options);
    }

    pub fn forwardMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ForwardMessages,
    ) ![]const types.MessageId {
        return try self.call(allocator, methods.ForwardMessages, options);
    }

    pub fn getAvailableGifts(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) !types.Gifts {
        return try self.call(allocator, methods.GetAvailableGifts, methods.GetAvailableGifts{});
    }

    pub fn getBusinessAccountGifts(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetBusinessAccountGifts,
    ) !types.OwnedGifts {
        return try self.call(allocator, methods.GetBusinessAccountGifts, options);
    }

    pub fn getBusinessAccountStarBalance(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetBusinessAccountStarBalance,
    ) !types.StarAmount {
        return try self.call(allocator, methods.GetBusinessAccountStarBalance, options);
    }

    pub fn getBusinessConnection(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetBusinessConnection,
    ) !types.BusinessConnection {
        return try self.call(allocator, methods.GetBusinessConnection, options);
    }

    pub fn getChatAdministrators(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetChatAdministrators,
    ) ![]const types.ChatMember {
        return try self.call(allocator, methods.GetChatAdministrators, options);
    }

    pub fn getChatGifts(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetChatGifts,
    ) !types.OwnedGifts {
        return try self.call(allocator, methods.GetChatGifts, options);
    }

    pub fn getChatMemberCount(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetChatMemberCount,
    ) !i32 {
        return try self.call(allocator, methods.GetChatMemberCount, options);
    }

    pub fn getChatMember(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetChatMember,
    ) !types.ChatMember {
        return try self.call(allocator, methods.GetChatMember, options);
    }

    pub fn getChatMenuButton(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetChatMenuButton,
    ) !types.MenuButton {
        return try self.call(allocator, methods.GetChatMenuButton, options);
    }

    pub fn getChat(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetChat,
    ) !types.ChatFullInfo {
        return try self.call(allocator, methods.GetChat, options);
    }

    pub fn getCustomEmojiStickers(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetCustomEmojiStickers,
    ) ![]const types.Sticker {
        return try self.call(allocator, methods.GetCustomEmojiStickers, options);
    }

    pub fn getFile(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetFile,
    ) !types.File {
        return try self.call(allocator, methods.GetFile, options);
    }

    pub fn getForumTopicIconStickers(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) ![]const types.Sticker {
        return try self.call(allocator, methods.GetForumTopicIconStickers, methods.GetForumTopicIconStickers{});
    }

    pub fn getGameHighScores(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetGameHighScores,
    ) ![]const types.GameHighScore {
        return try self.call(allocator, methods.GetGameHighScores, options);
    }

    pub fn getManagedBotToken(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetManagedBotToken,
    ) ![]const u8 {
        return try self.call(allocator, methods.GetManagedBotToken, options);
    }

    pub fn getMe(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) !types.User {
        return try self.call(allocator, methods.GetMe, methods.GetMe{});
    }

    pub fn getMyCommands(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetMyCommands,
    ) ![]const types.BotCommand {
        return try self.call(allocator, methods.GetMyCommands, options);
    }

    pub fn getMyDefaultAdministratorRights(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetMyDefaultAdministratorRights,
    ) !types.ChatAdministratorRights {
        return try self.call(allocator, methods.GetMyDefaultAdministratorRights, options);
    }

    pub fn getMyDescription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetMyDescription,
    ) !types.BotDescription {
        return try self.call(allocator, methods.GetMyDescription, options);
    }

    pub fn getMyName(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetMyName,
    ) !types.BotName {
        return try self.call(allocator, methods.GetMyName, options);
    }

    pub fn getMyShortDescription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetMyShortDescription,
    ) !types.BotShortDescription {
        return try self.call(allocator, methods.GetMyShortDescription, options);
    }

    pub fn getMyStarBalance(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) !types.StarAmount {
        return try self.call(allocator, methods.GetMyStarBalance, methods.GetMyStarBalance{});
    }

    pub fn getStarTransactions(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetStarTransactions,
    ) !types.StarTransactions {
        return try self.call(allocator, methods.GetStarTransactions, options);
    }

    pub fn getStickerSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetStickerSet,
    ) !types.StickerSet {
        return try self.call(allocator, methods.GetStickerSet, options);
    }

    pub fn getUpdates(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetUpdates,
    ) ![]const types.Update {
        return try self.call(allocator, methods.GetUpdates, options);
    }

    pub fn getUserChatBoosts(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetUserChatBoosts,
    ) !types.UserChatBoosts {
        return try self.call(allocator, methods.GetUserChatBoosts, options);
    }

    pub fn getUserGifts(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetUserGifts,
    ) !types.OwnedGifts {
        return try self.call(allocator, methods.GetUserGifts, options);
    }

    pub fn getUserProfileAudios(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetUserProfileAudios,
    ) !types.UserProfileAudios {
        return try self.call(allocator, methods.GetUserProfileAudios, options);
    }

    pub fn getUserProfilePhotos(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GetUserProfilePhotos,
    ) !types.UserProfilePhotos {
        return try self.call(allocator, methods.GetUserProfilePhotos, options);
    }

    pub fn giftPremiumSubscription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.GiftPremiumSubscription,
    ) !bool {
        return try self.call(allocator, methods.GiftPremiumSubscription, options);
    }

    pub fn hideGeneralForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.HideGeneralForumTopic,
    ) !bool {
        return try self.call(allocator, methods.HideGeneralForumTopic, options);
    }

    pub fn leaveChat(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.LeaveChat,
    ) !bool {
        return try self.call(allocator, methods.LeaveChat, options);
    }

    pub fn logOut(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) !bool {
        return try self.call(allocator, methods.LogOut, methods.LogOut{});
    }

    pub fn pinChatMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.PinChatMessage,
    ) !bool {
        return try self.call(allocator, methods.PinChatMessage, options);
    }

    pub fn postStory(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.PostStory,
    ) !types.Story {
        return try self.call(allocator, methods.PostStory, options);
    }

    pub fn promoteChatMember(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.PromoteChatMember,
    ) !bool {
        return try self.call(allocator, methods.PromoteChatMember, options);
    }

    pub fn readBusinessMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ReadBusinessMessage,
    ) !bool {
        return try self.call(allocator, methods.ReadBusinessMessage, options);
    }

    pub fn refundStarPayment(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RefundStarPayment,
    ) !bool {
        return try self.call(allocator, methods.RefundStarPayment, options);
    }

    pub fn removeBusinessAccountProfilePhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RemoveBusinessAccountProfilePhoto,
    ) !bool {
        return try self.call(allocator, methods.RemoveBusinessAccountProfilePhoto, options);
    }

    pub fn removeChatVerification(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RemoveChatVerification,
    ) !bool {
        return try self.call(allocator, methods.RemoveChatVerification, options);
    }

    pub fn removeMyProfilePhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
    ) !bool {
        return try self.call(allocator, methods.RemoveMyProfilePhoto, methods.RemoveMyProfilePhoto{});
    }

    pub fn removeUserVerification(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RemoveUserVerification,
    ) !bool {
        return try self.call(allocator, methods.RemoveUserVerification, options);
    }

    pub fn reopenForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ReopenForumTopic,
    ) !bool {
        return try self.call(allocator, methods.ReopenForumTopic, options);
    }

    pub fn reopenGeneralForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ReopenGeneralForumTopic,
    ) !bool {
        return try self.call(allocator, methods.ReopenGeneralForumTopic, options);
    }

    pub fn replaceManagedBotToken(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ReplaceManagedBotToken,
    ) ![]const u8 {
        return try self.call(allocator, methods.ReplaceManagedBotToken, options);
    }

    pub fn replaceStickerInSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.ReplaceStickerInSet,
    ) !bool {
        return try self.call(allocator, methods.ReplaceStickerInSet, options);
    }

    pub fn repostStory(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RepostStory,
    ) !types.Story {
        return try self.call(allocator, methods.RepostStory, options);
    }

    pub fn restrictChatMember(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RestrictChatMember,
    ) !bool {
        return try self.call(allocator, methods.RestrictChatMember, options);
    }

    pub fn revokeChatInviteLink(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.RevokeChatInviteLink,
    ) !types.ChatInviteLink {
        return try self.call(allocator, methods.RevokeChatInviteLink, options);
    }

    pub fn savePreparedInlineMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SavePreparedInlineMessage,
    ) !types.PreparedInlineMessage {
        return try self.call(allocator, methods.SavePreparedInlineMessage, options);
    }

    pub fn savePreparedKeyboardButton(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SavePreparedKeyboardButton,
    ) !types.PreparedKeyboardButton {
        return try self.call(allocator, methods.SavePreparedKeyboardButton, options);
    }

    pub fn sendAnimation(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendAnimation,
    ) !types.Message {
        return try self.call(allocator, methods.SendAnimation, options);
    }

    pub fn sendAudio(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendAudio,
    ) !types.Message {
        return try self.call(allocator, methods.SendAudio, options);
    }

    pub fn sendChatAction(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendChatAction,
    ) !bool {
        return try self.call(allocator, methods.SendChatAction, options);
    }

    pub fn sendChecklist(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendChecklist,
    ) !types.Message {
        return try self.call(allocator, methods.SendChecklist, options);
    }

    pub fn sendContact(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendContact,
    ) !types.Message {
        return try self.call(allocator, methods.SendContact, options);
    }

    pub fn sendDice(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendDice,
    ) !types.Message {
        return try self.call(allocator, methods.SendDice, options);
    }

    pub fn sendDocument(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendDocument,
    ) !types.Message {
        return try self.call(allocator, methods.SendDocument, options);
    }

    pub fn sendGame(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendGame,
    ) !types.Message {
        return try self.call(allocator, methods.SendGame, options);
    }

    pub fn sendGift(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendGift,
    ) !bool {
        return try self.call(allocator, methods.SendGift, options);
    }

    pub fn sendInvoice(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendInvoice,
    ) !types.Message {
        return try self.call(allocator, methods.SendInvoice, options);
    }

    pub fn sendLocation(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendLocation,
    ) !types.Message {
        return try self.call(allocator, methods.SendLocation, options);
    }

    pub fn sendMessageDraft(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendMessageDraft,
    ) !bool {
        return try self.call(allocator, methods.SendMessageDraft, options);
    }

    pub fn sendMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendMessage,
    ) !types.Message {
        return try self.call(allocator, methods.SendMessage, options);
    }

    pub fn sendPaidMedia(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendPaidMedia,
    ) !types.Message {
        return try self.call(allocator, methods.SendPaidMedia, options);
    }

    pub fn sendPhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendPhoto,
    ) !types.Message {
        return try self.call(allocator, methods.SendPhoto, options);
    }

    pub fn sendPoll(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendPoll,
    ) !types.Message {
        return try self.call(allocator, methods.SendPoll, options);
    }

    pub fn sendSticker(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendSticker,
    ) !types.Message {
        return try self.call(allocator, methods.SendSticker, options);
    }

    pub fn sendVenue(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendVenue,
    ) !types.Message {
        return try self.call(allocator, methods.SendVenue, options);
    }

    pub fn sendVideoNote(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendVideoNote,
    ) !types.Message {
        return try self.call(allocator, methods.SendVideoNote, options);
    }

    pub fn sendVideo(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendVideo,
    ) !types.Message {
        return try self.call(allocator, methods.SendVideo, options);
    }

    pub fn sendVoice(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SendVoice,
    ) !types.Message {
        return try self.call(allocator, methods.SendVoice, options);
    }

    pub fn setBusinessAccountBio(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetBusinessAccountBio,
    ) !bool {
        return try self.call(allocator, methods.SetBusinessAccountBio, options);
    }

    pub fn setBusinessAccountGiftSettings(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetBusinessAccountGiftSettings,
    ) !bool {
        return try self.call(allocator, methods.SetBusinessAccountGiftSettings, options);
    }

    pub fn setBusinessAccountName(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetBusinessAccountName,
    ) !bool {
        return try self.call(allocator, methods.SetBusinessAccountName, options);
    }

    pub fn setBusinessAccountProfilePhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetBusinessAccountProfilePhoto,
    ) !bool {
        return try self.call(allocator, methods.SetBusinessAccountProfilePhoto, options);
    }

    pub fn setBusinessAccountUsername(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetBusinessAccountUsername,
    ) !bool {
        return try self.call(allocator, methods.SetBusinessAccountUsername, options);
    }

    pub fn setChatAdministratorCustomTitle(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatAdministratorCustomTitle,
    ) !bool {
        return try self.call(allocator, methods.SetChatAdministratorCustomTitle, options);
    }

    pub fn setChatDescription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatDescription,
    ) !bool {
        return try self.call(allocator, methods.SetChatDescription, options);
    }

    pub fn setChatMemberTag(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatMemberTag,
    ) !bool {
        return try self.call(allocator, methods.SetChatMemberTag, options);
    }

    pub fn setChatMenuButton(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatMenuButton,
    ) !bool {
        return try self.call(allocator, methods.SetChatMenuButton, options);
    }

    pub fn setChatPermissions(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatPermissions,
    ) !bool {
        return try self.call(allocator, methods.SetChatPermissions, options);
    }

    pub fn setChatPhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatPhoto,
    ) !bool {
        return try self.call(allocator, methods.SetChatPhoto, options);
    }

    pub fn setChatStickerSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatStickerSet,
    ) !bool {
        return try self.call(allocator, methods.SetChatStickerSet, options);
    }

    pub fn setChatTitle(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetChatTitle,
    ) !bool {
        return try self.call(allocator, methods.SetChatTitle, options);
    }

    pub fn setCustomEmojiStickerSetThumbnail(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetCustomEmojiStickerSetThumbnail,
    ) !bool {
        return try self.call(allocator, methods.SetCustomEmojiStickerSetThumbnail, options);
    }

    pub fn setGameScore(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetGameScore,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.SetGameScore, options);
    }

    pub fn setMessageReaction(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMessageReaction,
    ) !bool {
        return try self.call(allocator, methods.SetMessageReaction, options);
    }

    pub fn setMyCommands(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMyCommands,
    ) !bool {
        return try self.call(allocator, methods.SetMyCommands, options);
    }

    pub fn setMyDefaultAdministratorRights(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMyDefaultAdministratorRights,
    ) !bool {
        return try self.call(allocator, methods.SetMyDefaultAdministratorRights, options);
    }

    pub fn setMyDescription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMyDescription,
    ) !bool {
        return try self.call(allocator, methods.SetMyDescription, options);
    }

    pub fn setMyName(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMyName,
    ) !bool {
        return try self.call(allocator, methods.SetMyName, options);
    }

    pub fn setMyProfilePhoto(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMyProfilePhoto,
    ) !bool {
        return try self.call(allocator, methods.SetMyProfilePhoto, options);
    }

    pub fn setMyShortDescription(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetMyShortDescription,
    ) !bool {
        return try self.call(allocator, methods.SetMyShortDescription, options);
    }

    pub fn setPassportDataErrors(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetPassportDataErrors,
    ) !bool {
        return try self.call(allocator, methods.SetPassportDataErrors, options);
    }

    pub fn setStickerEmojiList(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetStickerEmojiList,
    ) !bool {
        return try self.call(allocator, methods.SetStickerEmojiList, options);
    }

    pub fn setStickerKeywords(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetStickerKeywords,
    ) !bool {
        return try self.call(allocator, methods.SetStickerKeywords, options);
    }

    pub fn setStickerMaskPosition(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetStickerMaskPosition,
    ) !bool {
        return try self.call(allocator, methods.SetStickerMaskPosition, options);
    }

    pub fn setStickerPositionInSet(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetStickerPositionInSet,
    ) !bool {
        return try self.call(allocator, methods.SetStickerPositionInSet, options);
    }

    pub fn setStickerSetThumbnail(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetStickerSetThumbnail,
    ) !bool {
        return try self.call(allocator, methods.SetStickerSetThumbnail, options);
    }

    pub fn setStickerSetTitle(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetStickerSetTitle,
    ) !bool {
        return try self.call(allocator, methods.SetStickerSetTitle, options);
    }

    pub fn setUserEmojiStatus(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.SetUserEmojiStatus,
    ) !bool {
        return try self.call(allocator, methods.SetUserEmojiStatus, options);
    }

    pub fn stopMessageLiveLocation(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.StopMessageLiveLocation,
    ) !types.MessageOrBool {
        return try self.call(allocator, methods.StopMessageLiveLocation, options);
    }

    pub fn stopPoll(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.StopPoll,
    ) !types.Poll {
        return try self.call(allocator, methods.StopPoll, options);
    }

    pub fn transferBusinessAccountStars(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.TransferBusinessAccountStars,
    ) !bool {
        return try self.call(allocator, methods.TransferBusinessAccountStars, options);
    }

    pub fn transferGift(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.TransferGift,
    ) !bool {
        return try self.call(allocator, methods.TransferGift, options);
    }

    pub fn unbanChatMember(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnbanChatMember,
    ) !bool {
        return try self.call(allocator, methods.UnbanChatMember, options);
    }

    pub fn unbanChatSenderChat(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnbanChatSenderChat,
    ) !bool {
        return try self.call(allocator, methods.UnbanChatSenderChat, options);
    }

    pub fn unhideGeneralForumTopic(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnhideGeneralForumTopic,
    ) !bool {
        return try self.call(allocator, methods.UnhideGeneralForumTopic, options);
    }

    pub fn unpinAllChatMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnpinAllChatMessages,
    ) !bool {
        return try self.call(allocator, methods.UnpinAllChatMessages, options);
    }

    pub fn unpinAllForumTopicMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnpinAllForumTopicMessages,
    ) !bool {
        return try self.call(allocator, methods.UnpinAllForumTopicMessages, options);
    }

    pub fn unpinAllGeneralForumTopicMessages(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnpinAllGeneralForumTopicMessages,
    ) !bool {
        return try self.call(allocator, methods.UnpinAllGeneralForumTopicMessages, options);
    }

    pub fn unpinChatMessage(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UnpinChatMessage,
    ) !bool {
        return try self.call(allocator, methods.UnpinChatMessage, options);
    }

    pub fn upgradeGift(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UpgradeGift,
    ) !bool {
        return try self.call(allocator, methods.UpgradeGift, options);
    }

    pub fn uploadStickerFile(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.UploadStickerFile,
    ) !types.File {
        return try self.call(allocator, methods.UploadStickerFile, options);
    }

    pub fn verifyChat(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.VerifyChat,
    ) !bool {
        return try self.call(allocator, methods.VerifyChat, options);
    }

    pub fn verifyUser(
        self: *const Bot,
        allocator: std.mem.Allocator,
        options: methods.VerifyUser,
    ) !bool {
        return try self.call(allocator, methods.VerifyUser, options);
    }
};
