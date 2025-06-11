import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.FinanceCarter.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        Constants.Packages.MyCommon.package,
        Constants.Packages.Swinject.package
    ],
    targets: [
        .createTarget(
            type: .app,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Packages.MyCommon.dependency,
                Constants.Modules.Domain.dependency,
                Constants.Modules.Data.dependency,
                Constants.Modules.Presentation.dependency,
                Constants.Modules.CoreDataInfastructure.dependency,
                Constants.Packages.Swinject.dependency
            ],
            resources: Constants.DEFAULT_LOCATE_RESOURCES
        )
    ]
)
