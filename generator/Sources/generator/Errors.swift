//
//  Errors.swift
//  generator
//
//  Created by Terry Latanville on 2019-02-18.
//

import Foundation

enum FileCreateError: Error {
    case fileExists
}

enum WebsiteCreateError: Error {
    case actionNotSupported
    case noPosts
}
