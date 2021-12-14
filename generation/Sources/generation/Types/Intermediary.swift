//
//  Intermediary.swift
//  generation
//
//  Created by Terry Latanville on 2021-02-07.
//

import Foundation

struct Intermediary {
    let filename: String
    let content: String
}

extension Intermediary {
    init?(filename: String, possibleData: Data?) {
        guard let data = possibleData,
              let content = String(data: data, encoding: .utf8)
        else { return nil }
        self.init(filename: filename, content: content)
    }
}
