//
//  Format.swift
//  generation
//
//  Created by Terry Latanville on 2020-07-30.
//

import Foundation

enum Format: String {
    case json
    case markdown = "md"
    case html

    var suffix: String { "." + rawValue }
}
