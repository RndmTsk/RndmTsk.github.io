//
//  Importable.swift
//  generation
//
//  Created by Terry Latanville on 2021-02-07.
//

import Foundation

protocol Importable: RawFormatRepresentable {
    init(filename: String, content: String)
}

extension Importable {
    init?(filename: String, data: Data?) {
        guard let contentData = data,
              let content = String(data: contentData, encoding: .utf8)
        else { return nil }

        // TODO: (TL) Transform filename
        self.init(filename: filename, content: content)
    }
}
