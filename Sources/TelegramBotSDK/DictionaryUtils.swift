//
// DictionaryUtils.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//

import Foundation

/*
func + <K,V> (left: Dictionary<K,V>, right: Dictionary<K,V>?) -> Dictionary<K,V> {
	guard let right = right else { return left }
	return left.reduce(right) {
		var new = $0 as [K:V]
		new.updateValue($1.1, forKey: $1.0)
		return new
	}
}
*/

/*
func += <K,V> (left: inout Dictionary<K,V>, right: Dictionary<K,V>?) {
	guard let right = right else { return }
	right.forEach { key, value in
		left.updateValue(value, forKey: key)
	}
}
*/
