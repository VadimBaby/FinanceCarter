import ProjectDescription

extension Target {
    public static func myTarget(
        name: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        source: SourceFilesList? = Constants.DEFAULT_LOCATE_SOURCE,
        resources: ResourceFileElements? = nil,
        swiftLint: TargetScript? = .swiftlint(),
        swiftGen: TargetScript? = nil,
        otherScripts: [TargetScript] = [],
        dependencies: [TargetDependency] = []
    ) -> Self {
        var scripts = otherScripts
        
        if let swiftGen {
            scripts.append(swiftGen)
        }
        
        if let swiftLint {
            scripts.append(swiftLint)
        }
        
        return .target(
            name: name,
            destinations: .iOS,
            product: product,
            productName: name,
            bundleId: Constants.BUNDLE_ID + name,
            deploymentTargets: .iOS(Constants.MIN_TARGET_IOS),
            infoPlist: infoPlist,
            sources: source,
            resources: resources,
            scripts: scripts,
            dependencies: dependencies
        )
    }
}
