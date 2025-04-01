import ProjectDescription

extension TargetScript {
    public static func swiftlint(
        path: Path = Constants.Scripts.swiftlint.path,
        basedOnDependencyAnalysis: Bool = false
    ) -> Self {
        .pre(
            path: path,
            arguments: [],
            name: Constants.Scripts.swiftlint.title,
            basedOnDependencyAnalysis: basedOnDependencyAnalysis
        )
    }
    
    public static func swiftgen(
        path: Path = Constants.Scripts.swiftgen.path,
        basedOnDependencyAnalysis: Bool = false
    ) -> Self {
        .pre(
            path: path,
            arguments: [],
            name: Constants.Scripts.swiftgen.title,
            basedOnDependencyAnalysis: basedOnDependencyAnalysis
        )
    }
}
