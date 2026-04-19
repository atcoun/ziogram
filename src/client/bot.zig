const std = @import("std");

const methods = @import("methods");
const types = @import("types");

const Client = @import("http.zig");
const BotOptions = @import("bot_options.zig");

const token_utils = @import("../utils/token.zig");

allocator: std.mem.Allocator,
token: []const u8,
id: i64,
client: *Client,
bot_options: ?BotOptions = null,

pub fn init(token: []const u8, client: *Client, bot_options: ?BotOptions) !@This() {
    const bot_id = try token_utils.extractBotId(token);

    const allocator = client.allocator;
    var options = bot_options;
    if (options) |*o| o.resolve();
    return @This(){
        .allocator = allocator,
        .token = try allocator.dupe(u8, token),
        .id = bot_id,
        .client = client,
        .bot_options = bot_options,
    };
}

pub fn deinit(self: *const @This()) void {
    self.allocator.free(self.token);
}

pub fn downloadFile(
    self: @This(),
    allocator: std.mem.Allocator,
    file_path: []const u8,
    writer: *std.Io.Writer,
) !void {
    if (self.client.api.is_local) {
        const local_path = try self.client.api.wrap_local_file.toLocal(allocator, file_path);
        defer allocator.free(local_path);

        const file = try std.Io.Dir.openFile(.cwd(), self.client.io, local_path, .{});
        defer file.close(self.client.io);

        var buf: [65536]u8 = undefined;
        var file_reader = file.reader(self.client.io, &buf);
        _ = try writer.sendFileReadingAll(&file_reader.interface, .unlimited);
        return;
    }

    const url_str = try self.client.api.fileUrl(allocator, self.token, file_path);
    return self.client.streamContent(allocator, url_str, writer);
}

pub fn download(
    self: @This(),
    allocator: std.mem.Allocator,
    file_id: []const u8,
    writer: *std.Io.Writer,
) !void {
    const file = try self.getFile(allocator, .{ .file_id = file_id });
    const path = file.file_path orelse return error.TelegramFileTooLarge;
    return self.downloadFile(allocator, path, writer);
}

pub fn call(
    self: *const @This(),
    allocator: std.mem.Allocator,
    method: anytype,
) !@TypeOf(method).ReturnType {
    return self.client.makeRequest(
        allocator,
        self.token,
        method,
        self.bot_options,
    );
}

pub fn addStickerToSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AddStickerToSet,
) !bool {
    return self.call(allocator, options);
}

pub fn answerCallbackQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerCallbackQuery,
) !bool {
    return self.call(allocator, options);
}

pub fn answerInlineQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerInlineQuery,
) !bool {
    return self.call(allocator, options);
}

pub fn answerPreCheckoutQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerPreCheckoutQuery,
) !bool {
    return self.call(allocator, options);
}

pub fn answerShippingQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerShippingQuery,
) !bool {
    return self.call(allocator, options);
}

pub fn answerWebAppQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerWebAppQuery,
) !types.SentWebAppMessage {
    return self.call(allocator, options);
}

pub fn approveChatJoinRequest(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ApproveChatJoinRequest,
) !bool {
    return self.call(allocator, options);
}

pub fn approveSuggestedPost(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ApproveSuggestedPost,
) !bool {
    return self.call(allocator, options);
}

pub fn banChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.BanChatMember,
) !bool {
    return self.call(allocator, options);
}

pub fn banChatSenderChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.BanChatSenderChat,
) !bool {
    return self.call(allocator, options);
}

pub fn closeForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CloseForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn closeGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CloseGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn close(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.Close,
) !bool {
    return try self.call(allocator, options);
}

pub fn convertGiftToStars(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ConvertGiftToStars,
) !bool {
    return self.call(allocator, options);
}

pub fn copyMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CopyMessage,
) !types.MessageId {
    return self.call(allocator, options);
}

pub fn copyMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CopyMessages,
) ![]const types.MessageId {
    return self.call(allocator, options);
}

pub fn createChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateChatInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

pub fn createChatSubscriptionInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateChatSubscriptionInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

pub fn createForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateForumTopic,
) !types.ForumTopic {
    return self.call(allocator, options);
}

pub fn createInvoiceLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateInvoiceLink,
) ![]const u8 {
    return self.call(allocator, options);
}

