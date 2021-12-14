//
//  Site.swift
//  generation
//
//  Created by Terry Latanville on 2020-07-30.
//

import Foundation
import HTMLString
import Ink
import Splash
import Stencil

struct Site {
    // MARK: - Errors
    static let invalidPreferredFormat = NSError(domain: "com.generation.site.error", code: 0)

    // MARK: - Properties
    private static let jsonDecoder = JSONDecoder()
    private static let markdownParser: MarkdownParser = {
        let highlighter = SyntaxHighlighter(format: HTMLOutputFormat())
        var parser = MarkdownParser()
        let codeBlockModifier = Modifier(target: .codeBlocks) {
            let html = String($0.html)
            return highlighter.highlight(html)
        }
        parser.addModifier(codeBlockModifier)
        return parser
    }()

    // MARK: - Data Importing
    // TODO: (TL) This is very much brute force and inelegant - improve `Importable`
    private static func jsonDecodeAll<T: Exportable & Decodable>(_ type: T.Type) throws -> [T] {
        try type.dataFilenames()
            .compactMap { FileManager.default.contents(atPath: $0) }
            .compactMap { try jsonDecoder.decode(type, from: $0) }
    }

    private static func loadMarkdown<T: Importable>(_ type: T.Type) throws -> [T] {
        guard type.preferredRawFormat == .markdown else { throw Self.invalidPreferredFormat }
        return try type.dataFilenames()
            .compactMap {
                Intermediary(
                    filename: $0,
                    possibleData: FileManager.default.contents(atPath: $0)
                    )
            }
            .compactMap { intermediary in
                T(
                    filename: intermediary.filename,
                    content: markdownParser
                        .html(from: intermediary.content)
                        .removingHTMLEntities()
                )
            }
    }

    // MARK: - HTML Writing
    static func export() throws {
        // Data
        let articles = try loadMarkdown(Article.self)
        let projects = try jsonDecodeAll(Project.self)
        let apps = try jsonDecodeAll(App.self)

        // Render
        let context: [String: Any] = [
            "articles": articles,
            "projects": projects,
            "apps": apps
        ]
        let loader = FileSystemLoader(paths: ["stencil/"])
        let environment = Environment(loader: loader)
        let rendering = try environment.renderTemplate(name: "index.stencil", context: context)

        print(rendering)
        try rendering.write(toFile: "index.html", atomically: true, encoding: .utf8)        
    }
/*
    private static func configure(_ projects: [Project], in template: Template) {
        var projectGroups: [[Project]] = []
        for index in stride(from: 0, to: projects.count, by: 3) {
            var projectGroup = [projects[index]]
            if index + 1 < projects.count {
                projectGroup.append(projects[index + 1])
            }
            if index + 2 < projects.count {
                projectGroup.append(projects[index + 2])
            }
            projectGroups.append(projectGroup)
        }
        template.register(projectGroups, forKey: .projects)
    }
 */
}
