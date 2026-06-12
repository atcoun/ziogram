# Telegram Bot API — Implementation Status

Implementation progress of the **Telegram Bot API** in this Zig library.

- **Bot API Version:** 10.1 (June 11, 2026)
- **Language:** Zig 0.16.0+
- **Coverage:** 180 / 180 methods · 336 / 336 types

---

## Getting Updates

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`getUpdates`](src/methods/get_updates.zig) | https://core.telegram.org/bots/api#getupdates | ✅ |
| [`setWebhook`](src/methods/set_webhook.zig) | https://core.telegram.org/bots/api#setwebhook | ✅ |
| [`deleteWebhook`](src/methods/delete_webhook.zig) | https://core.telegram.org/bots/api#deletewebhook | ✅ |
| [`getWebhookInfo`](src/methods/get_webhook_info.zig) | https://core.telegram.org/bots/api#getwebhookinfo | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`Update`](src/types/update.zig) | https://core.telegram.org/bots/api#update | ✅ |
| [`WebhookInfo`](src/types/webhook_info.zig) | https://core.telegram.org/bots/api#webhookinfo | ✅ |

---

## Available Types

| Type | Source | Status |
|------|--------|--------|
| [`AcceptedGiftTypes`](src/types/accepted_gift_types.zig) | https://core.telegram.org/bots/api#acceptedgifttypes | ✅ |
| [`AffiliateInfo`](src/types/affiliate_info.zig) | https://core.telegram.org/bots/api#affiliateinfo | ✅ |
| [`Animation`](src/types/animation.zig) | https://core.telegram.org/bots/api#animation | ✅ |
| [`Audio`](src/types/audio.zig) | https://core.telegram.org/bots/api#audio | ✅ |
| [`BackgroundFill`](src/types/background_fill.zig) | https://core.telegram.org/bots/api#backgroundfill | ✅ |
| [`BackgroundFillFreeformGradient`](src/types/background_fill_freeform_gradient.zig) | https://core.telegram.org/bots/api#backgroundfillfreeformgradient | ✅ |
| [`BackgroundFillGradient`](src/types/background_fill_gradient.zig) | https://core.telegram.org/bots/api#backgroundfillgradient | ✅ |
| [`BackgroundFillSolid`](src/types/background_fill_solid.zig) | https://core.telegram.org/bots/api#backgroundfillsolid | ✅ |
| [`BackgroundType`](src/types/background_type.zig) | https://core.telegram.org/bots/api#backgroundtype | ✅ |
| [`BackgroundTypeChatTheme`](src/types/background_type_chat_theme.zig) | https://core.telegram.org/bots/api#backgroundtypechattheme | ✅ |
| [`BackgroundTypeFill`](src/types/background_type_fill.zig) | https://core.telegram.org/bots/api#backgroundtypefill | ✅ |
| [`BackgroundTypePattern`](src/types/background_type_pattern.zig) | https://core.telegram.org/bots/api#backgroundtypepattern | ✅ |
| [`BackgroundTypeWallpaper`](src/types/background_type_wallpaper.zig) | https://core.telegram.org/bots/api#backgroundtypewallpaper | ✅ |
| [`Birthdate`](src/types/birthdate.zig) | https://core.telegram.org/bots/api#birthdate | ✅ |
| [`BotAccessSettings`](src/types/bot_access_settings.zig) | https://core.telegram.org/bots/api#botaccesssettings | ✅ |
| [`BotCommand`](src/types/bot_command.zig) | https://core.telegram.org/bots/api#botcommand | ✅ |
| [`BotCommandScope`](src/types/bot_command_scope.zig) | https://core.telegram.org/bots/api#botcommandscope | ✅ |
| [`BotCommandScopeAllChatAdministrators`](src/types/bot_command_scope_all_chat_administrators.zig) | https://core.telegram.org/bots/api#botcommandscopeallchatadministrators | ✅ |
| [`BotCommandScopeAllGroupChats`](src/types/bot_command_scope_all_group_chats.zig) | https://core.telegram.org/bots/api#botcommandscopeallgroupchats | ✅ |
| [`BotCommandScopeAllPrivateChats`](src/types/bot_command_scope_all_private_chats.zig) | https://core.telegram.org/bots/api#botcommandscopeallprivatechats | ✅ |
| [`BotCommandScopeChat`](src/types/bot_command_scope_chat.zig) | https://core.telegram.org/bots/api#botcommandscopechat | ✅ |
| [`BotCommandScopeChatAdministrators`](src/types/bot_command_scope_chat_administrators.zig) | https://core.telegram.org/bots/api#botcommandscopechatadministrators | ✅ |
| [`BotCommandScopeChatMember`](src/types/bot_command_scope_chat_member.zig) | https://core.telegram.org/bots/api#botcommandscopechatmember | ✅ |
| [`BotCommandScopeDefault`](src/types/bot_command_scope_default.zig) | https://core.telegram.org/bots/api#botcommandscopedefault | ✅ |
| [`BotDescription`](src/types/bot_description.zig) | https://core.telegram.org/bots/api#botdescription | ✅ |
| [`BotName`](src/types/bot_name.zig) | https://core.telegram.org/bots/api#botname | ✅ |
| [`BotShortDescription`](src/types/bot_short_description.zig) | https://core.telegram.org/bots/api#botshortdescription | ✅ |
| [`BusinessBotRights`](src/types/business_bot_rights.zig) | https://core.telegram.org/bots/api#businessbotrights | ✅ |
| [`BusinessConnection`](src/types/business_connection.zig) | https://core.telegram.org/bots/api#businessconnection | ✅ |
| [`BusinessIntro`](src/types/business_intro.zig) | https://core.telegram.org/bots/api#businessintro | ✅ |
| [`BusinessLocation`](src/types/business_location.zig) | https://core.telegram.org/bots/api#businesslocation | ✅ |
| [`BusinessMessagesDeleted`](src/types/business_messages_deleted.zig) | https://core.telegram.org/bots/api#businessmessagesdeleted | ✅ |
| [`BusinessOpeningHours`](src/types/business_opening_hours.zig) | https://core.telegram.org/bots/api#businessopeninghours | ✅ |
| [`BusinessOpeningHoursInterval`](src/types/business_opening_hours_interval.zig) | https://core.telegram.org/bots/api#businessopeninghoursinterval | ✅ |
| [`CallbackQuery`](src/types/callback_query.zig) | https://core.telegram.org/bots/api#callbackquery | ✅ |
| [`Chat`](src/types/chat.zig) | https://core.telegram.org/bots/api#chat | ✅ |
| [`ChatAdministratorRights`](src/types/chat_administrator_rights.zig) | https://core.telegram.org/bots/api#chatadministratorrights | ✅ |
| [`ChatBackground`](src/types/chat_background.zig) | https://core.telegram.org/bots/api#chatbackground | ✅ |
| [`ChatBoost`](src/types/chat_boost.zig) | https://core.telegram.org/bots/api#chatboost | ✅ |
| [`ChatBoostAdded`](src/types/chat_boost_added.zig) | https://core.telegram.org/bots/api#chatboostadded | ✅ |
| [`ChatBoostRemoved`](src/types/chat_boost_removed.zig) | https://core.telegram.org/bots/api#chatboostremoved | ✅ |
| [`ChatBoostSource`](src/types/chat_boost_source.zig) | https://core.telegram.org/bots/api#chatboostsource | ✅ |
| [`ChatBoostSourceGiftCode`](src/types/chat_boost_source_gift_code.zig) | https://core.telegram.org/bots/api#chatboostsourcegiftcode | ✅ |
| [`ChatBoostSourceGiveaway`](src/types/chat_boost_source_giveaway.zig) | https://core.telegram.org/bots/api#chatboostsourcegiveaway | ✅ |
| [`ChatBoostSourcePremium`](src/types/chat_boost_source_premium.zig) | https://core.telegram.org/bots/api#chatboostsourcepremium | ✅ |
| [`ChatBoostUpdated`](src/types/chat_boost_updated.zig) | https://core.telegram.org/bots/api#chatboostupdated | ✅ |
| [`ChatFullInfo`](src/types/chat_full_info.zig) | https://core.telegram.org/bots/api#chatfullinfo | ✅ |
| [`ChatInviteLink`](src/types/chat_invite_link.zig) | https://core.telegram.org/bots/api#chatinvitelink | ✅ |
| [`ChatJoinRequest`](src/types/chat_join_request.zig) | https://core.telegram.org/bots/api#chatjoinrequest | ✅ |
| [`ChatLocation`](src/types/chat_location.zig) | https://core.telegram.org/bots/api#chatlocation | ✅ |
| [`ChatMember`](src/types/chat_member.zig) | https://core.telegram.org/bots/api#chatmember | ✅ |
| [`ChatMemberAdministrator`](src/types/chat_member_administrator.zig) | https://core.telegram.org/bots/api#chatmemberadministrator | ✅ |
| [`ChatMemberBanned`](src/types/chat_member_banned.zig) | https://core.telegram.org/bots/api#chatmemberbanned | ✅ |
| [`ChatMemberLeft`](src/types/chat_member_left.zig) | https://core.telegram.org/bots/api#chatmemberleft | ✅ |
| [`ChatMemberMember`](src/types/chat_member_member.zig) | https://core.telegram.org/bots/api#chatmembermember | ✅ |
| [`ChatMemberOwner`](src/types/chat_member_owner.zig) | https://core.telegram.org/bots/api#chatmemberowner | ✅ |
| [`ChatMemberRestricted`](src/types/chat_member_restricted.zig) | https://core.telegram.org/bots/api#chatmemberrestricted | ✅ |
| [`ChatMemberUpdated`](src/types/chat_member_updated.zig) | https://core.telegram.org/bots/api#chatmemberupdated | ✅ |
| [`ChatOwnerChanged`](src/types/chat_owner_changed.zig) | https://core.telegram.org/bots/api#chatownerchanged | ✅ |
| [`ChatOwnerLeft`](src/types/chat_owner_left.zig) | https://core.telegram.org/bots/api#chatownerleft | ✅ |
| [`ChatPermissions`](src/types/chat_permissions.zig) | https://core.telegram.org/bots/api#chatpermissions | ✅ |
| [`ChatPhoto`](src/types/chat_photo.zig) | https://core.telegram.org/bots/api#chatphoto | ✅ |
| [`ChatShared`](src/types/chat_shared.zig) | https://core.telegram.org/bots/api#chatshared | ✅ |
| [`Checklist`](src/types/checklist.zig) | https://core.telegram.org/bots/api#checklist | ✅ |
| [`ChecklistTask`](src/types/checklist_task.zig) | https://core.telegram.org/bots/api#checklisttask | ✅ |
| [`ChecklistTasksAdded`](src/types/checklist_tasks_added.zig) | https://core.telegram.org/bots/api#checklisttasksadded | ✅ |
| [`ChecklistTasksDone`](src/types/checklist_tasks_done.zig) | https://core.telegram.org/bots/api#checklisttasksdone | ✅ |
| [`Contact`](src/types/contact.zig) | https://core.telegram.org/bots/api#contact | ✅ |
| [`CopyTextButton`](src/types/copy_text_button.zig) | https://core.telegram.org/bots/api#copytextbutton | ✅ |
| [`Dice`](src/types/dice.zig) | https://core.telegram.org/bots/api#dice | ✅ |
| [`DirectMessagePriceChanged`](src/types/direct_message_price_changed.zig) | https://core.telegram.org/bots/api#directmessagepricechanged | ✅ |
| [`DirectMessagesTopic`](src/types/direct_messages_topic.zig) | https://core.telegram.org/bots/api#directmessagestopic | ✅ |
| [`Document`](src/types/document.zig) | https://core.telegram.org/bots/api#document | ✅ |
| [`ExternalReplyInfo`](src/types/external_reply_info.zig) | https://core.telegram.org/bots/api#externalreplyinfo | ✅ |
| [`File`](src/types/file.zig) | https://core.telegram.org/bots/api#file | ✅ |
| [`ForceReply`](src/types/force_reply.zig) | https://core.telegram.org/bots/api#forcereply | ✅ |
| [`ForumTopic`](src/types/forum_topic.zig) | https://core.telegram.org/bots/api#forumtopic | ✅ |
| [`ForumTopicClosed`](src/types/forum_topic_closed.zig) | https://core.telegram.org/bots/api#forumtopicclosed | ✅ |
| [`ForumTopicCreated`](src/types/forum_topic_created.zig) | https://core.telegram.org/bots/api#forumtopiccreated | ✅ |
| [`ForumTopicEdited`](src/types/forum_topic_edited.zig) | https://core.telegram.org/bots/api#forumtopicedited | ✅ |
| [`ForumTopicReopened`](src/types/forum_topic_reopened.zig) | https://core.telegram.org/bots/api#forumtopicreopened | ✅ |
| [`GeneralForumTopicHidden`](src/types/general_forum_topic_hidden.zig) | https://core.telegram.org/bots/api#generalforumtopichidden | ✅ |
| [`GeneralForumTopicUnhidden`](src/types/general_forum_topic_unhidden.zig) | https://core.telegram.org/bots/api#generalforumtopicunhidden | ✅ |
| [`Gift`](src/types/gift.zig) | https://core.telegram.org/bots/api#gift | ✅ |
| [`GiftBackground`](src/types/gift_background.zig) | https://core.telegram.org/bots/api#giftbackground | ✅ |
| [`GiftInfo`](src/types/gift_info.zig) | https://core.telegram.org/bots/api#giftinfo | ✅ |
| [`Gifts`](src/types/gifts.zig) | https://core.telegram.org/bots/api#gifts | ✅ |
| [`Giveaway`](src/types/giveaway.zig) | https://core.telegram.org/bots/api#giveaway | ✅ |
| [`GiveawayCompleted`](src/types/giveaway_completed.zig) | https://core.telegram.org/bots/api#giveawaycompleted | ✅ |
| [`GiveawayCreated`](src/types/giveaway_created.zig) | https://core.telegram.org/bots/api#giveawaycreated | ✅ |
| [`GiveawayWinners`](src/types/giveaway_winners.zig) | https://core.telegram.org/bots/api#giveawaywinners | ✅ |
| [`InaccessibleMessage`](src/types/inaccessible_message.zig) | https://core.telegram.org/bots/api#inaccessiblemessage | ✅ |
| [`InlineKeyboardButton`](src/types/inline_keyboard_button.zig) | https://core.telegram.org/bots/api#inlinekeyboardbutton | ✅ |
| [`InlineKeyboardMarkup`](src/types/inline_keyboard_markup.zig) | https://core.telegram.org/bots/api#inlinekeyboardmarkup | ✅ |
| [`KeyboardButton`](src/types/keyboard_button.zig) | https://core.telegram.org/bots/api#keyboardbutton | ✅ |
| [`KeyboardButtonPollType`](src/types/keyboard_button_poll_type.zig) | https://core.telegram.org/bots/api#keyboardbuttonpolltype | ✅ |
| [`KeyboardButtonRequestChat`](src/types/keyboard_button_request_chat.zig) | https://core.telegram.org/bots/api#keyboardbuttonrequestchat | ✅ |
| [`KeyboardButtonRequestManagedBot`](src/types/keyboard_button_request_managed_bot.zig) | https://core.telegram.org/bots/api#keyboardbuttonrequestmanagedbot | ✅ |
| [`KeyboardButtonRequestUsers`](src/types/keyboard_button_request_users.zig) | https://core.telegram.org/bots/api#keyboardbuttonrequestusers | ✅ |
| [`LinkPreviewOptions`](src/types/link_preview_options.zig) | https://core.telegram.org/bots/api#linkpreviewoptions | ✅ |
| [`LivePhoto`](src/types/live_photo.zig) | https://core.telegram.org/bots/api#livephoto | ✅ |
| [`Location`](src/types/location.zig) | https://core.telegram.org/bots/api#location | ✅ |
| [`LocationAddress`](src/types/location_address.zig) | https://core.telegram.org/bots/api#locationaddress | ✅ |
| [`LoginUrl`](src/types/login_url.zig) | https://core.telegram.org/bots/api#loginurl | ✅ |
| [`ManagedBotCreated`](src/types/managed_bot_created.zig) | https://core.telegram.org/bots/api#managedbotcreated | ✅ |
| [`ManagedBotUpdated`](src/types/managed_bot_updated.zig) | https://core.telegram.org/bots/api#managedbotupdated | ✅ |
| [`MaybeInaccessibleMessage`](src/types/maybe_inaccessible_message.zig) | https://core.telegram.org/bots/api#maybeinaccessiblemessage | ✅ |
| [`MenuButton`](src/types/menu_button.zig) | https://core.telegram.org/bots/api#menubutton | ✅ |
| [`MenuButtonCommands`](src/types/menu_button_commands.zig) | https://core.telegram.org/bots/api#menubuttoncommands | ✅ |
| [`MenuButtonDefault`](src/types/menu_button_default.zig) | https://core.telegram.org/bots/api#menubuttondefault | ✅ |
| [`MenuButtonWebApp`](src/types/menu_button_web_app.zig) | https://core.telegram.org/bots/api#menubuttonwebapp | ✅ |
| [`Message`](src/types/message.zig) | https://core.telegram.org/bots/api#message | ✅ |
| [`MessageAutoDeleteTimerChanged`](src/types/message_auto_delete_timer_changed.zig) | https://core.telegram.org/bots/api#messageautodeletetimerchanged | ✅ |
| [`MessageEntity`](src/types/message_entity.zig) | https://core.telegram.org/bots/api#messageentity | ✅ |
| [`MessageId`](src/types/message_id.zig) | https://core.telegram.org/bots/api#messageid | ✅ |
| [`MessageOrigin`](src/types/message_origin.zig) | https://core.telegram.org/bots/api#messageorigin | ✅ |
| [`MessageOriginChannel`](src/types/message_origin_channel.zig) | https://core.telegram.org/bots/api#messageoriginchannel | ✅ |
| [`MessageOriginChat`](src/types/message_origin_chat.zig) | https://core.telegram.org/bots/api#messageoriginchat | ✅ |
| [`MessageOriginHiddenUser`](src/types/message_origin_hidden_user.zig) | https://core.telegram.org/bots/api#messageoriginhiddenuser | ✅ |
| [`MessageOriginUser`](src/types/message_origin_user.zig) | https://core.telegram.org/bots/api#messageoriginuser | ✅ |
| [`MessageReactionCountUpdated`](src/types/message_reaction_count_updated.zig) | https://core.telegram.org/bots/api#messagereactioncountupdated | ✅ |
| [`MessageReactionUpdated`](src/types/message_reaction_updated.zig) | https://core.telegram.org/bots/api#messagereactionupdated | ✅ |
| [`OwnedGift`](src/types/owned_gift.zig) | https://core.telegram.org/bots/api#ownedgift | ✅ |
| [`OwnedGiftRegular`](src/types/owned_gift_regular.zig) | https://core.telegram.org/bots/api#ownedgiftregular | ✅ |
| [`OwnedGifts`](src/types/owned_gifts.zig) | https://core.telegram.org/bots/api#ownedgifts | ✅ |
| [`OwnedGiftUnique`](src/types/owned_gift_unique.zig) | https://core.telegram.org/bots/api#ownedgiftunique | ✅ |
| [`PaidMedia`](src/types/paid_media.zig) | https://core.telegram.org/bots/api#paidmedia | ✅ |
| [`PaidMediaInfo`](src/types/paid_media_info.zig) | https://core.telegram.org/bots/api#paidmediainfo | ✅ |
| [`PaidMediaLivePhoto`](src/types/paid_media_live_photo.zig) | https://core.telegram.org/bots/api#paidmedialivephoto | ✅ |
| [`PaidMediaPhoto`](src/types/paid_media_photo.zig) | https://core.telegram.org/bots/api#paidmediaphoto | ✅ |
| [`PaidMediaPreview`](src/types/paid_media_preview.zig) | https://core.telegram.org/bots/api#paidmediapreview | ✅ |
| [`PaidMediaPurchased`](src/types/paid_media_purchased.zig) | https://core.telegram.org/bots/api#paidmediapurchased | ✅ |
| [`PaidMediaVideo`](src/types/paid_media_video.zig) | https://core.telegram.org/bots/api#paidmediavideo | ✅ |
| [`PaidMessagePriceChanged`](src/types/paid_message_price_changed.zig) | https://core.telegram.org/bots/api#paidmessagepricechanged | ✅ |
| [`PhotoSize`](src/types/photo_size.zig) | https://core.telegram.org/bots/api#photosize | ✅ |
| [`Poll`](src/types/poll.zig) | https://core.telegram.org/bots/api#poll | ✅ |
| [`PollAnswer`](src/types/poll_answer.zig) | https://core.telegram.org/bots/api#pollanswer | ✅ |
| [`PollMedia`](src/types/poll_media.zig) | https://core.telegram.org/bots/api#pollmedia | ✅ |
| [`PollOption`](src/types/poll_option.zig) | https://core.telegram.org/bots/api#polloption | ✅ |
| [`PollOptionAdded`](src/types/poll_option_added.zig) | https://core.telegram.org/bots/api#polloptionadded | ✅ |
| [`PollOptionDeleted`](src/types/poll_option_deleted.zig) | https://core.telegram.org/bots/api#polloptiondeleted | ✅ |
| [`ProximityAlertTriggered`](src/types/proximity_alert_triggered.zig) | https://core.telegram.org/bots/api#proximityalerttriggered | ✅ |
| [`ReactionCount`](src/types/reaction_count.zig) | https://core.telegram.org/bots/api#reactioncount | ✅ |
| [`ReactionType`](src/types/reaction_type.zig) | https://core.telegram.org/bots/api#reactiontype | ✅ |
| [`ReactionTypeCustomEmoji`](src/types/reaction_type_custom_emoji.zig) | https://core.telegram.org/bots/api#reactiontypecustomemoji | ✅ |
| [`ReactionTypeEmoji`](src/types/reaction_type_emoji.zig) | https://core.telegram.org/bots/api#reactiontypeemoji | ✅ |
| [`ReactionTypePaid`](src/types/reaction_type_paid.zig) | https://core.telegram.org/bots/api#reactiontypepaid | ✅ |
| [`ReplyKeyboardMarkup`](src/types/reply_keyboard_markup.zig) | https://core.telegram.org/bots/api#replykeyboardmarkup | ✅ |
| [`ReplyKeyboardRemove`](src/types/reply_keyboard_remove.zig) | https://core.telegram.org/bots/api#replykeyboardremove | ✅ |
| [`ReplyMarkup`](src/types/reply_markup.zig) | https://core.telegram.org/bots/api#replymarkup | ✅ |
| [`ReplyParameters`](src/types/reply_parameters.zig) | https://core.telegram.org/bots/api#replyparameters | ✅ |
| [`Response`](src/types/response.zig) | https://core.telegram.org/bots/api#making-requests | ✅ |
| [`ResponseParameters`](src/types/response_parameters.zig) | https://core.telegram.org/bots/api#responseparameters | ✅ |
| [`SentGuestMessage`](src/types/sent_guest_message.zig) | https://core.telegram.org/bots/api#sentguestmessage | ✅ |
| [`SharedUser`](src/types/shared_user.zig) | https://core.telegram.org/bots/api#shareduser | ✅ |
| [`Story`](src/types/story.zig) | https://core.telegram.org/bots/api#story | ✅ |
| [`StoryArea`](src/types/story_area.zig) | https://core.telegram.org/bots/api#storyarea | ✅ |
| [`StoryAreaPosition`](src/types/story_area_position.zig) | https://core.telegram.org/bots/api#storyareaposition | ✅ |
| [`StoryAreaType`](src/types/story_area_type.zig) | https://core.telegram.org/bots/api#storyareatype | ✅ |
| [`StoryAreaTypeLink`](src/types/story_area_type_link.zig) | https://core.telegram.org/bots/api#storyareatypelink | ✅ |
| [`StoryAreaTypeLocation`](src/types/story_area_type_location.zig) | https://core.telegram.org/bots/api#storyareatypelocation | ✅ |
| [`StoryAreaTypeSuggestedReaction`](src/types/story_area_type_suggested_reaction.zig) | https://core.telegram.org/bots/api#storyareatypesuggestedreaction | ✅ |
| [`StoryAreaTypeUniqueGift`](src/types/story_area_type_unique_gift.zig) | https://core.telegram.org/bots/api#storyareatypeuniquegift | ✅ |
| [`StoryAreaTypeWeather`](src/types/story_area_type_weather.zig) | https://core.telegram.org/bots/api#storyareatypeweather | ✅ |
| [`SuggestedPostApprovalFailed`](src/types/suggested_post_approval_failed.zig) | https://core.telegram.org/bots/api#suggestedpostapprovalfailed | ✅ |
| [`SuggestedPostApproved`](src/types/suggested_post_approved.zig) | https://core.telegram.org/bots/api#suggestedpostapproved | ✅ |
| [`SuggestedPostDeclined`](src/types/suggested_post_declined.zig) | https://core.telegram.org/bots/api#suggestedpostdeclined | ✅ |
| [`SuggestedPostInfo`](src/types/suggested_post_info.zig) | https://core.telegram.org/bots/api#suggestedpostinfo | ✅ |
| [`SuggestedPostPaid`](src/types/suggested_post_paid.zig) | https://core.telegram.org/bots/api#suggestedpostpaid | ✅ |
| [`SuggestedPostParameters`](src/types/suggested_post_parameters.zig) | https://core.telegram.org/bots/api#suggestedpostparameters | ✅ |
| [`SuggestedPostPrice`](src/types/suggested_post_price.zig) | https://core.telegram.org/bots/api#suggestedpostprice | ✅ |
| [`SuggestedPostRefunded`](src/types/suggested_post_refunded.zig) | https://core.telegram.org/bots/api#suggestedpostrefunded | ✅ |
| [`TextQuote`](src/types/text_quote.zig) | https://core.telegram.org/bots/api#textquote | ✅ |
| [`UniqueGift`](src/types/unique_gift.zig) | https://core.telegram.org/bots/api#uniquegift | ✅ |
| [`UniqueGiftBackdrop`](src/types/unique_gift_backdrop.zig) | https://core.telegram.org/bots/api#uniquegiftbackdrop | ✅ |
| [`UniqueGiftBackdropColors`](src/types/unique_gift_backdrop_colors.zig) | https://core.telegram.org/bots/api#uniquegiftbackdropcolors | ✅ |
| [`UniqueGiftColors`](src/types/unique_gift_colors.zig) | https://core.telegram.org/bots/api#uniquegiftcolors | ✅ |
| [`UniqueGiftInfo`](src/types/unique_gift_info.zig) | https://core.telegram.org/bots/api#uniquegiftinfo | ✅ |
| [`UniqueGiftModel`](src/types/unique_gift_model.zig) | https://core.telegram.org/bots/api#uniquegiftmodel | ✅ |
| [`UniqueGiftSymbol`](src/types/unique_gift_symbol.zig) | https://core.telegram.org/bots/api#uniquegiftsymbol | ✅ |
| [`User`](src/types/user.zig) | https://core.telegram.org/bots/api#user | ✅ |
| [`UserChatBoosts`](src/types/user_chat_boosts.zig) | https://core.telegram.org/bots/api#userchatboosts | ✅ |
| [`UserProfileAudios`](src/types/user_profile_audios.zig) | https://core.telegram.org/bots/api#userprofileaudios | ✅ |
| [`UserProfilePhotos`](src/types/user_profile_photos.zig) | https://core.telegram.org/bots/api#userprofilephotos | ✅ |
| [`UserRating`](src/types/user_rating.zig) | https://core.telegram.org/bots/api#userrating | ✅ |
| [`UsersShared`](src/types/users_shared.zig) | https://core.telegram.org/bots/api#usersshared | ✅ |
| [`Venue`](src/types/venue.zig) | https://core.telegram.org/bots/api#venue | ✅ |
| [`Video`](src/types/video.zig) | https://core.telegram.org/bots/api#video | ✅ |
| [`VideoChatEnded`](src/types/video_chat_ended.zig) | https://core.telegram.org/bots/api#videochatended | ✅ |
| [`VideoChatParticipantsInvited`](src/types/video_chat_participants_invited.zig) | https://core.telegram.org/bots/api#videochatparticipantsinvited | ✅ |
| [`VideoChatScheduled`](src/types/video_chat_scheduled.zig) | https://core.telegram.org/bots/api#videochatscheduled | ✅ |
| [`VideoChatStarted`](src/types/video_chat_started.zig) | https://core.telegram.org/bots/api#videochatstarted | ✅ |
| [`VideoNote`](src/types/video_note.zig) | https://core.telegram.org/bots/api#videonote | ✅ |
| [`VideoQuality`](src/types/video_quality.zig) | https://core.telegram.org/bots/api#videoquality | ✅ |
| [`Voice`](src/types/voice.zig) | https://core.telegram.org/bots/api#voice | ✅ |
| [`WebAppData`](src/types/web_app_data.zig) | https://core.telegram.org/bots/api#webappdata | ✅ |
| [`WebAppInfo`](src/types/web_app_info.zig) | https://core.telegram.org/bots/api#webappinfo | ✅ |
| [`WriteAccessAllowed`](src/types/write_access_allowed.zig) | https://core.telegram.org/bots/api#writeaccessallowed | ✅ |

