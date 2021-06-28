//
// Utils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//

import Foundation

/// Reads token from environment variable or from a file.
///
/// - Returns: token.
public func readToken(from name: String) -> String {
	guard let token: String = readConfigurationValue(name) else {
		print("\n" +
			"-----\n" +
			"ERROR\n" +
			"-----\n" +
			"Please create either:\n" +
			"  - an environment variable named \(name)\n" +
			"  - a file named \(name)\n" +
			"containing your bot's token.\n\n")
		exit(1)
	}
	return token
}

/// Reads value from environment variable or from a file.
///
/// - Returns: `String`.
public func readConfigurationValue(_ name: String) -> String? {
	let environment = ProcessInfo.processInfo.environment
	var value = environment[name]
	if value == nil {
		do {
			value = try String(contentsOfFile: name, encoding: String.Encoding.utf8)
		} catch {
		}
	}
	if let value = value {
		return value.trimmed()
	}
	return nil
}

/// Reads value from environment variable or from a file.
///
/// - Returns: `Int64`.
public func readConfigurationValue(_ name: String) -> Int64? {
	if let v: String = readConfigurationValue(name) {
		return Int64(v)
	}
	return nil
}

/// Reads value from environment variable or from a file.
///
/// - Returns: `Int`.
public func readConfigurationValue(_ name: String) -> Int? {
	if let v: String = readConfigurationValue(name) {
		return Int(v)
	}
	return nil
}

