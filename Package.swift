// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSummarize",
    platforms: [.macOS(.v10_13)],
    products: [
        .library(
            name: "SwiftSummarize",
            targets: ["SwiftSummarize"]),
    ],
    targets: [
        .target(
            name: "SwiftSummarize",
            exclude: ["ExampleSwiftUI.swift"],
            resources: [.process("Documentation.docc")]
        ),
        .testTarget(
            name: "SwiftSummarizeTests",
            dependencies: ["SwiftSummarize"]),
    ]
)
