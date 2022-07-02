// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TelegramBotSDK",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "CCurl",
            targets: ["CCurl"]),
        .library(
            name: "TelegramBotSDK",
            targets: ["TelegramBotSDK"]),
    ],
    targets: [
        .target(
            name: "CCurl",
            dependencies: []),
        .target(
            name: "TelegramBotSDK",
            dependencies: ["CCurl"]),
        .testTarget(
            name: "TelegramBotSDKTests",
            dependencies: ["TelegramBotSDK"]
        )
    ]
)
