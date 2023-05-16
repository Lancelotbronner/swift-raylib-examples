//
//  File.swift
//  File
//
//  Created by Christophe Bronner on 2021-09-04.
//

import Raylib

//MARK: - Application

@main struct ExampleCamera2D: Applet {
	let NUMBER_OF_BUILDINGS = 100

	var player: Rectangle
	var camera: Camera2D
	var buildings: [Building]

	init() {
		Window.create(800, by: 450, title: "Example - Core - 2D Camera")
		Renderer.background = .darkGray
		Application.target(fps: 60)

		player = Rectangle(at: 400, 280, size: 40, 40)
		camera = Camera2D(at: player.position + 20)

		var offset: Float = 0
		buildings = (0 ..< NUMBER_OF_BUILDINGS).map { _ in
			let building = Building.random(offset: offset)
			offset += building.rect.width
			return building
		}
	}

	mutating func update() {
		if Keyboard.right.isDown {
			player.x += 2
		} else if Keyboard.left.isDown {
			player.x -= 2
		}

		camera.target = player.position + 20

		if Keyboard.a.isDown {
			camera.rotation -= 1
		} else if Keyboard.s.isDown {
			camera.rotation += 1
		}

		camera.rotation.clamp(between: -40, and: 40)

		camera.zoom += Mouse.wheel * 0.05
		camera.zoom.clamp(between: 0.1, and: 3)

		if Keyboard.r.isPressed {
			camera.zoom = 1
			camera.rotation = 0
		}
	}

	func draw() {
		Renderer.camera(camera) {
			for building in buildings {
				building.draw()
			}

			Renderer2D.rectangle(player, color: .red)

			let window = Window.size * 10
			
			Renderer2D.line(
				from: camera.target.x, -window.y,
				to: camera.target.x, window.y,
				color: .green)

			Renderer2D.line(
				from: -window.x, camera.target.y,
				to: window.x, camera.target.y,
				color: .green)
		}

		Renderer2D.text("SCREEN AREA", at: 640, 10, color: .red)
		
		Renderer.color = .red
		Renderer2D.rectangle(at: 0, 0, size: Window.width, 5)
		Renderer2D.rectangle(at: 0, 5, size: 5, Window.height - 10)
		Renderer2D.rectangle(at: Window.width - 5, 5, size: 5, Window.height - 10)
		Renderer2D.rectangle(at: 0, Window.height - 5, size: Window.width, 5)
		
		Renderer2D.rectangle(at: 10, 10, size: 250, 113, color: .skyBlue.faded(to: 0.5))
		WireRenderer2D.rectangle(at: 10, 10, size: 250, 113, color: .blue)
		
		Renderer.textColor = .darkGray
		Renderer.pointSize = 10
		Renderer2D.text("Free 2D camera controls:", at: 20, 20, color: .black)
		Renderer2D.text("- Right/Left to move Offset", at: 40, 40);
		Renderer2D.text("- Mouse Wheel to Zoom in-out", at: 40, 60);
		Renderer2D.text("- A / S to Rotate", at: 40, 80);
		Renderer2D.text("- R to reset Zoom and Rotation", at: 40, 100);
	}
}

//MARK: - Game

struct Building {
	var rect: Rectangle
	var color: Color

	static func random(offset: Float) -> Building {
		let size = Vector2f(.random(in: 50 ... 200), .random(in: 100 ... 800))
		let position = Vector2f(-6000 + offset, Window.height.toFloat - 130 - size.y)
		let color = Color.rgb(.random(in: 200 ... 240), .random(in: 200 ... 240), .random(in: 200 ... 250))
		return Building(rect: Rectangle(at: position, size: size), color: color)
	}

	func draw() {
		Renderer2D.rectangle(rect, color: color)
	}
}
