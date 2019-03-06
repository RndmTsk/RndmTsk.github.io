//
//  Extensions.swift
//  generator
//
//  Created by Terry Latanville on 2019-02-18.
//

import Foundation

extension Date {
    static var now: Date {
        return Date()
    }
}

extension Data {
    func write(to filename: String, in directory: String) throws {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(atPath: directory, withIntermediateDirectories: true)
        }
        let filePath = "\(directory)/\(filename)"
        guard !fileManager.fileExists(atPath: filePath) else { throw FileCreateError.fileExists }
        fileManager.createFile(atPath: filePath, contents: self)
    }
}

extension ArraySlice where Element == String {
    func asCommandFlags() -> [String: String] {
        var keys: [String] = []
        var values: [String] = []
        for (offset, element) in enumerated() {
            if offset % 2 == 0 {
                keys.append(element)
            } else {
                values.append(element)
            }
        }
        if values.count < keys.count {
            values.append("")
        }
        return Dictionary(zip(keys, values)) { lhs, _ in lhs }
    }
}

extension Encodable {
    func write(as format: Format, path: String, filename: String) throws {
        guard format == .json else { throw NSError.incorrectUsageError }
        try JSONEncoder().encode(self).write(to: filename, in: path)
    }
}

extension NSError {
    static let incorrectUsageError = NSError(domain: "encodable.write", code: 0, userInfo: [
            NSLocalizedDescriptionKey: "write(as:path:filename:) does not support .html"
        ])
}
