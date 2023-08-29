// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//MARK: - Package

let package = Package(
	name: "Swift Raylib Examples",
	platforms: [
		.macOS(.v12),
	],
	dependencies: [
		// Wrappers
		.package(name: "RaylibKit", path: "../swift-raylib"),
	],
	targets: [
		
		// Core Module
		.example(.core, "Basic Window"),
		.example(.core, "Input Keys"),
		.example(.core, "Input Mouse"),
		.example(.core, "Input Mouse Wheel"),
		.example(.core, "2D Camera"),
		.example(.core, "2D Camera Mouse Zoom"),
		.example(.core, "2D Camera Platformer"),
		.example(.core, "Letterboxed Window"),
		.example(.core, "Drop Files"),
		.example(.core, "Scissor Test"),
//		.example(.core, "3D First Person"),
		
		// Shapes Module
		.example(.shapes, "Basic Shapes"),
		.example(.shapes, "Bouncing Ball"),
		.example(.shapes, "Color Palette"),
		.example(.shapes, "Following Eyes"),
		
		// Textures Module
		.example(.textures, "Atlas", [
			.copy("scarfy.png"),
		]),
		.example(.textures, "Blend Modes", [
			.copy("background.png"),
			.copy("foreground.png"),
		]),
		.example(.textures, "Image Generation"),
		.example(.textures, "Logo Raylib", [
			.copy("logo.png"),
		]),
		.example(.textures, "Sprite Animation", [
			.copy("scarfy.png"),
		]),

		// Audio Module
		.example(.audio, "Module Playing", [
			.copy("mini1111.xm"),
		]),

		// Classic Games
		.classic("Arkanoid"),
//		.classic("Platformer"),
		.classic("Snake"),
		
		// Games
//		.game("HexTrader", resources: true, assets: true),
//		.game("RPG Example", resources: true),
	]
)

//MARK: - Templates

extension Target {
	static func example(_ module: RaylibModule, _ name: String, _ resources: [Resource]? = nil, _ exclude: [String] = []) -> Target {
		var exclude = exclude
		exclude.append("LICENSE.md")
		let target = Target.executableTarget(
			name: "\(module.rawValue) - \(name)",
			dependencies: [
				.product(name: "RaylibKit", package: "RaylibKit"),
			],
			path: "Sources/\(module.rawValue)/\(name)",
			exclude: exclude,
			resources: resources)
		return target
	}
	
	static func classic(_ name: String, _ resources: [Resource]? = nil) -> Target {
		let target = Target.executableTarget(
			name: "Classic Game - \(name)",
			dependencies: [
				.product(name: "RaylibKit", package: "RaylibKit"),
			],
			path: "Sources/Classics/\(name)",
			resources: resources)
		return target
	}
	
	static func game(_ name: String, resources: Bool = false, assets: Bool = false) -> Target {
		let target = Target.executableTarget(
			name: "Game - \(name)",
			dependencies: [
				.product(name: "RaylibKit", package: "RaylibKit"),
			],
			path: "Sources/Games/\(name)",
			resources: [])
		if resources {
			target.resources?.append(.copy("Resources/"))
		}
		if assets {
			target.exclude.append("Assets")
		}
		return target
	}
}

//MARK: - Utilites

enum RaylibModule: String {
	case core = "Core"
	case shapes = "Shapes"
	case textures = "Textures"
	case audio = "Audio"
}
