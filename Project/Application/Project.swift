import ProjectDescription
import ProjectDescriptionHelpers

let targetList: [Target] = [
  .target(
    name: "GroupChat",
    destinations: .iOS,
    product: .app,
    productName: "GroupChat",
    bundleId: "io.seungchan.groupChat",
    deploymentTargets: .iOS("18.0"),
    infoPlist: .extendingDefault(with: .compositeValue),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    copyFiles: .none,
    headers: .none,
    entitlements: .none,
    scripts: [],
    dependencies: .compositeValue,
    settings: .defaultSettings,
    coreDataModels: [],
    environmentVariables: [:],
    launchArguments: [],
    additionalFiles: [],
    buildRules: [],
    mergedBinaryType: .automatic,
    mergeable: false,
    onDemandResourcesTags: .none),
]
let project = Project(
  name: "GroupChat",
  organizationName: "SeungChanMoon",
  classPrefix: .none,
  options: .options(
    automaticSchemesOptions: .enabled(),
    defaultKnownRegions: .none,
    developmentRegion: .none,
    disableBundleAccessors: false,
    disableShowEnvironmentVarsInScriptPhases: false,
    disableSynthesizedResourceAccessors: false,
    textSettings: .textSettings(),
    xcodeProjectName: .none),
  packages: .compositeValue,
  settings: .none,
  targets: targetList,
  schemes: [],
  fileHeaderTemplate: .none,
  additionalFiles: [],
  resourceSynthesizers: .default)
extension [String: Plist.Value] {
  static var compositeValue: [String: Plist.Value] {
    [
      "CFBundleShortVersionString": .string(.appVersion()),
      "CFBundleIdentifier": .string("$(PRODUCT_BUNDLE_IDENTIFIER)"),
      "CFBundleName": .string("${PRODUCT_NAME}"),
      "CFBundleInfoDictionaryVersion": "6.0",
      "CFBundleVersion": .string(.appBuildVersion()),
      "UILaunchScreen": .dictionary([:]),
    ]
  }
}

extension [TargetDependency] {
  static var compositeValue: [TargetDependency] {
    [
      .package(product: "Architecture", type: .runtime, condition: .none),
      .package(product: "Domain", type: .runtime, condition: .none),
      .package(product: "Platform", type: .runtime, condition: .none),
    ]
  }
}

extension [Package] {
  static var compositeValue: [Package] {
    [
      .local(path: .relativeToRoot("Modules/Core/Architecture")),
      .local(path: .relativeToRoot("Modules/Core/Platform")),
      .local(path: .relativeToRoot("Modules/Core/Domain")),
    ]
  }
}
