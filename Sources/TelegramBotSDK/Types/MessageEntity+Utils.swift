//
// MessageEntity+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//

import Foundation

public enum MessageEntityType: String, Codable {
    case mention
    case hashtag
    case cashtag
    case botCommand = "bot_command"
    case url
    case email
    case phoneNumber = "phone_number"
    case bold
    case italic
    case underline
    case strikethrough
    case code
    case pre
    case textLink = "text_link"
    case textMention = "text_mention"
    case spoiler
    case customEmoji = "custom_emoji"
}
