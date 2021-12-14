//
//  Article.swift
//  generation
//
//  Created by Terry Latanville on 2020-07-30.
//

import Foundation

enum Topic: String, RawRepresentable, Codable {
    // MARK: - Cases
    case swiftBasics = "swift basics"
    case swift
    case personal

    // MARK: - Properties
    var fontAwesomeDescription: String {
        switch self {
        case .swiftBasics:
            return "fab fa-swift yellow-50"
        case .swift:
            return "fab fa-swift orange-50"
        case .personal:
            return "fas fa-newspaper white-85"
        }
    }

    // MARK: - Object Lifecycle
    init?(rawValue: String) {
        if rawValue.hasPrefix(Topic.swiftBasics.rawValue) {
            self = .swiftBasics
        } else if rawValue.hasPrefix(Topic.swift.rawValue) {
            self = .swift
        } else {
            self = .personal
        }
    }
}

struct Article: Codable {
    // MARK: - Properties
    let title: String
    let topic: Topic
    let content: String

    // TODO: (TL) Do we still need these?
//    let intro: String
//    let date: Date
//    let content: String
//    let tags: [String]

    var link: String {
        (title
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: ":", with: "-")
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ??
            "article-\(title.hash)").appending(".html")
    }
}

// MARK: - <Importable>
extension Article: Importable {
    init(filename: String, content: String) {
        let fileURL = URL(string: filename)!
        let title = fileURL.lastPathComponent
            .replacingOccurrences(of: fileURL.pathExtension, with: "")
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: ".", with: "")

        let topic = Topic(rawValue: title)!
        self.init(title: title.capitalized,
                  topic: topic,
                  content: content)
    }
}

// MARK: - <Exportable>
extension Article: Exportable {
    static var preferredRawFormat: Format { .markdown }
}

// MARK: - <Templatable>
extension Article: Templatable {
    static var template: Exportable {
        Article(title: "Sample Title",
                topic: .swiftBasics,
                content: "An example of where you can put an image of a project, or anything else, along with a description.")
    }
}
