//
// DataTaskError.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//

import Foundation
import CCurl

/// Telegram DataTask errors
public enum DataTaskError {
    /// Invalid request
    case invalidRequest
    
    /// Libcurl initialization error
    case libcurlInitError
    
    /// Libcurl error
    case libcurlError(code: CURLcode, description: String)
    
    /// Aborted by callback
    case libcurlAbortedByCallback
    
    /// Status Code is not 200 (OK)
    case invalidStatusCode(statusCode: Int, telegramDescription: String, telegramErrorCode: Int, data: Data?)
    
    /// Telegram server returned no data
    case noDataReceived
    
    /// Server error (server returned "ok: false")
    case serverError(data: Data)
    
    /// Codable failed to decode to type
    case decodeError(data: Data)
}

extension DataTaskError: CustomDebugStringConvertible {
    // MARK: CustomDebugStringConvertible
    public var debugDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid HTTP request"
        case .libcurlInitError:
            return "Libcurl initialization error"
        case let .libcurlError(code, description):
            return "Libcurl error \(code.rawValue): \(description)"
        case .libcurlAbortedByCallback:
            return "Libcurl aborted by callback"
        case let .invalidStatusCode(statusCode, telegramDescription, _, _):
            return "Expected status code 200, got \(statusCode): \(telegramDescription)"
        case .noDataReceived:
            return "No data received"
        case .serverError:
            return "Telegram server returned an error"
        case .decodeError:
            return "Codable failed to decode result"
        }
    }
}
