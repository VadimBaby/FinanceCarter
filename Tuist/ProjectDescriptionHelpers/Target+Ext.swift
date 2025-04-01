import ProjectDescription

extension Target {
    public static func frameworkTarget(name: String, dependencies: [TargetDependency] = [], isUseResources: Bool = false) -> Target {
        var scripts: [TargetScript] = [
            .pre(path: "../../Scripts/swiftlint.sh", arguments: [], name: "SwiftLint", basedOnDependencyAnalysis: false)
        ]
        
        if isUseResources {
            scripts.append(.pre(path: "../../Scripts/swiftgen.sh", arguments: [], name: "SwiftGen"))
        }
        
        return .target(
            name: name,
            destinations: .iOS,
            product: .framework,
            productName: name,
            bundleId: "com.martynenko.vadim.\(name)",
            deploymentTargets: .iOS("15.0"),
            sources: ["Sources/**"],
            resources: isUseResources ? ["Sources/Resources/**"] : nil,
            scripts: scripts,
            dependencies: dependencies
        )
    }
    
    public static func appTarget(name: String, dependencies: [TargetDependency] = [], isUseResources: Bool = false) -> Target {
        .target(
            name: name,
            destinations: .iOS,
            product: .app,
            productName: name,
            bundleId: "com.martynenko.vadim.\(name)",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard"
                ]
            ),
            sources: ["Sources/**"],
            resources: isUseResources ? ["Sources/Resources/**"] : nil,
            scripts: [
                .pre(path: "../../Scripts/swiftlint.sh", arguments: [], name: "SwiftLint", basedOnDependencyAnalysis: false)
            ],
            dependencies: dependencies
        )
    }
}
