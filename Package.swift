// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Diceware",
    products: [
        .library(
            name: "Diceware",
            targets: ["Diceware"]),
        .executable(
            name: "diceware",
            targets: ["diceware_bin"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "0.3.0")
    ],
    targets: [
        .target(
            name: "Diceware",
            dependencies: []),
        .target(
            name: "diceware_bin",
            dependencies: ["Diceware", "ArgumentParser"]),
        .testTarget(
            name: "DicewareTests",
            dependencies: ["Diceware"])
    ]
)
