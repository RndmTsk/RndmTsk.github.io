//
//  Website.swift
//  generator
//
//  Created by Terry Latanville on 2019-02-18.
//

import Foundation
import Stencil

struct Website: Codable {
    // MARK: - Properties
    let posts: [String]
    let projects: [String]
    let staticPages: [Template]
    private static var jsonDecoder = JSONDecoder()

    // MARK: - Lifecycle Functions
    init(staticPages: [Template] = [.index, .about]) throws {
        self.posts = try Post.dataFilenames()
        self.projects = try Project.dataFilenames()
        self.staticPages = staticPages
    }

    // MARK: - Functions
    func export() throws {
        // 1. Fetch post and project data
        let postData = try loadContents(of: posts, as: Post.self).sorted { $0.date.timeIntervalSinceReferenceDate > $1.date.timeIntervalSinceReferenceDate }
        let projectData = try loadContents(of: projects, as: Project.self)
        let loader = FileSystemLoader(paths: ["./templates"])
        let environment = Environment(loader: loader)
        var context: [String: Any] = [
            "posts": postData,
            "projects": projectData
        ]
        try staticPages.forEach { try render(template: $0, to: $0.rawValue + Format.html.suffix, with: environment, and: context) }
        try postData.forEach {
            context["post"] = $0
            let file = Post.path(for: .html) + "/" + $0.filename(for: .html)
            try render(template: .post, to: file, with: environment, and: context)
        }
        try projectData.forEach {
            context["project"] = $0
            let file = Project.path(for: .html) + "/" + $0.filename(for: .html)
            try render(template: .project, to: file, with: environment, and: context)
        }
    }

    // MARK: - Helper Functions
    private func loadContents<T: Codable>(of paths: [String], as type: T.Type) throws -> [T] {
        return try paths
            .compactMap { FileManager.default.contents(atPath: $0) }
            .compactMap { try Website.jsonDecoder.decode(type, from: $0) }
    }

    private func render(template: Template, to file: String, with environment: Environment, and context: [String: Any]) throws {
        let rendered = try environment.renderTemplate(name: template.rawValue + ".template", context: context)
        try rendered.write(toFile: file, atomically: true, encoding: .utf8)
    }
}

// MARK: - <SelfDocumenting>
extension Website: SelfDocumenting {
    static func emitDocumentation() {
        print("website: Auto-generates an index.html, posts, and projects based on the \"post-data\" and \"project-data\" directories respectively.")
    }
}
