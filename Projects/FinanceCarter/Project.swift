import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.FinanceCarter.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
    targets: [
        .createTarget(
            type: .app,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Modules.Common.dependency,
                Constants.Modules.Domain.dependency,
                Constants.Modules.Data.dependency,
                Constants.Modules.Presentation.dependency,
                .package(product: "Swinject")
            ],
            resources: Constants.DEFAULT_LOCATE_RESOURCES
        )
    ]
)
