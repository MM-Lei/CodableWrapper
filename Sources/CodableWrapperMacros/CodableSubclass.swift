import SwiftSyntax
import SwiftSyntaxMacros

public struct CodableSubclass: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
                                 conformingTo _: [SwiftSyntax.TypeSyntax],
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax]
    {
        guard declaration.is(ClassDeclSyntax.self) else {
            throw ASTError("@CodableSubclass can only be applied to class declarations.")
        }

        let propertyContainer = try ModelMemberPropertyContainer(decl: declaration, context: context)
        let decoder = try propertyContainer.genDecoderInitializer(config: .init(isOverride: true))
        let encoder = try propertyContainer.genEncodeFunction(config: .init(isOverride: true))
        return [decoder, encoder]
    }
}
