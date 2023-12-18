// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-openapi-foundation",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "swift-openapi-foundation",
            targets: ["swift-openapi-foundation"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "swift-openapi-foundation"),
        .testTarget(
            name: "swift-openapi-foundationTests",
            dependencies: ["swift-openapi-foundation"]),
    ]
)
