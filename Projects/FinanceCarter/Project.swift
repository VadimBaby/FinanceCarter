import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = "FinanceCarter"

let project = Project(
    name: NAME_PROJECT,
    organizationName: "Vadim Martynenko",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
    targets: [
        .appTarget(
            name: NAME_PROJECT,
            dependencies: [
                .project(target: "Common", path: "//Projects/Common"),
                .project(target: "Domain", path: "//Projects/Domain"),
                .project(target: "Data", path: "//Projects/Data"),
                .project(target: "Presentation", path: "//Projects/Presentation"),
                .package(product: "Swinject")
            ],
            isUseResources: true
        )
    ]
)
