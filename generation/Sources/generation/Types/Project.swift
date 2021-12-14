//
//  Project.swift
//  generation
//
//  Created by Terry Latanville on 2020-07-30.
//

import Foundation

struct Project: Codable {
    let title: String
    let color: String
    let icon: String
    let url: String
    let tagline: String
    let languages: [String]
}

// MARK: - <Exportable>
extension Project: Exportable {
    static var preferredRawFormat: Format { .json }
}

// MARK: - <Templatable>
extension Project: Templatable {
    static var template: Exportable {
        Project(
            title: "Sample Title",
            color: "blue",
            icon: "layer",
            url: "https://github.com/RndmTsk/GLSLVisualizer-iOS",
            tagline: "Learning",
            languages: ["Objective-C", "OpenGL"]
        )
    }
}
