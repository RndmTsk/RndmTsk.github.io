//
//  Exportable.swift
//  generation
//
//  Created by Terry Latanville on 2020-07-30.
//

import Foundation

enum ExportableErrors {
    static func htmlEncoderUnavailable<T>(for type: T.Type) -> Error {
        NSError(domain: "com.generator.encode.html", code: 0, userInfo: [
            NSLocalizedDescriptionKey: "\(String(describing: type)) does not support HTML encoding."
        ])
    }
}

protocol Exportable: RawFormatRepresentable {
    /// Exports `self` using the `preferredRawFormat`.
    func export() throws

    /// Exports `self` using the specified `format`.
    ///
    /// - Parameter format: A `Format`, used to determine the file extension (e.g. `.html`, `.json`, `.md`)
    func export(as format: Format) throws
}

// MARK: - Default Implementations
extension Exportable {
    func export() throws {
        try export(as: Self.preferredRawFormat)
    }
}

// MARK: - <Exportable> x <Encodable>
extension Exportable where Self: Encodable {
    func export(as format: Format) throws {
        let filename = self.filename(for: format)
        let path = Self.path(for: format)
        try write(as: format,
                  path: path,
                  filename: filename)
    }
}
