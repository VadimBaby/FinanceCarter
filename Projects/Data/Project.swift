import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.Data.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        Constants.Packages.MyCommon.package
    ],
    targets: [
        .createTarget(
            type: .dynamicFramework,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Packages.MyCommon.dependency,
                Constants.Modules.Domain.dependency
            ]
        )
    ]
)

