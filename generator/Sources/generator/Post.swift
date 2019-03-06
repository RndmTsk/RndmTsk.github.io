//
//  Post.swift
//  generator
//
//  Created by Terry Latanville on 2019-02-18.
//

import Foundation

struct Post: Codable {
    // MARK: - Constants
    private struct Constants {
        static let snippetLength = 600
    }
    // MARK: - Properties
    static let template: Template = .post
    let title: String
    let author: String
    let content: String
    let callout: String
    let snippet: String
    let date: Date
    let formattedDate: String
    let tags: [String]
    private(set) var link = ""

    // MARK: - Lifecycle Functions
    init(title: String, author: String, content: String, callout: String, tags: [String]) {
        self.title = title
        self.author = author
        self.content = content
        self.callout = callout
        // TODO: (TL) Account for chopping words!
        let snippetOffset = min(content.count, Constants.snippetLength)
        let snippetLength = content.index(content.startIndex, offsetBy: snippetOffset)
        self.snippet = String(content[content.startIndex..<snippetLength])
        self.date = .now
        self.formattedDate = DateFormatter.localizedString(from: date,
                                                           dateStyle: .medium,
                                                           timeStyle: .none)
        self.tags = tags
        self.link = Post.path(for: .html)
            .replacingOccurrences(of: ".", with: "")
            .appending("/")
            .appending(filename(for: .html))
    }
}

// MARK: - <ContextInitable>
extension Post: ContextInitable {
    // MARK: - ArgKeys
    private struct ArgKeys {
        static let title = "--title"
        static let author = "--author"
        static let content = "--content"
        static let callout = "--callout"
        static let tags = "--tags"
    }

    init(context: ArraySlice<String>) throws {
        let keyValuePairs = context.asCommandFlags()
        let title = keyValuePairs[ArgKeys.title, default: "title"]
        let author = keyValuePairs[ArgKeys.author, default: "Terry Latanville"]
        let content = keyValuePairs[ArgKeys.content, default: ""]
        let callout = keyValuePairs[ArgKeys.callout, default: ""]
        let tags = keyValuePairs[ArgKeys.tags, default: ""].components(separatedBy: ",")
        self.init(title: title, author: author, content: content, callout: callout, tags: tags)
    }
}

// MARK: - <Exportable>
extension Post: FormatExportable {
    static func path(for format: Format) -> String {
        switch format {
        case .json: return "./post-data"
        case .html: return "./posts"
        }
    }
}

// MARK: - <Titled>
extension Post: Titled {}

// MARK: - <SelfDocumenting>
extension Post: SelfDocumenting {
    static func emitDocumentation() {
        print("post: Creates a new post.json with default values.")
        print("  Available parameters:")
        print("  --title <title>")
        print("  --author <author>")
        print("  --content <content>")
        print("  --callout <callout>")
        print("  --tags <comma,delimited,tags>")
    }
}
