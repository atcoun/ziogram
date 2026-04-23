const std = @import("std");

const methods = @import("methods");
const types = @import("types");

const BotOptions = @import("bot_options.zig");
const Client = @import("http.zig");

const extractBotId = @import("../utils/token.zig").extractBotId;

allocator: std.mem.Allocator,
token: []const u8,
id: i64,
client: *Client,
options: ?BotOptions = null,

pub fn init(token: []const u8, client: *Client, options: BotOptions) !@This() {
    const bot_id = try extractBotId(token);
    const allocator = client.allocator;

    var bot_options = options;
    bot_options.resolve();

    return @This(){
        .allocator = allocator,
        .token = try allocator.dupe(u8, token),
        .id = bot_id,
        .client = client,
        .options = bot_options,
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
) !@TypeOf(method).Result {
    return self.client.makeRequest(
        allocator,
        self.token,
        method,
        self.options,
    );
}

/// Source: https://core.telegram.org/bots/api#addstickertoset
pub fn addStickerToSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AddStickerToSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#answercallbackquery
pub fn answerCallbackQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerCallbackQuery,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#answerinlinequery
pub fn answerInlineQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerInlineQuery,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#answerprecheckoutquery
pub fn answerPreCheckoutQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerPreCheckoutQuery,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#answershippingquery
pub fn answerShippingQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerShippingQuery,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#answerwebappquery
pub fn answerWebAppQuery(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.AnswerWebAppQuery,
) !types.SentWebAppMessage {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#approvechatjoinrequest
pub fn approveChatJoinRequest(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ApproveChatJoinRequest,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#approvesuggestedpost
pub fn approveSuggestedPost(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ApproveSuggestedPost,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#banchatmember
pub fn banChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.BanChatMember,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#banchatsenderchat
pub fn banChatSenderChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.BanChatSenderChat,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#closeforumtopic
pub fn closeForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CloseForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#closegeneralforumtopic
pub fn closeGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CloseGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#close
pub fn close(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.Close,
) !bool {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#convertgifttostars
pub fn convertGiftToStars(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ConvertGiftToStars,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#copymessage
pub fn copyMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CopyMessage,
) !types.MessageId {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#copymessages
pub fn copyMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CopyMessages,
) ![]const types.MessageId {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#createchatinvitelink
pub fn createChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateChatInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#createchatsubscriptioninvitelink
pub fn createChatSubscriptionInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateChatSubscriptionInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#createforumtopic
pub fn createForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateForumTopic,
) !types.ForumTopic {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#createinvoicelink
pub fn createInvoiceLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateInvoiceLink,
) ![]const u8 {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#createnewstickerset
pub fn createNewStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.CreateNewStickerSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#declinechatjoinrequest
pub fn declineChatJoinRequest(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeclineChatJoinRequest,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#declinesuggestedpost
pub fn declineSuggestedPost(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeclineSuggestedPost,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletebusinessmessages
pub fn deleteBusinessMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteBusinessMessages,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletechatphoto
pub fn deleteChatPhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteChatPhoto,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletechatstickerset
pub fn deleteChatStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteChatStickerSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deleteforumtopic
pub fn deleteForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletemessage
pub fn deleteMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteMessage,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletemessages
pub fn deleteMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteMessages,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletemycommands
pub fn deleteMyCommands(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteMyCommands,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletestickerfromset
pub fn deleteStickerFromSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteStickerFromSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletestickerset
pub fn deleteStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteStickerSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletestory
pub fn deleteStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteStory,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#deletewebhook
pub fn deleteWebhook(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.DeleteWebhook,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editchatinvitelink
pub fn editChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditChatInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editchatsubscriptioninvitelink
pub fn editChatSubscriptionInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditChatSubscriptionInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editforumtopic
pub fn editForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editgeneralforumtopic
pub fn editGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editmessagecaption
pub fn editMessageCaption(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageCaption,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editmessagechecklist
pub fn editMessageChecklist(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageChecklist,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editmessagelivelocation
pub fn editMessageLiveLocation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageLiveLocation,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editmessagemedia
pub fn editMessageMedia(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageMedia,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editmessagereplymarkup
pub fn editMessageReplyMarkup(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageReplyMarkup,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editmessagetext
pub fn editMessageText(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditMessageText,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#editstory
pub fn editStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditStory,
) !types.Story {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#edituserstarsubscription
pub fn editUserStarSubscription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.EditUserStarSubscription,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#exportchatinvitelink
pub fn exportChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ExportChatInviteLink,
) ![]const u8 {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#forwardmessage
pub fn forwardMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ForwardMessage,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#forwardmessages
pub fn forwardMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ForwardMessages,
) ![]const types.MessageId {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getavailablegifts
pub fn getAvailableGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetAvailableGifts,
) !types.Gifts {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getbusinessaccountgifts
pub fn getBusinessAccountGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetBusinessAccountGifts,
) !types.OwnedGifts {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getbusinessaccountstarbalance
pub fn getBusinessAccountStarBalance(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetBusinessAccountStarBalance,
) !types.StarAmount {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getbusinessconnection
pub fn getBusinessConnection(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetBusinessConnection,
) !types.BusinessConnection {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getchatadministrators
pub fn getChatAdministrators(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatAdministrators,
) ![]const types.ChatMember {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getchatgifts
pub fn getChatGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatGifts,
) !types.OwnedGifts {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getchatmembercount
pub fn getChatMemberCount(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatMemberCount,
) !i32 {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getchatmember
pub fn getChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatMember,
) !types.ChatMember {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getchatmenubutton
pub fn getChatMenuButton(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChatMenuButton,
) !types.MenuButton {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getchat
pub fn getChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetChat,
) !types.ChatFullInfo {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getcustomemojistickers
pub fn getCustomEmojiStickers(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetCustomEmojiStickers,
) ![]const types.Sticker {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getfile
pub fn getFile(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetFile,
) !types.File {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getforumtopiciconstickers
pub fn getForumTopicIconStickers(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetForumTopicIconStickers,
) ![]const types.Sticker {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getgamehighscores
pub fn getGameHighScores(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetGameHighScores,
) ![]const types.GameHighScore {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmanagedbottoken
pub fn getManagedBotToken(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetManagedBotToken,
) ![]const u8 {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getme
pub fn getMe(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMe,
) !types.User {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmycommands
pub fn getMyCommands(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyCommands,
) ![]const types.BotCommand {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmydefaultadministratorrights
pub fn getMyDefaultAdministratorRights(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyDefaultAdministratorRights,
) !types.ChatAdministratorRights {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmydescription
pub fn getMyDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyDescription,
) !types.BotDescription {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmyname
pub fn getMyName(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyName,
) !types.BotName {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmyshortdescription
pub fn getMyShortDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyShortDescription,
) !types.BotShortDescription {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getmystarbalance
pub fn getMyStarBalance(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetMyStarBalance,
) !types.StarAmount {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getstartransactions
pub fn getStarTransactions(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetStarTransactions,
) !types.StarTransactions {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getstickerset
pub fn getStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetStickerSet,
) !types.StickerSet {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getupdates
pub fn getUpdates(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUpdates,
) ![]const types.Update {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getuserchatboosts
pub fn getUserChatBoosts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserChatBoosts,
) !types.UserChatBoosts {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getusergifts
pub fn getUserGifts(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserGifts,
) !types.OwnedGifts {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getuserprofileaudios
pub fn getUserProfileAudios(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserProfileAudios,
) !types.UserProfileAudios {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getuserprofilephotos
pub fn getUserProfilePhotos(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetUserProfilePhotos,
) !types.UserProfilePhotos {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#getwebhookinfo
pub fn getWebhookInfo(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GetWebhookInfo,
) !types.WebhookInfo {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#giftpremiumsubscription
pub fn giftPremiumSubscription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.GiftPremiumSubscription,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#hidegeneralforumtopic
pub fn hideGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.HideGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#leavechat
pub fn leaveChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.LeaveChat,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#logout
pub fn logOut(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.LogOut,
) !bool {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#pinchatmessage
pub fn pinChatMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.PinChatMessage,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#poststory
pub fn postStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.PostStory,
) !types.Story {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#promotechatmember
pub fn promoteChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.PromoteChatMember,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#readbusinessmessage
pub fn readBusinessMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReadBusinessMessage,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#refundstarpayment
pub fn refundStarPayment(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RefundStarPayment,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#removebusinessaccountprofilephoto
pub fn removeBusinessAccountProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveBusinessAccountProfilePhoto,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#removechatverification
pub fn removeChatVerification(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveChatVerification,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#removemyprofilephoto
pub fn removeMyProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveMyProfilePhoto,
) !bool {
    return try self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#removeuserverification
pub fn removeUserVerification(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RemoveUserVerification,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#reopenforumtopic
pub fn reopenForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReopenForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#reopengeneralforumtopic
pub fn reopenGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReopenGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#replacemanagedbottoken
pub fn replaceManagedBotToken(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReplaceManagedBotToken,
) ![]const u8 {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#replacestickerinset
pub fn replaceStickerInSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.ReplaceStickerInSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#repoststory
pub fn repostStory(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RepostStory,
) !types.Story {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#restrictchatmember
pub fn restrictChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RestrictChatMember,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#revokechatinvitelink
pub fn revokeChatInviteLink(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.RevokeChatInviteLink,
) !types.ChatInviteLink {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#savepreparedinlinemessage
pub fn savePreparedInlineMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SavePreparedInlineMessage,
) !types.PreparedInlineMessage {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#savepreparedkeyboardbutton
pub fn savePreparedKeyboardButton(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SavePreparedKeyboardButton,
) !types.PreparedKeyboardButton {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendanimation
pub fn sendAnimation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendAnimation,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendaudio
pub fn sendAudio(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendAudio,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendchataction
pub fn sendChatAction(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendChatAction,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendchecklist
pub fn sendChecklist(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendChecklist,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendcontact
pub fn sendContact(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendContact,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#senddice
pub fn sendDice(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendDice,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#senddocument
pub fn sendDocument(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendDocument,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendgame
pub fn sendGame(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendGame,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendgift
pub fn sendGift(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendGift,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendinvoice
pub fn sendInvoice(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendInvoice,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendlocation
pub fn sendLocation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendLocation,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendmessagedraft
pub fn sendMessageDraft(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendMessageDraft,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendmessage
pub fn sendMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendMessage,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendpaidmedia
pub fn sendPaidMedia(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendPaidMedia,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendphoto
pub fn sendPhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendPhoto,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendpoll
pub fn sendPoll(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendPoll,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendsticker
pub fn sendSticker(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendSticker,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendvenue
pub fn sendVenue(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVenue,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendvideonote
pub fn sendVideoNote(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVideoNote,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendvideo
pub fn sendVideo(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVideo,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#sendvoice
pub fn sendVoice(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SendVoice,
) !types.Message {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountbio
pub fn setBusinessAccountBio(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountBio,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountgiftsettings
pub fn setBusinessAccountGiftSettings(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountGiftSettings,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountname
pub fn setBusinessAccountName(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountName,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountprofilephoto
pub fn setBusinessAccountProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountProfilePhoto,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setbusinessaccountusername
pub fn setBusinessAccountUsername(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetBusinessAccountUsername,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatadministratorcustomtitle
pub fn setChatAdministratorCustomTitle(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatAdministratorCustomTitle,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatdescription
pub fn setChatDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatDescription,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatmembertag
pub fn setChatMemberTag(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatMemberTag,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatmenubutton
pub fn setChatMenuButton(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatMenuButton,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatpermissions
pub fn setChatPermissions(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatPermissions,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatphoto
pub fn setChatPhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatPhoto,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchatstickerset
pub fn setChatStickerSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatStickerSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setchattitle
pub fn setChatTitle(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetChatTitle,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setcustomemojistickersetthumbnail
pub fn setCustomEmojiStickerSetThumbnail(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetCustomEmojiStickerSetThumbnail,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setgamescore
pub fn setGameScore(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetGameScore,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmessagereaction
pub fn setMessageReaction(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMessageReaction,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmycommands
pub fn setMyCommands(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyCommands,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmydefaultadministratorrights
pub fn setMyDefaultAdministratorRights(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyDefaultAdministratorRights,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmydescription
pub fn setMyDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyDescription,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmyname
pub fn setMyName(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyName,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmyprofilephoto
pub fn setMyProfilePhoto(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyProfilePhoto,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setmyshortdescription
pub fn setMyShortDescription(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetMyShortDescription,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setpassportdataerrors
pub fn setPassportDataErrors(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetPassportDataErrors,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setstickeremojilist
pub fn setStickerEmojiList(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerEmojiList,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setstickerkeywords
pub fn setStickerKeywords(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerKeywords,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setstickermaskposition
pub fn setStickerMaskPosition(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerMaskPosition,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setstickerpositioninset
pub fn setStickerPositionInSet(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerPositionInSet,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setstickersetthumbnail
pub fn setStickerSetThumbnail(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerSetThumbnail,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setstickersettitle
pub fn setStickerSetTitle(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetStickerSetTitle,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setuseremojistatus
pub fn setUserEmojiStatus(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetUserEmojiStatus,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#setwebhook
pub fn setWebhook(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.SetWebhook,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#stopmessagelivelocation
pub fn stopMessageLiveLocation(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.StopMessageLiveLocation,
) !types.MessageOrBool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#stoppoll
pub fn stopPoll(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.StopPoll,
) !types.Poll {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#transferbusinessaccountstars
pub fn transferBusinessAccountStars(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.TransferBusinessAccountStars,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#transfergift
pub fn transferGift(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.TransferGift,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unbanchatmember
pub fn unbanChatMember(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnbanChatMember,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unbanchatsenderchat
pub fn unbanChatSenderChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnbanChatSenderChat,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unhidegeneralforumtopic
pub fn unhideGeneralForumTopic(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnhideGeneralForumTopic,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unpinallchatmessages
pub fn unpinAllChatMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinAllChatMessages,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unpinallforumtopicmessages
pub fn unpinAllForumTopicMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinAllForumTopicMessages,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unpinallgeneralforumtopicmessages
pub fn unpinAllGeneralForumTopicMessages(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinAllGeneralForumTopicMessages,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#unpinchatmessage
pub fn unpinChatMessage(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UnpinChatMessage,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#upgradegift
pub fn upgradeGift(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UpgradeGift,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#uploadstickerfile
pub fn uploadStickerFile(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.UploadStickerFile,
) !types.File {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#verifychat
pub fn verifyChat(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.VerifyChat,
) !bool {
    return self.call(allocator, options);
}

/// Source: https://core.telegram.org/bots/api#verifychat
pub fn verifyUser(
    self: *const @This(),
    allocator: std.mem.Allocator,
    options: methods.VerifyUser,
) !bool {
    return self.call(allocator, options);
}