---

## Available Methods

| Method | Source | Status |
|--------|--------|--------|
| [`getMe`](src/methods/get_me.zig) | https://core.telegram.org/bots/api#getme | ✅ |
| [`logOut`](src/methods/log_out.zig) | https://core.telegram.org/bots/api#logout | ✅ |
| [`close`](src/methods/close.zig) | https://core.telegram.org/bots/api#close | ✅ |
| [`sendMessage`](src/methods/send_message.zig) | https://core.telegram.org/bots/api#sendmessage | ✅ |
| [`sendMessageDraft`](src/methods/send_message_draft.zig) | https://core.telegram.org/bots/api#sendmessagedraft | ✅ |
| [`forwardMessage`](src/methods/forward_message.zig) | https://core.telegram.org/bots/api#forwardmessage | ✅ |
| [`forwardMessages`](src/methods/forward_messages.zig) | https://core.telegram.org/bots/api#forwardmessages | ✅ |
| [`copyMessage`](src/methods/copy_message.zig) | https://core.telegram.org/bots/api#copymessage | ✅ |
| [`copyMessages`](src/methods/copy_messages.zig) | https://core.telegram.org/bots/api#copymessages | ✅ |
| [`sendPhoto`](src/methods/send_photo.zig) | https://core.telegram.org/bots/api#sendphoto | ✅ |
| [`sendAudio`](src/methods/send_audio.zig) | https://core.telegram.org/bots/api#sendaudio | ✅ |
| [`sendDocument`](src/methods/send_document.zig) | https://core.telegram.org/bots/api#senddocument | ✅ |
| [`sendVideo`](src/methods/send_video.zig) | https://core.telegram.org/bots/api#sendvideo | ✅ |
| [`sendAnimation`](src/methods/send_animation.zig) | https://core.telegram.org/bots/api#sendanimation | ✅ |
| [`sendVoice`](src/methods/send_voice.zig) | https://core.telegram.org/bots/api#sendvoice | ✅ |
| [`sendVideoNote`](src/methods/send_video_note.zig) | https://core.telegram.org/bots/api#sendvideonote | ✅ |
| [`sendLivePhoto`](src/methods/send_live_photo.zig) | https://core.telegram.org/bots/api#sendlivephoto | ✅ |
| [`sendPaidMedia`](src/methods/send_paid_media.zig) | https://core.telegram.org/bots/api#sendpaidmedia | ✅ |
| [`sendMediaGroup`](src/methods/send_media_group.zig) | https://core.telegram.org/bots/api#sendmediagroup | ✅ |
| [`sendLocation`](src/methods/send_location.zig) | https://core.telegram.org/bots/api#sendlocation | ✅ |
| [`sendVenue`](src/methods/send_venue.zig) | https://core.telegram.org/bots/api#sendvenue | ✅ |
| [`sendContact`](src/methods/send_contact.zig) | https://core.telegram.org/bots/api#sendcontact | ✅ |
| [`sendPoll`](src/methods/send_poll.zig) | https://core.telegram.org/bots/api#sendpoll | ✅ |
| [`sendRichMessageDraft`](src/methods/send_rich_message_draft.zig) | https://core.telegram.org/bots/api#sendrichmessagedraft | ✅ |
| [`sendRichMessage`](src/methods/send_rich_message.zig) | https://core.telegram.org/bots/api#sendrichmessage | ✅ |
| [`sendChecklist`](src/methods/send_checklist.zig) | https://core.telegram.org/bots/api#sendchecklist | ✅ |
| [`sendDice`](src/methods/send_dice.zig) | https://core.telegram.org/bots/api#senddice | ✅ |
| [`sendChatAction`](src/methods/send_chat_action.zig) | https://core.telegram.org/bots/api#sendchataction | ✅ |
| [`sendChatJoinRequestWebApp`](src/methods/send_chat_join_request_web_app.zig) | https://core.telegram.org/bots/api#sendchatjoinrequestwebapp | ✅ |
| [`setMessageReaction`](src/methods/set_message_reaction.zig) | https://core.telegram.org/bots/api#setmessagereaction | ✅ |
| [`getUserProfilePhotos`](src/methods/get_user_profile_photos.zig) | https://core.telegram.org/bots/api#getuserprofilephotos | ✅ |
| [`getUserProfileAudios`](src/methods/get_user_profile_audios.zig) | https://core.telegram.org/bots/api#getuserprofileaudios | ✅ |
| [`getUserPersonalChatMessages`](src/methods/get_user_personal_chat_messages.zig) | https://core.telegram.org/bots/api#getuserpersonalchatmessages | ✅ |
| [`setMyProfilePhoto`](src/methods/set_my_profile_photo.zig) | https://core.telegram.org/bots/api#setmyprofilephoto | ✅ |
| [`removeMyProfilePhoto`](src/methods/remove_my_profile_photo.zig) | https://core.telegram.org/bots/api#removemyprofilephoto | ✅ |
| [`getFile`](src/methods/get_file.zig) | https://core.telegram.org/bots/api#getfile | ✅ |
| [`banChatMember`](src/methods/ban_chat_member.zig) | https://core.telegram.org/bots/api#banchatmember | ✅ |
| [`unbanChatMember`](src/methods/unban_chat_member.zig) | https://core.telegram.org/bots/api#unbanchatmember | ✅ |
| [`restrictChatMember`](src/methods/restrict_chat_member.zig) | https://core.telegram.org/bots/api#restrictchatmember | ✅ |
| [`promoteChatMember`](src/methods/promote_chat_member.zig) | https://core.telegram.org/bots/api#promotechatmember | ✅ |
| [`setChatAdministratorCustomTitle`](src/methods/set_chat_administrator_custom_title.zig) | https://core.telegram.org/bots/api#setchatadministratorcustomtitle | ✅ |
| [`banChatSenderChat`](src/methods/ban_chat_sender_chat.zig) | https://core.telegram.org/bots/api#banchatsenderchat | ✅ |
| [`unbanChatSenderChat`](src/methods/unban_chat_sender_chat.zig) | https://core.telegram.org/bots/api#unbanchatsenderchat | ✅ |
| [`setChatPermissions`](src/methods/set_chat_permissions.zig) | https://core.telegram.org/bots/api#setchatpermissions | ✅ |
| [`exportChatInviteLink`](src/methods/export_chat_invite_link.zig) | https://core.telegram.org/bots/api#exportchatinvitelink | ✅ |
| [`createChatInviteLink`](src/methods/create_chat_invite_link.zig) | https://core.telegram.org/bots/api#createchatinvitelink | ✅ |
| [`editChatInviteLink`](src/methods/edit_chat_invite_link.zig) | https://core.telegram.org/bots/api#editchatinvitelink | ✅ |
| [`createChatSubscriptionInviteLink`](src/methods/create_chat_subscription_invite_link.zig) | https://core.telegram.org/bots/api#createchatsubscriptioninvitelink | ✅ |
| [`editChatSubscriptionInviteLink`](src/methods/edit_chat_subscription_invite_link.zig) | https://core.telegram.org/bots/api#editchatsubscriptioninvitelink | ✅ |
| [`revokeChatInviteLink`](src/methods/revoke_chat_invite_link.zig) | https://core.telegram.org/bots/api#revokechatinvitelink | ✅ |
| [`approveChatJoinRequest`](src/methods/approve_chat_join_request.zig) | https://core.telegram.org/bots/api#approvechatjoinrequest | ✅ |
| [`declineChatJoinRequest`](src/methods/decline_chat_join_request.zig) | https://core.telegram.org/bots/api#declinechatjoinrequest | ✅ |
| [`setChatPhoto`](src/methods/set_chat_photo.zig) | https://core.telegram.org/bots/api#setchatphoto | ✅ |
| [`deleteChatPhoto`](src/methods/delete_chat_photo.zig) | https://core.telegram.org/bots/api#deletechatphoto | ✅ |
| [`setChatTitle`](src/methods/set_chat_title.zig) | https://core.telegram.org/bots/api#setchattitle | ✅ |
| [`setChatDescription`](src/methods/set_chat_description.zig) | https://core.telegram.org/bots/api#setchatdescription | ✅ |
| [`pinChatMessage`](src/methods/pin_chat_message.zig) | https://core.telegram.org/bots/api#pinchatmessage | ✅ |
| [`unpinChatMessage`](src/methods/unpin_chat_message.zig) | https://core.telegram.org/bots/api#unpinchatmessage | ✅ |
| [`unpinAllChatMessages`](src/methods/unpin_all_chat_messages.zig) | https://core.telegram.org/bots/api#unpinallchatmessages | ✅ |
| [`leaveChat`](src/methods/leave_chat.zig) | https://core.telegram.org/bots/api#leavechat | ✅ |
| [`getChat`](src/methods/get_chat.zig) | https://core.telegram.org/bots/api#getchat | ✅ |
| [`getChatAdministrators`](src/methods/get_chat_administrators.zig) | https://core.telegram.org/bots/api#getchatadministrators | ✅ |
| [`getChatMemberCount`](src/methods/get_chat_member_count.zig) | https://core.telegram.org/bots/api#getchatmembercount | ✅ |
| [`getChatMember`](src/methods/get_chat_member.zig) | https://core.telegram.org/bots/api#getchatmember | ✅ |
| [`setChatStickerSet`](src/methods/set_chat_sticker_set.zig) | https://core.telegram.org/bots/api#setchatstickerset | ✅ |
| [`deleteChatStickerSet`](src/methods/delete_chat_sticker_set.zig) | https://core.telegram.org/bots/api#deletechatstickerset | ✅ |
| [`getForumTopicIconStickers`](src/methods/get_forum_topic_icon_stickers.zig) | https://core.telegram.org/bots/api#getforumtopiciconstickers | ✅ |
| [`createForumTopic`](src/methods/create_forum_topic.zig) | https://core.telegram.org/bots/api#createforumtopic | ✅ |
| [`editForumTopic`](src/methods/edit_forum_topic.zig) | https://core.telegram.org/bots/api#editforumtopic | ✅ |
| [`closeForumTopic`](src/methods/close_forum_topic.zig) | https://core.telegram.org/bots/api#closeforumtopic | ✅ |
| [`reopenForumTopic`](src/methods/reopen_forum_topic.zig) | https://core.telegram.org/bots/api#reopenforumtopic | ✅ |
| [`deleteForumTopic`](src/methods/delete_forum_topic.zig) | https://core.telegram.org/bots/api#deleteforumtopic | ✅ |
| [`unpinAllForumTopicMessages`](src/methods/unpin_all_forum_topic_messages.zig) | https://core.telegram.org/bots/api#unpinallforumtopicmessages | ✅ |
| [`editGeneralForumTopic`](src/methods/edit_general_forum_topic.zig) | https://core.telegram.org/bots/api#editgeneralforumtopic | ✅ |
| [`closeGeneralForumTopic`](src/methods/close_general_forum_topic.zig) | https://core.telegram.org/bots/api#closegeneralforumtopic | ✅ |
| [`reopenGeneralForumTopic`](src/methods/reopen_general_forum_topic.zig) | https://core.telegram.org/bots/api#reopengeneralforumtopic | ✅ |
| [`hideGeneralForumTopic`](src/methods/hide_general_forum_topic.zig) | https://core.telegram.org/bots/api#hidegeneralforumtopic | ✅ |
| [`unhideGeneralForumTopic`](src/methods/unhide_general_forum_topic.zig) | https://core.telegram.org/bots/api#unhidegeneralforumtopic | ✅ |
| [`unpinAllGeneralForumTopicMessages`](src/methods/unpin_all_general_forum_topic_messages.zig) | https://core.telegram.org/bots/api#unpinallgeneralforumtopicmessages | ✅ |
| [`answerCallbackQuery`](src/methods/answer_callback_query.zig) | https://core.telegram.org/bots/api#answercallbackquery | ✅ |
| [`answerChatJoinRequestQuery`](src/methods/answer_chat_join_request_query.zig) | https://core.telegram.org/bots/api#answerchatjoinrequestquery | ✅ |
| [`getUserChatBoosts`](src/methods/get_user_chat_boosts.zig) | https://core.telegram.org/bots/api#getuserchatboosts | ✅ |
| [`getBusinessConnection`](src/methods/get_business_connection.zig) | https://core.telegram.org/bots/api#getbusinessconnection | ✅ |
| [`setMyCommands`](src/methods/set_my_commands.zig) | https://core.telegram.org/bots/api#setmycommands | ✅ |
| [`deleteMyCommands`](src/methods/delete_my_commands.zig) | https://core.telegram.org/bots/api#deletemycommands | ✅ |
| [`getMyCommands`](src/methods/get_my_commands.zig) | https://core.telegram.org/bots/api#getmycommands | ✅ |
| [`setMyName`](src/methods/set_my_name.zig) | https://core.telegram.org/bots/api#setmyname | ✅ |
| [`getMyName`](src/methods/get_my_name.zig) | https://core.telegram.org/bots/api#getmyname | ✅ |
| [`setMyDescription`](src/methods/set_my_description.zig) | https://core.telegram.org/bots/api#setmydescription | ✅ |
| [`getMyDescription`](src/methods/get_my_description.zig) | https://core.telegram.org/bots/api#getmydescription | ✅ |
| [`setMyShortDescription`](src/methods/set_my_short_description.zig) | https://core.telegram.org/bots/api#setmyshortdescription | ✅ |
| [`getMyShortDescription`](src/methods/get_my_short_description.zig) | https://core.telegram.org/bots/api#getmyshortdescription | ✅ |
| [`setChatMenuButton`](src/methods/set_chat_menu_button.zig) | https://core.telegram.org/bots/api#setchatmenubutton | ✅ |
| [`getChatMenuButton`](src/methods/get_chat_menu_button.zig) | https://core.telegram.org/bots/api#getchatmenubutton | ✅ |
| [`setMyDefaultAdministratorRights`](src/methods/set_my_default_administrator_rights.zig) | https://core.telegram.org/bots/api#setmydefaultadministratorrights | ✅ |
| [`getMyDefaultAdministratorRights`](src/methods/get_my_default_administrator_rights.zig) | https://core.telegram.org/bots/api#getmydefaultadministratorrights | ✅ |
| [`answerGuestQuery`](src/methods/answer_guest_query.zig) | https://core.telegram.org/bots/api#answerguestquery | ✅ |
| [`readBusinessMessage`](src/methods/read_business_message.zig) | https://core.telegram.org/bots/api#readbusinessmessage | ✅ |
| [`deleteBusinessMessages`](src/methods/delete_business_messages.zig) | https://core.telegram.org/bots/api#deletebusinessmessages | ✅ |
| [`setBusinessAccountName`](src/methods/set_business_account_name.zig) | https://core.telegram.org/bots/api#setbusinessaccountname | ✅ |
| [`setBusinessAccountUsername`](src/methods/set_business_account_username.zig) | https://core.telegram.org/bots/api#setbusinessaccountusername | ✅ |
| [`setBusinessAccountBio`](src/methods/set_business_account_bio.zig) | https://core.telegram.org/bots/api#setbusinessaccountbio | ✅ |
| [`setBusinessAccountProfilePhoto`](src/methods/set_business_account_profile_photo.zig) | https://core.telegram.org/bots/api#setbusinessaccountprofilephoto | ✅ |
| [`removeBusinessAccountProfilePhoto`](src/methods/remove_business_account_profile_photo.zig) | https://core.telegram.org/bots/api#removebusinessaccountprofilephoto | ✅ |
| [`setBusinessAccountGiftSettings`](src/methods/set_business_account_gift_settings.zig) | https://core.telegram.org/bots/api#setbusinessaccountgiftsettings | ✅ |
| [`getBusinessAccountStarBalance`](src/methods/get_business_account_star_balance.zig) | https://core.telegram.org/bots/api#getbusinessaccountstarbalance | ✅ |
| [`transferBusinessAccountStars`](src/methods/transfer_business_account_stars.zig) | https://core.telegram.org/bots/api#transferbusinessaccountstars | ✅ |
| [`getBusinessAccountGifts`](src/methods/get_business_account_gifts.zig) | https://core.telegram.org/bots/api#getbusinessaccountgifts | ✅ |
| [`setUserEmojiStatus`](src/methods/set_user_emoji_status.zig) | https://core.telegram.org/bots/api#setuseremojistatus | ✅ |
| [`getManagedBotToken`](src/methods/get_managed_bot_token.zig) | https://core.telegram.org/bots/api#getmanagedbottoken | ✅ |
| [`getManagedBotAccessSettings`](src/methods/get_managed_bot_access_settings.zig) | https://core.telegram.org/bots/api#getmanagedbotaccesssettings | ✅ |
| [`setManagedBotAccessSettings`](src/methods/set_managed_bot_access_settings.zig) | https://core.telegram.org/bots/api#setmanagedbotaccesssettings | ✅ |
| [`replaceManagedBotToken`](src/methods/replace_managed_bot_token.zig) | https://core.telegram.org/bots/api#replacemanagedbottoken | ✅ |
| [`verifyUser`](src/methods/verify_user.zig) | https://core.telegram.org/bots/api#verifyuser | ✅ |
| [`removeUserVerification`](src/methods/remove_user_verification.zig) | https://core.telegram.org/bots/api#removeuserverification | ✅ |
| [`verifyChat`](src/methods/verify_chat.zig) | https://core.telegram.org/bots/api#verifychat | ✅ |
| [`removeChatVerification`](src/methods/remove_chat_verification.zig) | https://core.telegram.org/bots/api#removechatverification | ✅ |
| [`setChatMemberTag`](src/methods/set_chat_member_tag.zig) | https://core.telegram.org/bots/api#setchatmembertag | ✅ |
| [`getUserGifts`](src/methods/get_user_gifts.zig) | https://core.telegram.org/bots/api#getusergifts | ✅ |
| [`getChatGifts`](src/methods/get_chat_gifts.zig) | https://core.telegram.org/bots/api#getchatgifts | ✅ |
| [`convertGiftToStars`](src/methods/convert_gift_to_stars.zig) | https://core.telegram.org/bots/api#convertgifttostars | ✅ |
| [`upgradeGift`](src/methods/upgrade_gift.zig) | https://core.telegram.org/bots/api#upgradegift | ✅ |
| [`transferGift`](src/methods/transfer_gift.zig) | https://core.telegram.org/bots/api#transfergift | ✅ |
| [`postStory`](src/methods/post_story.zig) | https://core.telegram.org/bots/api#poststory | ✅ |
| [`editStory`](src/methods/edit_story.zig) | https://core.telegram.org/bots/api#editstory | ✅ |
| [`deleteStory`](src/methods/delete_story.zig) | https://core.telegram.org/bots/api#deletestory | ✅ |
| [`repostStory`](src/methods/repost_story.zig) | https://core.telegram.org/bots/api#repoststory | ✅ |
| [`approveSuggestedPost`](src/methods/approve_suggested_post.zig) | https://core.telegram.org/bots/api#approvesuggested post | ✅ |
| [`declineSuggestedPost`](src/methods/decline_suggested_post.zig) | https://core.telegram.org/bots/api#declinesuggestedpost | ✅ |

