// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AgentPet",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "AgentPet", targets: ["AgentPet"])
    ],
    dependencies: [
        .package(url: "https://github.com/httpswift/swifter.git", from: "1.5.0")
    ],
    targets: [
        .executableTarget(
            name: "AgentPet",
            dependencies: [
                .product(name: "Swifter", package: "swifter")
            ]
        )
    ]
)
