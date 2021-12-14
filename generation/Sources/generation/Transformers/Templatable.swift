//
//  Templatable.swift
//  generation
//
//  Created by Terry Latanville on 2020-10-30.
//

import Foundation

protocol Templatable {
    static var template: Exportable { get }
}
