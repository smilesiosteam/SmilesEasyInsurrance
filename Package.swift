// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmilesEasyInsurrance",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SmilesEasyInsurrance",
            targets: ["SmilesEasyInsurrance"]),
    ],
    dependencies: [
        
        .package(url: "https://github.com/smilesiosteam/SmilesUtilities.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesFontsManager.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesBaseMainRequest.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/NetworkingLayer.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/LottieAnimationManager.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesLoader.git", branch: "main"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/smilesiosteam/SmilesSharedServices.git", branch: "main"),
    ],
    targets: [
        
        .target(
            name: "SmilesEasyInsurrance",
            dependencies: [
                .product(name: "SmilesUtilities", package: "SmilesUtilities"),
                .product(name: "SmilesFontsManager", package: "SmilesFontsManager"),
                .product(name: "SmilesBaseMainRequestManager", package: "SmilesBaseMainRequest"),
                .product(name: "NetworkingLayer", package: "NetworkingLayer"),
                .product(name: "LottieAnimationManager", package: "LottieAnimationManager"),
                .product(name: "SmilesLoader", package: "SmilesLoader"),
                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "SmilesSharedServices", package: "SmilesSharedServices")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SmilesEasyInsurranceTests",
            dependencies: ["SmilesEasyInsurrance"]
        ),
    ]
)
