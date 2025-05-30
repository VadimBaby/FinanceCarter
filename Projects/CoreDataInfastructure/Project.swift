import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.CoreDataInfastructure.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    targets: [
        .createTarget(
            type: .dynamicFramework,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Modules.Common.dependency,
                Constants.Modules.Domain.dependency,
                Constants.Modules.Data.dependency
            ],
            coreDataModels: [.coreDataModel(.path("Sources/Store/Model.xcdatamodeld"))]
        )
    ]
)
