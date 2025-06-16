// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "skip-lib",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipLib", targets: ["SkipLib"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.0"),
        .package(url: "https://source.skip.tools/skip-unit.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "SkipLib", dependencies: [.product(name: "SkipUnit", package: "skip-unit")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SkipLibTests", dependencies: ["SkipLib", .product(name: "SkipTest", package: "skip")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)

if Context.environment["SKIP_BRIDGE"] ?? "0" != "0" {
    // all library types must be dynamic to support bridging
    package.products = package.products.map({ product in
        guard let libraryProduct = product as? Product.Library else { return product }
        return .library(name: libraryProduct.name, type: .dynamic, targets: libraryProduct.targets)
    })
}
