import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.Data.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    targets: [
        .frameworkTarget(name: NAME_PROJECT, dependencies: [
            Constants.Modules.Common.dependency,
            Constants.Modules.Domain.dependency
        ])
    ]
)

