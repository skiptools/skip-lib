// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "skip-lib",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipLib", targets: ["SkipLib"]),
        .library(name: "SkipLibKt", targets: ["SkipLibKt"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.28"),
        .package(url: "https://source.skip.tools/skip-unit.git", from: "0.2.4"),
    ],
    targets: [
        .target(name: "SkipLib", plugins: [.plugin(name: "skippy", package: "skip")]),
        .target(name: "SkipLibKt", dependencies: ["SkipLib", .product(name: "SkipUnitKt", package: "skip-unit")], resources: [.process("Skip")], plugins: [.plugin(name: "transpile", package: "skip")]),
        .testTarget(name: "SkipLibTests", dependencies: ["SkipLib"], plugins: [.plugin(name: "skippy", package: "skip")]),
        .testTarget(name: "SkipLibKtTests", dependencies: ["SkipLibKt", .product(name: "SkipUnit", package: "skip-unit")], resources: [.process("Skip")], plugins: [.plugin(name: "transpile", package: "skip")]),
    ]
)