---

## Updating Messages

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`editMessageText`](src/methods/edit_message_text.zig) | https://core.telegram.org/bots/api#editmessagetext | ✅ |
| [`editMessageCaption`](src/methods/edit_message_caption.zig) | https://core.telegram.org/bots/api#editmessagecaption | ✅ |
| [`editMessageMedia`](src/methods/edit_message_media.zig) | https://core.telegram.org/bots/api#editmessagemedia | ✅ |
| [`editMessageLiveLocation`](src/methods/edit_message_live_location.zig) | https://core.telegram.org/bots/api#editmessagelivelocation | ✅ |
| [`stopMessageLiveLocation`](src/methods/stop_message_live_location.zig) | https://core.telegram.org/bots/api#stopmessagelivelocation | ✅ |
| [`editMessageReplyMarkup`](src/methods/edit_message_reply_markup.zig) | https://core.telegram.org/bots/api#editmessagereplymarkup | ✅ |
| [`editMessageChecklist`](src/methods/edit_message_checklist.zig) | https://core.telegram.org/bots/api#editmessagechecklist | ✅ |
| [`stopPoll`](src/methods/stop_poll.zig) | https://core.telegram.org/bots/api#stoppoll | ✅ |
| [`deleteMessage`](src/methods/delete_message.zig) | https://core.telegram.org/bots/api#deletemessage | ✅ |
| [`deleteMessages`](src/methods/delete_messages.zig) | https://core.telegram.org/bots/api#deletemessages | ✅ |
| [`deleteAllMessageReactions`](src/methods/delete_all_message_reactions.zig) | https://core.telegram.org/bots/api#deleteallmessagereactions | ✅ |
| [`deleteMessageReaction`](src/methods/delete_message_reaction.zig) | https://core.telegram.org/bots/api#deletemessagereaction | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`InputMedia`](src/types/input_media.zig) | https://core.telegram.org/bots/api#inputmedia | ✅ |
| [`InputMediaAnimation`](src/types/input_media_animation.zig) | https://core.telegram.org/bots/api#inputmediaanimation | ✅ |
| [`InputMediaAudio`](src/types/input_media_audio.zig) | https://core.telegram.org/bots/api#inputmediaaudio | ✅ |
| [`InputMediaDocument`](src/types/input_media_document.zig) | https://core.telegram.org/bots/api#inputmediadocument | ✅ |
| [`InputMediaLivePhoto`](src/types/input_media_live_photo.zig) | https://core.telegram.org/bots/api#inputmedialivephoto | ✅ |
| [`InputMediaLocation`](src/types/input_media_location.zig) | https://core.telegram.org/bots/api#inputmedialocation | ✅ |
| [`InputMediaPhoto`](src/types/input_media_photo.zig) | https://core.telegram.org/bots/api#inputmediaphoto | ✅ |
| [`InputMediaSticker`](src/types/input_media_sticker.zig) | https://core.telegram.org/bots/api#inputmediasticker | ✅ |
| [`InputMediaVenue`](src/types/input_media_venue.zig) | https://core.telegram.org/bots/api#inputmediavenue | ✅ |
| [`InputMediaVideo`](src/types/input_media_video.zig) | https://core.telegram.org/bots/api#inputmediavideo | ✅ |

