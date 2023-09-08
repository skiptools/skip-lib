// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "skip-lib",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipLib", targets: ["SkipLib"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.57"),
        .package(url: "https://source.skip.tools/skip-unit.git", from: "0.2.19"),
    ],
    targets: [
        .target(name: "SkipLib", dependencies: [.product(name: "SkipUnit", package: "skip-unit", condition: .when(platforms: [.macOS]))], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SkipLibTests", dependencies: ["SkipLib", .product(name: "SkipTest", package: "skip", condition: .when(platforms: [.macOS]))], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
