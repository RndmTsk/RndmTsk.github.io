//
//  Project.swift
//  generator
//
//  Created by Terry Latanville on 2019-02-18.
//

import Foundation

struct Project: Codable {
    // MARK: - Properties
    let title: String
    let link: String
    let tags: [String]

    // MARK: - Lifecycle Functions
    init(title: String, link: String, tags: [String]) {
        self.title = title
        self.link = link
        self.tags = tags
    }
}

// MARK: - <ContextInitable>
extension Project: ContextInitable {
    // MARK: - ArgKeys
    private struct ArgKeys {
        static let title = "--title"
        static let link = "--link"
        static let tags = "--tags"
    }

    init(context: ArraySlice<String>) throws {
        let keyValuePairs = context.asCommandFlags()
        let title = keyValuePairs[ArgKeys.title, default: "title"]
        let link = keyValuePairs[ArgKeys.link, default: ""]
        let tags = keyValuePairs[ArgKeys.tags, default: ""].components(separatedBy: ",")
        self.init(title: title, link: link, tags: tags)
    }
}

// MARK: - <Exportable>
extension Project: FormatExportable {
    static func path(for format: Format) -> String {
        switch format {
        case .json: return "./project-data"
        case .html: return "./projects"
        }
    }
}

// MARK: - <Titled>
extension Project: Titled {}

// MARK: - <SelfDocumenting>
extension Project: SelfDocumenting {
    static func emitDocumentation() {
        print("project: Creates a new project.json with default values.")
        print("  Available parameters:")
        print("  --title <title>")
        print("  --link <project link>")
        print("  --tags <comma,delimited,tags>")
    }
}
