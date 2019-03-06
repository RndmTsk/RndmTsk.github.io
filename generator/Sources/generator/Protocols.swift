//
//  Protocols.swift
//  generator
//
//  Created by Terry Latanville on 2019-02-18.
//

import Foundation

protocol Titled {
    var title: String { get }
}

protocol FormatExportable {
    static func path(for format: Format) -> String
    static func dataFilenames() throws -> [String]
    func filename(for format: Format) -> String
    func export(as format: Format) throws
}

extension FormatExportable {
    static func dataFilenames() throws -> [String] {
        let dataPath = path(for: .json)
        return try FileManager.default
            .contentsOfDirectory(atPath: dataPath)
            .filter { $0.hasSuffix(Format.json.suffix) }
            .map { dataPath.appending("/").appending($0) }
    }
}

extension FormatExportable where Self: Titled {
    func filename(for format: Format) -> String {
        return title.lowercased().replacingOccurrences(of: " ", with: "-") + format.suffix
    }
}

extension FormatExportable where Self: Encodable {
    func export(as format: Format) throws {
        let path = Self.path(for: format)
        let filename = self.filename(for: format)
        try write(as: format, path: path, filename: filename)
    }
}

protocol ContextInitable {
    init(context: ArraySlice<String>) throws
}

protocol SelfDocumenting {
    static func emitDocumentation()
}
