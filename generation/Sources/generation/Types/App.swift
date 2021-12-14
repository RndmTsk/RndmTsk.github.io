//
//  App.swift
//  generation
//
//  Created by Terry Latanville on 2020-08-07.
//

import Foundation

struct App: Codable {
    let title: String
    let icon: String
    let url: String
}

// MARK: - <Exportable>
extension App: Exportable {
    static var preferredRawFormat: Format { .json }
}

// MARK: - <Templatable>
extension App: Templatable {
    static var template: Exportable {
        App(title: "Sample App",
            icon: "sample-app.png",
            url: "https://apps.apple.com/ca/app/er-mapper/id1200334898")
    }
}
