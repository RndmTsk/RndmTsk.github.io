import Foundation

// variables
// header
// index-body
// number
// tags
// link
// title
// date
// dropdown-list
// author

// MARK: - Typealiases
typealias InvokableWithContext = (ArraySlice<String>) throws -> Void

// MARK: - Extensions
fileprivate extension String {
    var exportableType: (ContextInitable & FormatExportable).Type? {
        if self == "post" {
            return Post.self
        } else if self == "project" {
            return Project.self
        }
        return nil
    }
}

// MARK: - Documentable Types
let documentableCommands: [SelfDocumenting.Type] = [
    Post.self,
    Project.self,
    Website.self
]

// MARK: - Functions
func printUsage(_ exitStatus: Int32) -> Never {
    print("Usage:")
    print("    generator <command> [arguments]")
    print("")
    print("Available Commands:")
    documentableCommands.forEach { $0.emitDocumentation() }
    exit(exitStatus)
}

func performAction(for command: String, with context: ArraySlice<String>) throws {
    if let exportableType = command.exportableType {
        try exportableType.init(context: context).export(as: .json)
    } else if command == "website" {
        try Website().export()
    } else {
        printUsage(2)
    }
}

// MARK: - Main
guard CommandLine.arguments.count > 1 else { printUsage(1) }
let command = CommandLine.arguments[1]
let context = CommandLine.arguments.count > 2 ? CommandLine.arguments[2...] : []
do {
    try performAction(for: command, with: context)
} catch {
    print("Error: \(error)")
}
