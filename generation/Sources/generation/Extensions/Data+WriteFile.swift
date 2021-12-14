//
//  Data+WriteFile.swift
//  generation
//
//  Created by Terry Latanville on 2020-08-07.
//

import Foundation

fileprivate extension NSError {
    static let fileExists = NSError(domain: "com.generation.error.file.exists", code: 0, userInfo: nil)
}

extension Data {
    func write(to filename: String, in directory: String) throws {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(atPath: directory, withIntermediateDirectories: true)
        }
        let filePath = "\(directory)/\(filename)"
        guard !fileManager.fileExists(atPath: filePath) else { throw NSError.fileExists }
        fileManager.createFile(atPath: filePath, contents: self)
    }
}
