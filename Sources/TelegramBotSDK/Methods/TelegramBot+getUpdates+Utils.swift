//
// TelegramBot+getUpdates+Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//

import Foundation
import CCurl

extension TelegramBot {
    /// Returns next unprocessed update from Telegram.
    ///
    /// If no more updates are available in local queue, the method blocks while
    /// trying to fetch more from the server.
    ///
    /// - Returns: `Update` object. Nil on error, in which case details can be
    ///            obtained using `lastError` property.
    public func nextUpdateSync() -> Update? {
        if unprocessedUpdates.isEmpty {
            var updates: [Update]?
            var retryCount = 0
            while true {
                updates = getUpdatesSync(offset: nextOffset, limit: defaultUpdatesLimit, timeout: defaultUpdatesTimeout)
                if updates == nil {
                    // Retry on temporary problems
                    if autoReconnect, let error = lastError, case .libcurlError(let code, _) = error {
                        switch code {
                        case CURLE_COULDNT_RESOLVE_PROXY, CURLE_COULDNT_RESOLVE_HOST, CURLE_COULDNT_CONNECT, CURLE_OPERATION_TIMEDOUT, CURLE_SSL_CONNECT_ERROR, CURLE_SEND_ERROR, CURLE_RECV_ERROR:
                            let delay = reconnectDelay(retryCount)
                            retryCount += 1
                            if delay == 0.0 {
                                logger("Reconnect attempt \(retryCount), will retry at once")
                            } else {
                                logger("Reconnect attempt \(retryCount), will retry after \(delay) sec")
                                wait(seconds: delay)
                            }
                            continue
                        default:
                            break
                        }
                    }
                    // Unrecoverable error, report to caller
                    return nil
                }
                if let updates = updates, !updates.isEmpty {
                    break
                }
                // else try again
            }
            unprocessedUpdates = updates!
        }
        
        guard let update = unprocessedUpdates.first else {
            return nil
        }
        
        let nextUpdateId = update.updateId + 1
        if nextOffset == nil || nextUpdateId > nextOffset! {
            nextOffset = nextUpdateId
        }
		unprocessedUpdates.remove(at: 0)
        return update
    }
    
//    static public func nextEverywhereUpdateSyncWorking(bots: [TelegramBot]) -> Update? {
//        var bots = bots
//        let emptyBots = bots.filter({$0.unprocessedUpdates.isEmpty})
//        var allUnprocessedUpdates = bots.flatMap({$0.unprocessedUpdates})
//        if emptyBots.count == bots.count {
//            var updates: [Update]?
//            while true {
//                for (index, emptyBot) in emptyBots.enumerated() {
//                    print(index)
//                    let offset = emptyBot.nextOffset
//                    let limit = emptyBot.defaultUpdatesLimit
//                    let botUpdates = emptyBot.getUpdatesSync(offset: offset, limit: limit)
//                    if let safeUpdates = botUpdates, safeUpdates.count > 0 {
//                        if let tmp = updates, tmp.count > 0 {
//                            updates?.append(contentsOf: safeUpdates)
//                        } else {
//                            updates = safeUpdates
//                        }
//                        let presentUpdates = emptyBot.unprocessedUpdates
//                        updates?.forEach({ update in
//                            if !presentUpdates.contains(where: {$0.updateId == update.updateId}) {
//                                emptyBot.unprocessedUpdates.append(update)
//                            }
//                        })
//                        bots = bots.reversed()
//                    }
//                }
//                guard let safeUpdates = updates, !safeUpdates.isEmpty else { continue }
//                allUnprocessedUpdates.append(contentsOf: safeUpdates)
//                break
//            }
//        }
//        guard let next = allUnprocessedUpdates.first else { return nil }
//        guard let bot = bots.first(where: {$0.unprocessedUpdates.contains(where: {$0.updateId == next.updateId})}) else {
//            print("what")
//            return nil
//        }
//        let nextUpdateId = next.updateId + 1
//        if bot.nextOffset == nil || nextUpdateId > bot.nextOffset! {
//            bot.nextOffset = nextUpdateId
//        }
//        bot.unprocessedUpdates.remove(at: 0)
//        return next
//    }
//
//    static public func nextEverywhereUpdateSync(bots: inout [TelegramBot]) -> Update? {
//        var unprocessedUpdates = bots.flatMap({$0.unprocessedUpdates})
//        if unprocessedUpdates.isEmpty {
//            while true {
//                let emptyBots = bots.filter({$0.unprocessedUpdates.isEmpty})
//                for bot in emptyBots {
//                    guard bot.botIsPollingUpdates == false else { continue }
//                    let offset = bot.nextOffset
//                    let limits = bot.defaultUpdatesLimit
//                    let timeout = bot.defaultUpdatesTimeout
//                    bot.botIsPollingUpdates = true
//                    bot.getUpdatesAsync(offset: offset, limit: limits, timeout: timeout) { updates, _ in
//                        if let safeUpdates = updates, safeUpdates.count > 0 {
//                            bot.unprocessedUpdates.append(contentsOf: safeUpdates)
//                            if unprocessedUpdates.isEmpty {
//                                unprocessedUpdates.append(contentsOf: safeUpdates)
//                                if bot.botIsPollingUpdates == true {
//                                    bot.botIsPollingUpdates = false
//                                }
//                            }
//                        }
//                    }
//                }
//                if !unprocessedUpdates.isEmpty { break }
//            }
//        }
//        guard let next = unprocessedUpdates.first else { return nil }
//        guard let bot = bots.first(where: {
//            $0.unprocessedUpdates.contains(where: {
//                $0.updateId == next.updateId
//            })
//        }) else {
//            return nil
//        }
//        let nextUpdateId = next.updateId + 1
//        if bot.nextOffset == nil || nextUpdateId > bot.nextOffset! {
//            bot.nextOffset = nextUpdateId
//        }
//        bot.unprocessedUpdates.remove(at: 0)
//        return next
//    }
}
