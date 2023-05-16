//
//  File.swift
//  File
//
//  Created by Christophe Bronner on 2021-09-01.
//

import Raylib

@main struct InputKeyboard: Applet {
	var position: Vector2f
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - Input Keys")
		Application.target(fps: 60)
		
		position = Window.size / 2
	}
	
	mutating func update() {
		if Keyboard.right.isDown {
			position.x += 2
		}
		if Keyboard.left.isDown {
			position.x -= 2
		}
		if Keyboard.up.isDown {
			position.y -= 2
		}
		if Keyboard.down.isDown {
			position.y += 2
		}
	}
	
	func draw() {
		Renderer2D.text("Move the ball with the arrow keys", at: 10, 10, color: .darkGray)
		Renderer2D.circle(at: position, radius: 50, color: .maroon)
	}
}