---

## Stickers

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`sendSticker`](src/methods/send_sticker.zig) | https://core.telegram.org/bots/api#sendsticker | ✅ |
| [`getStickerSet`](src/methods/get_sticker_set.zig) | https://core.telegram.org/bots/api#getstickerset | ✅ |
| [`getCustomEmojiStickers`](src/methods/get_custom_emoji_stickers.zig) | https://core.telegram.org/bots/api#getcustomemojistickers | ✅ |
| [`uploadStickerFile`](src/methods/upload_sticker_file.zig) | https://core.telegram.org/bots/api#uploadstickerfile | ✅ |
| [`createNewStickerSet`](src/methods/create_new_sticker_set.zig) | https://core.telegram.org/bots/api#createnewstickerset | ✅ |
| [`addStickerToSet`](src/methods/add_sticker_to_set.zig) | https://core.telegram.org/bots/api#addstickertoset | ✅ |
| [`setStickerPositionInSet`](src/methods/set_sticker_position_in_set.zig) | https://core.telegram.org/bots/api#setstickerpositioninset | ✅ |
| [`deleteStickerFromSet`](src/methods/delete_sticker_from_set.zig) | https://core.telegram.org/bots/api#deletestickerfromset | ✅ |
| [`replaceStickerInSet`](src/methods/replace_sticker_in_set.zig) | https://core.telegram.org/bots/api#replacestickerinset | ✅ |
| [`setStickerEmojiList`](src/methods/set_sticker_emoji_list.zig) | https://core.telegram.org/bots/api#setstickeremojilist | ✅ |
| [`setStickerKeywords`](src/methods/set_sticker_keywords.zig) | https://core.telegram.org/bots/api#setstickerkeywords | ✅ |
| [`setStickerMaskPosition`](src/methods/set_sticker_mask_position.zig) | https://core.telegram.org/bots/api#setstickermaskposition | ✅ |
| [`setStickerSetTitle`](src/methods/set_sticker_set_title.zig) | https://core.telegram.org/bots/api#setstickersettitle | ✅ |
| [`setStickerSetThumbnail`](src/methods/set_sticker_set_thumbnail.zig) | https://core.telegram.org/bots/api#setstickersetthumbnail | ✅ |
| [`setCustomEmojiStickerSetThumbnail`](src/methods/set_custom_emoji_sticker_set_thumbnail.zig) | https://core.telegram.org/bots/api#setcustomemojistickersetthumbnail | ✅ |
| [`deleteStickerSet`](src/methods/delete_sticker_set.zig) | https://core.telegram.org/bots/api#deletestickerset | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`InputSticker`](src/types/input_sticker.zig) | https://core.telegram.org/bots/api#inputsticker | ✅ |
| [`MaskPosition`](src/types/mask_position.zig) | https://core.telegram.org/bots/api#maskposition | ✅ |
| [`Sticker`](src/types/sticker.zig) | https://core.telegram.org/bots/api#sticker | ✅ |
| [`StickerSet`](src/types/sticker_set.zig) | https://core.telegram.org/bots/api#stickerset | ✅ |

