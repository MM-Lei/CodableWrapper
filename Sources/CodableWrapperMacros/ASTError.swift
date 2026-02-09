import Foundation

struct ASTError: CustomStringConvertible, Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var description: String {
        "AST parsing error: \(message)"
    }
}
