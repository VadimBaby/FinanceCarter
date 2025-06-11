import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.CoreDataInfastructure.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        Constants.Packages.MyCommon.package,
        Constants.Packages.MyCoreDataWrapper.package
    ],
    targets: [
        .createTarget(
            type: .dynamicFramework,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Packages.MyCommon.dependency,
                Constants.Modules.Domain.dependency,
                Constants.Modules.Data.dependency,
                Constants.Packages.MyCoreDataWrapper.dependency
            ],
            coreDataModels: [.coreDataModel(.path("Sources/Store/Model.xcdatamodeld"))]
        )
    ]
)
