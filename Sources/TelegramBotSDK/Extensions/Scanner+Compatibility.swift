import Foundation

extension Scanner {
    #if os(OSX)
    func scanInt() -> Int? {
        var result: Int = 0
        return scanInt(&result) ? result : nil
    }
    #endif

    func scanInt64() -> Int64? {
        var result: Int64 = 0
        return scanInt64(&result) ? result : nil
    }

    func scanUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanUnsignedLongLong(&result) ? result : nil
    }

    func scanHexUInt64() -> UInt64? {
        var result: UInt64 = 0
        return scanHexInt64(&result) ? result : nil
    }

    func scanHexFloat() -> Float? {
        var result: Float = 0.0
        return scanHexFloat(&result) ? result : nil
    }

    func scanHexDouble() -> Double? {
        var result: Double = 0.0
        return scanHexDouble(&result) ? result : nil
    }

    #if os(Linux) || os(Windows)
    func scanCharacters(from set: CharacterSet) -> String? {
        return scanCharactersFromSet(set)
    }
    #endif

    #if os(Linux) || os(Windows)
    func scanUpTo(_ string: String) -> String? {
        if string.isEmpty {
            return scanUpToCharacters(from: CharacterSet())
        }
        return scanUpToString(string)
    }
    #endif

    #if os(Linux) || os(Windows)
    func scanUpToCharacters(from set: CharacterSet) -> String? {
        return scanUpToCharactersFromSet(set)
    }
    #endif
}


