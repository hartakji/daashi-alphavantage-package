// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlphavantageWidget",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AlphavantageWidget",
            targets: ["AlphavantageWidget"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hartakji/daashi-widget-foundation", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "AlphavantageWidget",
            dependencies: [
                .product(
                    name: "WidgetFoundation",
                    package: "daashi-widget-foundation"
                )
            ],
            path: "Sources"
        )
    ]
)
