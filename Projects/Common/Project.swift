import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.Common.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    targets: [
        .createTarget(type: .dynamicFramework, name: NAME_PROJECT)
    ]
)
