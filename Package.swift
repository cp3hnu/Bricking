// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bricking",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v9)
    ],
    products: [
        .library(name: "Bricking", targets: ["Bricking"])
    ],
    targets: [
        .target(name: "Bricking", path: "Bricking/Source")
    ],
    swiftLanguageVersions: [.v5]
)
