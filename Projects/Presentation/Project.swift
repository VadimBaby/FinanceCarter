import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.Presentation.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        .remote(url: "https://github.com/AliSoftware/Reusable.git", requirement: .upToNextMajor(from: "4.1.2")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.7.1"))
    ],
    targets: [
        .frameworkTarget(
            name: NAME_PROJECT,
            dependencies: [
                Constants.Modules.Common.dependency,
                Constants.Modules.Domain.dependency,
                .package(product: "Reusable"),
                .package(product: "SnapKit")
            ],
            resources: Constants.DEFAULT_LOCATE_RESOURCES,
            enabledSwiftGen: true
        )
    ]
)

