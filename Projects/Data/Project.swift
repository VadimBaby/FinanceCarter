import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = "Data"

let project = Project(
    name: NAME_PROJECT,
    organizationName: "Vadim Martynenko",
    targets: [
        .frameworkTarget(name: NAME_PROJECT, dependencies: [
            .project(target: "Common", path: "//Projects/Common"),
            .project(target: "Domain", path: "//Projects/Domain")
        ])
    ]
)

