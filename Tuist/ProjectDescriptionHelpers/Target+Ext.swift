import ProjectDescription

extension Target {
    public static func dynamicFrameworkTarget(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        enabledSwiftGen: Bool = false
    ) -> Target {
        .myTarget(
            name: name,
            product: .framework,
            resources: resources,
            swiftGen: enabledSwiftGen ? .swiftgen() : nil,
            dependencies: dependencies
        )
    }
    
    public static func staticFrameworkTarget(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        enabledSwiftGen: Bool = false
    ) -> Target {
        .myTarget(
            name: name,
            product: .staticFramework,
            resources: resources,
            swiftGen: enabledSwiftGen ? .swiftgen() : nil,
            dependencies: dependencies
        )
    }
    
    public static func appTarget(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        enabledSwiftGen: Bool = false
    ) -> Target {
        .myTarget(
            name: name,
            product: .app,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard"
                ]
            ),
            resources: resources,
            swiftGen: enabledSwiftGen ? .swiftgen() : nil,
            dependencies: dependencies
        )
    }
}
