import ProjectDescription
import Foundation

public enum Constants {
    public static let BUNDLE_ID = "com.martynenko.vadim."
    public static let ORGANIZATION_NAME = "Vadim Martynenko"
    public static let MIN_TARGET_IOS = "15.0"
    public static let DEFAULT_LOCATE_SOURCE: SourceFilesList = ["Sources/**"]
    public static let DEFAULT_LOCATE_RESOURCES: ResourceFileElements = ["Sources/Resources/**"]
    
    public enum Modules: String, CaseIterable {
        case CoreDataInfastructure, Domain, Data, Presentation, FinanceCarter
        
        public var title: String { rawValue }
        
        public var dependency: TargetDependency {
            .project(target: self.title, path: "//Projects/\(self.title)")
        }
        
        public static func allPaths() -> [Path] {
            allCases.map { "Projects/\($0.title)" }
        }
    }
    
    public enum Scripts: String {
        case swiftlint, swiftgen
        
        public var title: String {
            switch self {
            case .swiftlint: "SwiftLint"
            case .swiftgen: "SwiftGen"
            }
        }
        
        public var path: Path {
            "../../Scripts/\(self.rawValue).sh"
        }
    }
    
    public enum Packages {
        case MyCommon, Reusable, SnapKit, ElegantEmojiPicker, Swinject, MyCoreDataWrapper
        
        public var package: Package {
            switch self {
            case .Reusable:
                .remote(url: "https://github.com/AliSoftware/Reusable.git", requirement: .upToNextMajor(from: "4.1.2"))
            case .SnapKit:
                .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.7.1"))
            case .ElegantEmojiPicker:
                .remote(url: "https://github.com/Finalet/Elegant-Emoji-Picker.git", requirement: .branch("main"))
            case .MyCommon:
                .remote(url: "https://github.com/VadimBaby/MyCommon.git", requirement: .branch("master"))
            case .Swinject:
                .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
            case .MyCoreDataWrapper:
                .remote(url: "https://github.com/VadimBaby/MyCoreDataWrapped.git", requirement: .upToNextMajor(from: "1.0.1"))
            }
        }
        
        public var dependency: TargetDependency {
            switch self {
            case .MyCommon: .package(product: "MyCommon")
            case .Reusable: .package(product: "Reusable")
            case .SnapKit: .package(product: "SnapKit")
            case .ElegantEmojiPicker: .package(product: "ElegantEmojiPicker")
            case .Swinject: .package(product: "Swinject")
            case .MyCoreDataWrapper: .package(product: "MyCoreDataWrapper")
            }
        }
    }
}