---

## Rich Messages

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`sendRichMessage`](src/methods/send_rich_message.zig) | https://core.telegram.org/bots/api#sendrichmessage | ✅ |
| [`sendRichMessageDraft`](src/methods/send_rich_message_draft.zig) | https://core.telegram.org/bots/api#sendrichmessagedraft | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`RichMessage`](src/types/rich_message.zig) | https://core.telegram.org/bots/api#richmessage | ✅ |
| [`InputRichMessage`](src/types/input_rich_message.zig) | https://core.telegram.org/bots/api#inputrichmessage | ✅ |
| [`RichText`](src/types/rich_text.zig) | https://core.telegram.org/bots/api#richtext | ✅ |
| [`RichTextBold`](src/types/rich_text_bold.zig) | https://core.telegram.org/bots/api#richtextbold | ✅ |
| [`RichTextItalic`](src/types/rich_text_italic.zig) | https://core.telegram.org/bots/api#richtextitalic | ✅ |
| [`RichTextUnderline`](src/types/rich_text_underline.zig) | https://core.telegram.org/bots/api#richtextunderline | ✅ |
| [`RichTextStrikethrough`](src/types/rich_text_strikethrough.zig) | https://core.telegram.org/bots/api#richtextstrikethrough | ✅ |
| [`RichTextSpoiler`](src/types/rich_text_spoiler.zig) | https://core.telegram.org/bots/api#richtextspoiler | ✅ |
| [`RichTextDateTime`](src/types/rich_text_date_time.zig) | https://core.telegram.org/bots/api#richtextdatetime | ✅ |
| [`RichTextTextMention`](src/types/rich_text_text_mention.zig) | https://core.telegram.org/bots/api#richtexttextmention | ✅ |
| [`RichTextSubscript`](src/types/rich_text_subscript.zig) | https://core.telegram.org/bots/api#richtextsubscript | ✅ |
| [`RichTextSuperscript`](src/types/rich_text_superscript.zig) | https://core.telegram.org/bots/api#richtextsuperscript | ✅ |
| [`RichTextMarked`](src/types/rich_text_marked.zig) | https://core.telegram.org/bots/api#richtextmarked | ✅ |
| [`RichTextCode`](src/types/rich_text_code.zig) | https://core.telegram.org/bots/api#richtextcode | ✅ |
| [`RichTextCustomEmoji`](src/types/rich_text_custom_emoji.zig) | https://core.telegram.org/bots/api#richtextcustomemoji | ✅ |
| [`RichTextMathematicalExpression`](src/types/rich_text_mathematical_expression.zig) | https://core.telegram.org/bots/api#richtextmathematicalexpression | ✅ |
| [`RichTextUrl`](src/types/rich_text_url.zig) | https://core.telegram.org/bots/api#richtexturl | ✅ |
| [`RichTextEmailAddress`](src/types/rich_text_email_address.zig) | https://core.telegram.org/bots/api#richtextemailaddress | ✅ |
| [`RichTextPhoneNumber`](src/types/rich_text_phone_number.zig) | https://core.telegram.org/bots/api#richtextphonenumber | ✅ |
| [`RichTextBankCardNumber`](src/types/rich_text_bank_card_number.zig) | https://core.telegram.org/bots/api#richtextbankcardnumber | ✅ |
| [`RichTextMention`](src/types/rich_text_mention.zig) | https://core.telegram.org/bots/api#richtextmention | ✅ |
| [`RichTextHashtag`](src/types/rich_text_hashtag.zig) | https://core.telegram.org/bots/api#richtexthashtag | ✅ |
| [`RichTextCashtag`](src/types/rich_text_cashtag.zig) | https://core.telegram.org/bots/api#richtextcashtag | ✅ |
| [`RichTextBotCommand`](src/types/rich_text_bot_command.zig) | https://core.telegram.org/bots/api#richtextbotcommand | ✅ |
| [`RichTextAnchor`](src/types/rich_text_anchor.zig) | https://core.telegram.org/bots/api#richtextanchor | ✅ |
| [`RichTextAnchorLink`](src/types/rich_text_anchor_link.zig) | https://core.telegram.org/bots/api#richtextanchorlink | ✅ |
| [`RichTextReference`](src/types/rich_text_reference.zig) | https://core.telegram.org/bots/api#richtextreference | ✅ |
| [`RichTextReferenceLink`](src/types/rich_text_reference_link.zig) | https://core.telegram.org/bots/api#richtextreferencelink | ✅ |
| [`RichBlock`](src/types/rich_block.zig) | https://core.telegram.org/bots/api#richblock | ✅ |
| [`RichBlockParagraph`](src/types/rich_block_paragraph.zig) | https://core.telegram.org/bots/api#richblockparagraph | ✅ |
| [`RichBlockSectionHeading`](src/types/rich_block_section_heading.zig) | https://core.telegram.org/bots/api#richblocksectionheading | ✅ |
| [`RichBlockPreformatted`](src/types/rich_block_preformatted.zig) | https://core.telegram.org/bots/api#richblockpreformatted | ✅ |
| [`RichBlockFooter`](src/types/rich_block_footer.zig) | https://core.telegram.org/bots/api#richblockfooter | ✅ |
| [`RichBlockDivider`](src/types/rich_block_divider.zig) | https://core.telegram.org/bots/api#richblockdivider | ✅ |
| [`RichBlockMathematicalExpression`](src/types/rich_block_mathematical_expression.zig) | https://core.telegram.org/bots/api#richblockmathematicalexpression | ✅ |
| [`RichBlockAnchor`](src/types/rich_block_anchor.zig) | https://core.telegram.org/bots/api#richblockanchor | ✅ |
| [`RichBlockList`](src/types/rich_block_list.zig) | https://core.telegram.org/bots/api#richblocklist | ✅ |
| [`RichBlockListItem`](src/types/rich_block_list_item.zig) | https://core.telegram.org/bots/api#richblocklistitem | ✅ |
| [`RichBlockBlockQuotation`](src/types/rich_block_block_quotation.zig) | https://core.telegram.org/bots/api#richblockblockquotation | ✅ |
| [`RichBlockPullQuotation`](src/types/rich_block_pull_quotation.zig) | https://core.telegram.org/bots/api#richblockpullquotation | ✅ |
| [`RichBlockCollage`](src/types/rich_block_collage.zig) | https://core.telegram.org/bots/api#richblockcollage | ✅ |
| [`RichBlockSlideshow`](src/types/rich_block_slideshow.zig) | https://core.telegram.org/bots/api#richblockslideshow | ✅ |
| [`RichBlockTable`](src/types/rich_block_table.zig) | https://core.telegram.org/bots/api#richblocktable | ✅ |
| [`RichBlockTableCell`](src/types/rich_block_table_cell.zig) | https://core.telegram.org/bots/api#richblocktablecell | ✅ |
| [`RichBlockDetails`](src/types/rich_block_details.zig) | https://core.telegram.org/bots/api#richblockdetails | ✅ |
| [`RichBlockMap`](src/types/rich_block_map.zig) | https://core.telegram.org/bots/api#richblockmap | ✅ |
| [`RichBlockAnimation`](src/types/rich_block_animation.zig) | https://core.telegram.org/bots/api#richblockanimation | ✅ |
| [`RichBlockAudio`](src/types/rich_block_audio.zig) | https://core.telegram.org/bots/api#richblockaudio | ✅ |
| [`RichBlockPhoto`](src/types/rich_block_photo.zig) | https://core.telegram.org/bots/api#richblockphoto | ✅ |
| [`RichBlockVideo`](src/types/rich_block_video.zig) | https://core.telegram.org/bots/api#richblockvideo | ✅ |
| [`RichBlockVoiceNote`](src/types/rich_block_voice_note.zig) | https://core.telegram.org/bots/api#richblockvoicenote | ✅ |
| [`RichBlockThinking`](src/types/rich_block_thinking.zig) | https://core.telegram.org/bots/api#richblockthinking | ✅ |
| [`RichBlockCaption`](src/types/rich_block_caption.zig) | https://core.telegram.org/bots/api#richblockcaption | ✅ |

