import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = "Common"

let project = Project(
    name: NAME_PROJECT,
    organizationName: "Vadim Martynenko",
    targets: [
        .frameworkTarget(name: NAME_PROJECT)
    ]
)
