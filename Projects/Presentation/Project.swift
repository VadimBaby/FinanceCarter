import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = "Presentation"

let project = Project(
    name: NAME_PROJECT,
    organizationName: "Vadim Martynenko",
    packages: [
        .remote(url: "https://github.com/AliSoftware/Reusable.git", requirement: .upToNextMajor(from: "4.1.2")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.7.1"))
    ],
    targets: [
        .frameworkTarget(
            name: NAME_PROJECT,
            dependencies: [
                .project(target: "Common", path: "//Projects/Common"),
                .project(target: "Domain", path: "//Projects/Domain"),
                .package(product: "Reusable"),
                .package(product: "SnapKit")
            ],
            isUseResources: true)
    ]
)