pub fn createNewStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateNewStickerSet,
) !bool {
    return self.call(allocator, options);
}

pub fn declineChatJoinRequest(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeclineChatJoinRequest,
) !bool {
    return self.call(allocator, options);
}

pub fn declineSuggestedPost(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeclineSuggestedPost,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteBusinessMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteBusinessMessages,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteChatPhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteChatPhoto,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteChatStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteChatStickerSet,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteMessage,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteMessages,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteMyCommands(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteMyCommands,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteStickerFromSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteStickerFromSet,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteStickerSet,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteStory,
) !bool {
    return self.call(allocator, options);
}

pub fn deleteWebhook(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteWebhook,
) !bool {
    return self.call(allocator, options);
}

pub fn editChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditChatInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

pub fn editChatSubscriptionInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditChatSubscriptionInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

pub fn editForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn editGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn editMessageCaption(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageCaption,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn editMessageChecklist(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageChecklist,
) !types.Message {
    return self.call(allocator, options);
}

pub fn editMessageLiveLocation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageLiveLocation,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn editMessageMedia(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageMedia,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn editMessageReplyMarkup(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageReplyMarkup,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn editMessageText(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageText,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn editStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditStory,
) !types.Story {
    return self.call(allocator, options);
}

pub fn editUserStarSubscription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditUserStarSubscription,
) !bool {
    return self.call(allocator, options);
}

pub fn exportChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ExportChatInviteLink,
) ![]const u8 {
    return self.call(allocator, options);
}

pub fn forwardMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ForwardMessage,
) !types.Message {
    return self.call(allocator, options);
}

pub fn forwardMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ForwardMessages,
) ![]const types.MessageId {
    return self.call(allocator, options);
}

pub fn getAvailableGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetAvailableGifts,
) !types.Gifts {
    return try self.call(allocator, options);
}

pub fn getBusinessAccountGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetBusinessAccountGifts,
) !types.OwnedGifts {
    return self.call(allocator, options);
}

pub fn getBusinessAccountStarBalance(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetBusinessAccountStarBalance,
) !types.StarAmount {
    return self.call(allocator, options);
}

pub fn getBusinessConnection(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetBusinessConnection,
) !types.BusinessConnection {
    return self.call(allocator, options);
}

pub fn getChatAdministrators(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatAdministrators,
) ![]const types.ChatMember {
    return self.call(allocator, options);
}

pub fn getChatGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatGifts,
) !types.OwnedGifts {
    return self.call(allocator, options);
}

pub fn getChatMemberCount(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatMemberCount,
) !i32 {
    return self.call(allocator, options);
}

pub fn getChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatMember,
) !types.ChatMember {
    return self.call(allocator, options);
}

pub fn getChatMenuButton(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatMenuButton,
) !types.MenuButton {
    return self.call(allocator, options);
}

pub fn getChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChat,
) !types.ChatFullInfo {
    return self.call(allocator, options);
}

pub fn getCustomEmojiStickers(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetCustomEmojiStickers,
) ![]const types.Sticker {
    return self.call(allocator, options);
}

pub fn getFile(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetFile,
) !types.File {
    return self.call(allocator, options);
}

pub fn getForumTopicIconStickers(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetForumTopicIconStickers,
) ![]const types.Sticker {
    return try self.call(allocator, options);
}

pub fn getGameHighScores(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetGameHighScores,
) ![]const types.GameHighScore {
    return self.call(allocator, options);
}

pub fn getManagedBotToken(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetManagedBotToken,
) ![]const u8 {
    return self.call(allocator, options);
}

pub fn getMe(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMe,
) !types.User {
    return try self.call(allocator, options);
}

pub fn getMyCommands(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyCommands,
) ![]const types.BotCommand {
    return self.call(allocator, options);
}

pub fn getMyDefaultAdministratorRights(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyDefaultAdministratorRights,
) !types.ChatAdministratorRights {
    return self.call(allocator, options);
}

pub fn getMyDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyDescription,
) !types.BotDescription {
    return self.call(allocator, options);
}

pub fn getMyName(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyName,
) !types.BotName {
    return self.call(allocator, options);
}

pub fn getMyShortDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyShortDescription,
) !types.BotShortDescription {
    return self.call(allocator, options);
}

pub fn getMyStarBalance(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyStarBalance,
) !types.StarAmount {
    return try self.call(allocator, options);
}