---

## Inline Mode

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`answerInlineQuery`](src/methods/answer_inline_query.zig) | https://core.telegram.org/bots/api#answerinlinequery | ✅ |
| [`answerWebAppQuery`](src/methods/answer_web_app_query.zig) | https://core.telegram.org/bots/api#answerwebappquery | ✅ |
| [`savePreparedInlineMessage`](src/methods/save_prepared_inline_message.zig) | https://core.telegram.org/bots/api#savepreparedinlinemessage | ✅ |
| [`savePreparedKeyboardButton`](src/methods/save_prepared_keyboard_button.zig) | https://core.telegram.org/bots/api#savepreparedkeyboardbutton | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`ChosenInlineResult`](src/types/chosen_inline_result.zig) | https://core.telegram.org/bots/api#choseninlineresult | ✅ |
| [`InlineQuery`](src/types/inline_query.zig) | https://core.telegram.org/bots/api#inlinequery | ✅ |
| [`InlineQueryResult`](src/types/inline_query_result.zig) | https://core.telegram.org/bots/api#inlinequeryresult | ✅ |
| [`InlineQueryResultArticle`](src/types/inline_query_result_article.zig) | https://core.telegram.org/bots/api#inlinequeryresultarticle | ✅ |
| [`InlineQueryResultAudio`](src/types/inline_query_result_audio.zig) | https://core.telegram.org/bots/api#inlinequeryresultaudio | ✅ |
| [`InlineQueryResultCachedAudio`](src/types/inline_query_result_cached_audio.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedaudio | ✅ |
| [`InlineQueryResultCachedDocument`](src/types/inline_query_result_cached_document.zig) | https://core.telegram.org/bots/api#inlinequeryresultcacheddocument | ✅ |
| [`InlineQueryResultCachedGif`](src/types/inline_query_result_cached_gif.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedgif | ✅ |
| [`InlineQueryResultCachedMpeg4Gif`](src/types/inline_query_result_cached_mpeg4_gif.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedmpeg4gif | ✅ |
| [`InlineQueryResultCachedPhoto`](src/types/inline_query_result_cached_photo.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedphoto | ✅ |
| [`InlineQueryResultCachedSticker`](src/types/inline_query_result_cached_sticker.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedsticker | ✅ |
| [`InlineQueryResultCachedVideo`](src/types/inline_query_result_cached_video.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedvideo | ✅ |
| [`InlineQueryResultCachedVoice`](src/types/inline_query_result_cached_voice.zig) | https://core.telegram.org/bots/api#inlinequeryresultcachedvoice | ✅ |
| [`InlineQueryResultContact`](src/types/inline_query_result_contact.zig) | https://core.telegram.org/bots/api#inlinequeryresultcontact | ✅ |
| [`InlineQueryResultDocument`](src/types/inline_query_result_document.zig) | https://core.telegram.org/bots/api#inlinequeryresultdocument | ✅ |
| [`InlineQueryResultGame`](src/types/inline_query_result_game.zig) | https://core.telegram.org/bots/api#inlinequeryresultgame | ✅ |
| [`InlineQueryResultGif`](src/types/inline_query_result_gif.zig) | https://core.telegram.org/bots/api#inlinequeryresultgif | ✅ |
| [`InlineQueryResultLocation`](src/types/inline_query_result_location.zig) | https://core.telegram.org/bots/api#inlinequeryresultlocation | ✅ |
| [`InlineQueryResultMpeg4Gif`](src/types/inline_query_result_mpeg4_gif.zig) | https://core.telegram.org/bots/api#inlinequeryresultmpeg4gif | ✅ |
| [`InlineQueryResultPhoto`](src/types/inline_query_result_photo.zig) | https://core.telegram.org/bots/api#inlinequeryresultphoto | ✅ |
| [`InlineQueryResultsButton`](src/types/inline_query_results_button.zig) | https://core.telegram.org/bots/api#inlinequeryresultsbutton | ✅ |
| [`InlineQueryResultVenue`](src/types/inline_query_result_venue.zig) | https://core.telegram.org/bots/api#inlinequeryresultvenue | ✅ |
| [`InlineQueryResultVideo`](src/types/inline_query_result_video.zig) | https://core.telegram.org/bots/api#inlinequeryresultvideo | ✅ |
| [`InlineQueryResultVoice`](src/types/inline_query_result_voice.zig) | https://core.telegram.org/bots/api#inlinequeryresultvoice | ✅ |
| [`InputContactMessageContent`](src/types/input_contact_message_content.zig) | https://core.telegram.org/bots/api#inputcontactmessagecontent | ✅ |
| [`InputInvoiceMessageContent`](src/types/input_invoice_message_content.zig) | https://core.telegram.org/bots/api#inputinvoicemessagecontent | ✅ |
| [`InputLocationMessageContent`](src/types/input_location_message_content.zig) | https://core.telegram.org/bots/api#inputlocationmessagecontent | ✅ |
| [`InputMessageContent`](src/types/input_message_content.zig) | https://core.telegram.org/bots/api#inputmessagecontent | ✅ |
| [`InputTextMessageContent`](src/types/input_text_message_content.zig) | https://core.telegram.org/bots/api#inputtextmessagecontent | ✅ |
| [`InputVenueMessageContent`](src/types/input_venue_message_content.zig) | https://core.telegram.org/bots/api#inputvenuemessagecontent | ✅ |
| [`PreparedInlineMessage`](src/types/prepared_inline_message.zig) | https://core.telegram.org/bots/api#preparedinlinemessage | ✅ |
| [`PreparedKeyboardButton`](src/types/prepared_keyboard_button.zig) | https://core.telegram.org/bots/api#preparedkeyboardbutton | ✅ |
| [`SentGuestMessage`](src/types/sent_guest_message.zig) | https://core.telegram.org/bots/api#sentguestmessage | ✅ |
| [`SentWebAppMessage`](src/types/sent_web_app_message.zig) | https://core.telegram.org/bots/api#sentwebappmessage | ✅ |
| [`SwitchInlineQueryChosenChat`](src/types/switch_inline_query_chosen_chat.zig) | https://core.telegram.org/bots/api#switchinlinequerychosenchat | ✅ |

---

## Payments

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`sendInvoice`](src/methods/send_invoice.zig) | https://core.telegram.org/bots/api#sendinvoice | ✅ |
| [`createInvoiceLink`](src/methods/create_invoice_link.zig) | https://core.telegram.org/bots/api#createinvoicelink | ✅ |
| [`answerShippingQuery`](src/methods/answer_shipping_query.zig) | https://core.telegram.org/bots/api#answershippingquery | ✅ |
| [`answerPreCheckoutQuery`](src/methods/answer_pre_checkout_query.zig) | https://core.telegram.org/bots/api#answerprecheckoutquery | ✅ |
| [`getStarTransactions`](src/methods/get_star_transactions.zig) | https://core.telegram.org/bots/api#getstartransactions | ✅ |
| [`getMyStarBalance`](src/methods/get_my_star_balance.zig) | https://core.telegram.org/bots/api#getmystarbalance | ✅ |
| [`refundStarPayment`](src/methods/refund_star_payment.zig) | https://core.telegram.org/bots/api#refundstarpayment | ✅ |
| [`editUserStarSubscription`](src/methods/edit_user_star_subscription.zig) | https://core.telegram.org/bots/api#edituserstarsubscription | ✅ |
| [`getAvailableGifts`](src/methods/get_available_gifts.zig) | https://core.telegram.org/bots/api#getavailablegifts | ✅ |
| [`sendGift`](src/methods/send_gift.zig) | https://core.telegram.org/bots/api#sendgift | ✅ |
| [`giftPremiumSubscription`](src/methods/gift_premium_subscription.zig) | https://core.telegram.org/bots/api#giftpremiumsubscription | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`AffiliateInfo`](src/types/affiliate_info.zig) | https://core.telegram.org/bots/api#affiliateinfo | ✅ |
| [`Invoice`](src/types/invoice.zig) | https://core.telegram.org/bots/api#invoice | ✅ |
| [`LabeledPrice`](src/types/labeled_price.zig) | https://core.telegram.org/bots/api#labeledprice | ✅ |
| [`OrderInfo`](src/types/order_info.zig) | https://core.telegram.org/bots/api#orderinfo | ✅ |
| [`PreCheckoutQuery`](src/types/pre_checkout_query.zig) | https://core.telegram.org/bots/api#precheckoutquery | ✅ |
| [`RefundedPayment`](src/types/refunded_payment.zig) | https://core.telegram.org/bots/api#refundedpayment | ✅ |
| [`RevenueWithdrawalState`](src/types/revenue_withdrawal_state.zig) | https://core.telegram.org/bots/api#revenuewithdrawalstate | ✅ |
| [`RevenueWithdrawalStateFailed`](src/types/revenue_withdrawal_state_failed.zig) | https://core.telegram.org/bots/api#revenuewithdrawalstatefailed | ✅ |
| [`RevenueWithdrawalStatePending`](src/types/revenue_withdrawal_state_pending.zig) | https://core.telegram.org/bots/api#revenuewithdrawalstatepending | ✅ |
| [`RevenueWithdrawalStateSucceeded`](src/types/revenue_withdrawal_state_succeeded.zig) | https://core.telegram.org/bots/api#revenuewithdrawalstatesucceeded | ✅ |
| [`ShippingAddress`](src/types/shipping_address.zig) | https://core.telegram.org/bots/api#shippingaddress | ✅ |
| [`ShippingOption`](src/types/shipping_option.zig) | https://core.telegram.org/bots/api#shippingoption | ✅ |
| [`ShippingQuery`](src/types/shipping_query.zig) | https://core.telegram.org/bots/api#shippingquery | ✅ |
| [`StarAmount`](src/types/star_amount.zig) | https://core.telegram.org/bots/api#staramount | ✅ |
| [`StarTransaction`](src/types/star_transaction.zig) | https://core.telegram.org/bots/api#startransaction | ✅ |
| [`StarTransactions`](src/types/star_transactions.zig) | https://core.telegram.org/bots/api#startransactions | ✅ |
| [`SuccessfulPayment`](src/types/successful_payment.zig) | https://core.telegram.org/bots/api#successfulpayment | ✅ |
| [`TransactionPartner`](src/types/transaction_partner.zig) | https://core.telegram.org/bots/api#transactionpartner | ✅ |
| [`TransactionPartnerAffiliateProgram`](src/types/transaction_partner_affiliate_program.zig) | https://core.telegram.org/bots/api#transactionpartneraffiliateprogram | ✅ |
| [`TransactionPartnerChat`](src/types/transaction_partner_chat.zig) | https://core.telegram.org/bots/api#transactionpartnerchat | ✅ |
| [`TransactionPartnerFragment`](src/types/transaction_partner_fragment.zig) | https://core.telegram.org/bots/api#transactionpartnerfragment | ✅ |
| [`TransactionPartnerOther`](src/types/transaction_partner_other.zig) | https://core.telegram.org/bots/api#transactionpartnerother | ✅ |
| [`TransactionPartnerTelegramAds`](src/types/transaction_partner_telegram_ads.zig) | https://core.telegram.org/bots/api#transactionpartnertelegramads | ✅ |
| [`TransactionPartnerTelegramApi`](src/types/transaction_partner_telegram_api.zig) | https://core.telegram.org/bots/api#transactionpartnertelegramapi | ✅ |
| [`TransactionPartnerUser`](src/types/transaction_partner_user.zig) | https://core.telegram.org/bots/api#transactionpartneruser | ✅ |

---

## Telegram Passport

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`setPassportDataErrors`](src/methods/set_passport_data_errors.zig) | https://core.telegram.org/bots/api#setpassportdataerrors | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`EncryptedCredentials`](src/types/encrypted_credentials.zig) | https://core.telegram.org/bots/api#encryptedcredentials | ✅ |
| [`EncryptedPassportElement`](src/types/encrypted_passport_element.zig) | https://core.telegram.org/bots/api#encryptedpassportelement | ✅ |
| [`PassportData`](src/types/passport_data.zig) | https://core.telegram.org/bots/api#passportdata | ✅ |
| [`PassportElementError`](src/types/passport_element_error.zig) | https://core.telegram.org/bots/api#passportelementerror | ✅ |
| [`PassportElementErrorDataField`](src/types/passport_element_error_data_field.zig) | https://core.telegram.org/bots/api#passportelementerrordatafield | ✅ |
| [`PassportElementErrorFile`](src/types/passport_element_error_file.zig) | https://core.telegram.org/bots/api#passportelementerrorfile | ✅ |
| [`PassportElementErrorFiles`](src/types/passport_element_error_files.zig) | https://core.telegram.org/bots/api#passportelementerrorfiles | ✅ |
| [`PassportElementErrorFrontSide`](src/types/passport_element_error_front_side.zig) | https://core.telegram.org/bots/api#passportelementerrorfrontside | ✅ |
| [`PassportElementErrorReverseSide`](src/types/passport_element_error_reverse_side.zig) | https://core.telegram.org/bots/api#passportelementerrorreverseside | ✅ |
| [`PassportElementErrorSelfie`](src/types/passport_element_error_selfie.zig) | https://core.telegram.org/bots/api#passportelementerrorselfie | ✅ |
| [`PassportElementErrorTranslationFile`](src/types/passport_element_error_translation_file.zig) | https://core.telegram.org/bots/api#passportelementerrortranslationfile | ✅ |
| [`PassportElementErrorTranslationFiles`](src/types/passport_element_error_translation_files.zig) | https://core.telegram.org/bots/api#passportelementerrortranslationfiles | ✅ |
| [`PassportElementErrorUnspecified`](src/types/passport_element_error_unspecified.zig) | https://core.telegram.org/bots/api#passportelementerrorunspecified | ✅ |
| [`PassportFile`](src/types/passport_file.zig) | https://core.telegram.org/bots/api#passportfile | ✅ |

---

## Games

### Methods

| Method | Source | Status |
|--------|--------|--------|
| [`sendGame`](src/methods/send_game.zig) | https://core.telegram.org/bots/api#sendgame | ✅ |
| [`setGameScore`](src/methods/set_game_score.zig) | https://core.telegram.org/bots/api#setgamescore | ✅ |
| [`getGameHighScores`](src/methods/get_game_high_scores.zig) | https://core.telegram.org/bots/api#getgamehighscores | ✅ |

### Types

| Type | Source | Status |
|------|--------|--------|
| [`CallbackGame`](src/types/callback_game.zig) | https://core.telegram.org/bots/api#callbackgame | ✅ |
| [`Game`](src/types/game.zig) | https://core.telegram.org/bots/api#game | ✅ |
| [`GameHighScore`](src/types/game_high_score.zig) | https://core.telegram.org/bots/api#gamehighscore | ✅ |
