import ProjectDescription

public enum TypeTarget {
    case app, dynamicFramework, staticFramework
    
    var product: Product {
        switch self {
        case .app: return .app
        case .dynamicFramework: return .framework
        case .staticFramework: return .staticFramework
        }
    }
    
    var infoPlist: InfoPlist {
        guard self == .app else { return .default }
        
        return .extendingDefault(
            with: [
                "UILaunchStoryboardName": "LaunchScreen.storyboard"
            ]
        )
    }
}

extension Target {
    public static func createTarget(
        type: TypeTarget,
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        enabledSwiftGen: Bool = false,
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        return .myTarget(
            name: name,
            product: type.product,
            infoPlist: type.infoPlist,
            resources: resources,
            swiftGen: enabledSwiftGen ? .swiftgen() : nil,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }
}
