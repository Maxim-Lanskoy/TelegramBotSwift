//
// TelegramBot+sendChatAction+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//

import Foundation
import Dispatch


public extension TelegramBot {
	enum ChatAction: String, Codable {
		case typing = "typing"
		case uploadPhoto = "upload_photo"
		case recordVideo = "record_video"
		case uploadVideo = "upload_video"
		case recordAudio = "record_audio"
		case uploadAudio = "upload_audio"
		case uploadDocument = "upload_document"
		case findLocation = "find_location"
	}
	
    /// Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status).
    /// Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use sendChatAction with action = upload_photo. The user will see a “sending photo” status for the bot.
    /// We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.
    /// - Parameters:
    ///     - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - action: Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data.
    /// - Returns: Bool on success. Nil on error, in which case `TelegramBot.lastError` contains the details.
    /// - Note: Blocking version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	@discardableResult
    func sendChatActionSync(chatId: ChatId, action: ChatAction,
	                               _ parameters: [String: Encodable?] = [:]) -> Bool? {
		return requestSync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		                   ["chat_id": chatId, "action": action])
	}
	
    /// Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status).
    /// Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use sendChatAction with action = upload_photo. The user will see a “sending photo” status for the bot.
    /// We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.
    /// - Parameters:
    ///     - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    ///     - action: Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data.
    /// - Returns: Bool on success. Nil on error, in which case `error` contains the details.
    /// - Note: Asynchronous version of the method.
    ///
    /// - SeeAlso: <https://core.telegram.org/bots/api#sendchataction>
	func sendChatActionAsync(chatId: ChatId, action: ChatAction,
	                                _ parameters: [String: Encodable?] = [:],
	                                queue: DispatchQueue = DispatchQueue.main,
	                                completion: SendChatActionCompletion? = nil) {
		requestAsync("sendChatAction", defaultParameters["sendChatAction"], parameters,
		             ["chat_id": chatId, "action": action],
		             queue: queue, completion: completion)
	}
}

