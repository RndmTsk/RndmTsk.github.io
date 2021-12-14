//
//  Encodable+WriteJSON.swift
//  generation
//
//  Created by Terry Latanville on 2020-07-30.
//

import Foundation

extension Encodable where Self: Exportable {
    func write(as format: Format, path: String, filename: String) throws {
        switch format {
        case .json:
            try JSONEncoder().encode(self).write(to: filename, in: path)
        case .markdown:
            let rawMarkdown = """
            # \(self.title)

            Sample \(String(describing: Self.self)) content.
            """
            let url = URL(fileURLWithPath: path).appendingPathComponent(filename)
            try rawMarkdown.write(to: url, atomically: true, encoding: .utf8)
        case .html:
            throw ExportableErrors.htmlEncoderUnavailable(for: Self.self)
        }
    }
}
