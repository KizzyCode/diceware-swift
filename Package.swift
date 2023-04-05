// swift-tools-version:5.7

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
            from: "1.2.2")
    ],
    targets: [
        .target(
            name: "Diceware",
            dependencies: []),
        .executableTarget(
            name: "diceware_bin",
            dependencies: [
                .byName(name: "Diceware"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "DicewareTests",
            dependencies: [
                .byName(name: "Diceware")])
    ]
)