pub fn getStarTransactions(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetStarTransactions,
) !types.StarTransactions {
    return self.call(allocator, options);
}

pub fn getStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetStickerSet,
) !types.StickerSet {
    return self.call(allocator, options);
}

pub fn getUpdates(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUpdates,
) ![]const types.Update {
    return self.call(allocator, options);
}

pub fn getUserChatBoosts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserChatBoosts,
) !types.UserChatBoosts {
    return self.call(allocator, options);
}

pub fn getUserGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserGifts,
) !types.OwnedGifts {
    return self.call(allocator, options);
}

pub fn getUserProfileAudios(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserProfileAudios,
) !types.UserProfileAudios {
    return self.call(allocator, options);
}

pub fn getUserProfilePhotos(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserProfilePhotos,
) !types.UserProfilePhotos {
    return self.call(allocator, options);
}

pub fn getWebhookInfo(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetWebhookInfo,
) !types.WebhookInfo {
    return self.call(allocator, options);
}

pub fn giftPremiumSubscription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GiftPremiumSubscription,
) !bool {
    return self.call(allocator, options);
}

pub fn hideGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.HideGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn leaveChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.LeaveChat,
) !bool {
    return self.call(allocator, options);
}

pub fn logOut(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.LogOut,
) !bool {
    return try self.call(allocator, options);
}

pub fn pinChatMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.PinChatMessage,
) !bool {
    return self.call(allocator, options);
}

pub fn postStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.PostStory,
) !types.Story {
    return self.call(allocator, options);
}

pub fn promoteChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.PromoteChatMember,
) !bool {
    return self.call(allocator, options);
}

pub fn readBusinessMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReadBusinessMessage,
) !bool {
    return self.call(allocator, options);
}

pub fn refundStarPayment(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RefundStarPayment,
) !bool {
    return self.call(allocator, options);
}

pub fn removeBusinessAccountProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveBusinessAccountProfilePhoto,
) !bool {
    return self.call(allocator, options);
}

pub fn removeChatVerification(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveChatVerification,
) !bool {
    return self.call(allocator, options);
}

pub fn removeMyProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveMyProfilePhoto,
) !bool {
    return try self.call(allocator, options);
}

pub fn removeUserVerification(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveUserVerification,
) !bool {
    return self.call(allocator, options);
}

pub fn reopenForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReopenForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn reopenGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReopenGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn replaceManagedBotToken(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReplaceManagedBotToken,
) ![]const u8 {
    return self.call(allocator, options);
}

pub fn replaceStickerInSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReplaceStickerInSet,
) !bool {
    return self.call(allocator, options);
}

pub fn repostStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RepostStory,
) !types.Story {
    return self.call(allocator, options);
}

pub fn restrictChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RestrictChatMember,
) !bool {
    return self.call(allocator, options);
}

pub fn revokeChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RevokeChatInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

pub fn savePreparedInlineMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SavePreparedInlineMessage,
) !types.PreparedInlineMessage {
    return self.call(allocator, options);
}

pub fn savePreparedKeyboardButton(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SavePreparedKeyboardButton,
) !types.PreparedKeyboardButton {
    return self.call(allocator, options);
}

