import Foundation
import ArgumentParser

// MARK: - Main
struct Generation: ParsableCommand {
    enum Errors: Error {
        case invalidArgument
    }
    public static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage static site generation",
        subcommands: [
            SiteCommand.self,
            TemplateCommand.self
        ]
    )
    init() {}
}

Generation.main()

// MARK: - Subcommands
struct SiteCommand: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "site",
        abstract: "Generates a static website based on JSON data and Leaf files"
    )
    func run() throws {
        try Site.export()
    }
}

struct TemplateCommand: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "template",
        abstract: "Generates a new sample of the specified type"
    )
    @Argument(help: "The type of template to generate, options available: 'article', 'project'")
    var type: String

    func run() throws {
        let exportable: Exportable
        switch type {
        case "article":
            exportable = Article.template
        case "project":
            exportable = Project.template
        case "app":
            exportable = App.template
        default:
            throw Generation.Errors.invalidArgument
        }
        try exportable.export()
    }
}
