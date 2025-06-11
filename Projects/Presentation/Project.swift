import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.Presentation.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        Constants.Packages.Reusable.package,
        Constants.Packages.SnapKit.package,
        Constants.Packages.ElegantEmojiPicker.package,
        Constants.Packages.MyCommon.package
    ],
    targets: [
        .createTarget(
            type: .dynamicFramework,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Modules.Domain.dependency,
                Constants.Packages.Reusable.dependency,
                Constants.Packages.SnapKit.dependency,
                Constants.Packages.ElegantEmojiPicker.dependency,
                Constants.Packages.MyCommon.dependency
            ],
            resources: Constants.DEFAULT_LOCATE_RESOURCES,
            enabledSwiftGen: true
        )
    ]
)