pub fn sendAnimation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendAnimation,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendAudio(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendAudio,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendChatAction(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendChatAction,
) !bool {
    return self.call(allocator, options);
}

pub fn sendChecklist(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendChecklist,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendContact(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendContact,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendDice(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendDice,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendDocument(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendDocument,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendGame(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendGame,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendGift(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendGift,
) !bool {
    return self.call(allocator, options);
}

pub fn sendInvoice(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendInvoice,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendLocation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendLocation,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendMessageDraft(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendMessageDraft,
) !bool {
    return self.call(allocator, options);
}

pub fn sendMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendMessage,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendPaidMedia(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendPaidMedia,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendPhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendPhoto,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendPoll(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendPoll,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendSticker(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendSticker,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendVenue(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVenue,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendVideoNote(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVideoNote,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendVideo(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVideo,
) !types.Message {
    return self.call(allocator, options);
}

pub fn sendVoice(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVoice,
) !types.Message {
    return self.call(allocator, options);
}

pub fn setBusinessAccountBio(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountBio,
) !bool {
    return self.call(allocator, options);
}

pub fn setBusinessAccountGiftSettings(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountGiftSettings,
) !bool {
    return self.call(allocator, options);
}

pub fn setBusinessAccountName(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountName,
) !bool {
    return self.call(allocator, options);
}

pub fn setBusinessAccountProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountProfilePhoto,
) !bool {
    return self.call(allocator, options);
}

pub fn setBusinessAccountUsername(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountUsername,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatAdministratorCustomTitle(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatAdministratorCustomTitle,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatDescription,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatMemberTag(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatMemberTag,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatMenuButton(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatMenuButton,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatPermissions(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatPermissions,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatPhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatPhoto,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatStickerSet,
) !bool {
    return self.call(allocator, options);
}

pub fn setChatTitle(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatTitle,
) !bool {
    return self.call(allocator, options);
}

pub fn setCustomEmojiStickerSetThumbnail(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetCustomEmojiStickerSetThumbnail,
) !bool {
    return self.call(allocator, options);
}

pub fn setGameScore(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetGameScore,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn setMessageReaction(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMessageReaction,
) !bool {
    return self.call(allocator, options);
}

pub fn setMyCommands(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyCommands,
) !bool {
    return self.call(allocator, options);
}

pub fn setMyDefaultAdministratorRights(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyDefaultAdministratorRights,
) !bool {
    return self.call(allocator, options);
}

pub fn setMyDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyDescription,
) !bool {
    return self.call(allocator, options);
}

pub fn setMyName(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyName,
) !bool {
    return self.call(allocator, options);
}

pub fn setMyProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyProfilePhoto,
) !bool {
    return self.call(allocator, options);
}

pub fn setMyShortDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyShortDescription,
) !bool {
    return self.call(allocator, options);
}

pub fn setPassportDataErrors(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetPassportDataErrors,
) !bool {
    return self.call(allocator, options);
}

pub fn setStickerEmojiList(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerEmojiList,
) !bool {
    return self.call(allocator, options);
}

pub fn setStickerKeywords(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerKeywords,
) !bool {
    return self.call(allocator, options);
}

pub fn setStickerMaskPosition(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerMaskPosition,
) !bool {
    return self.call(allocator, options);
}

pub fn setStickerPositionInSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerPositionInSet,
) !bool {
    return self.call(allocator, options);
}

pub fn setStickerSetThumbnail(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerSetThumbnail,
) !bool {
    return self.call(allocator, options);
}

pub fn setStickerSetTitle(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerSetTitle,
) !bool {
    return self.call(allocator, options);
}

pub fn setUserEmojiStatus(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetUserEmojiStatus,
) !bool {
    return self.call(allocator, options);
}

pub fn setWebhook(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetWebhook,
) !bool {
    return self.call(allocator, options);
}

pub fn stopMessageLiveLocation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.StopMessageLiveLocation,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

pub fn stopPoll(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.StopPoll,
) !types.Poll {
    return self.call(allocator, options);
}

pub fn transferBusinessAccountStars(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.TransferBusinessAccountStars,
) !bool {
    return self.call(allocator, options);
}

pub fn transferGift(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.TransferGift,
) !bool {
    return self.call(allocator, options);
}

pub fn unbanChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnbanChatMember,
) !bool {
    return self.call(allocator, options);
}

pub fn unbanChatSenderChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnbanChatSenderChat,
) !bool {
    return self.call(allocator, options);
}

pub fn unhideGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnhideGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

pub fn unpinAllChatMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinAllChatMessages,
) !bool {
    return self.call(allocator, options);
}

pub fn unpinAllForumTopicMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinAllForumTopicMessages,
) !bool {
    return self.call(allocator, options);
}

pub fn unpinAllGeneralForumTopicMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinAllGeneralForumTopicMessages,
) !bool {
    return self.call(allocator, options);
}

pub fn unpinChatMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinChatMessage,
) !bool {
    return self.call(allocator, options);
}

pub fn upgradeGift(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UpgradeGift,
) !bool {
    return self.call(allocator, options);
}

pub fn uploadStickerFile(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UploadStickerFile,
) !types.File {
    return self.call(allocator, options);
}

pub fn verifyChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.VerifyChat,
) !bool {
    return self.call(allocator, options);
}

pub fn verifyUser(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.VerifyUser,
) !bool {
    return self.call(allocator, options);
}
