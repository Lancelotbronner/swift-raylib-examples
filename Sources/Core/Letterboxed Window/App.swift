//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-11-30.
//

import Raylib

@main struct LetterboxedWindow: Applet {
	
	var target: RenderTexture
	var virtualMouse = Vector2f.zero
	var transformation = Vector2f.zero
	let game = Vector2f(640, 480)
	var scale: Float = 1
	var colors: [Color]
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - Letterboxed Window")
		Window.enable(.resizable, .vsync)
		Window.resize(minimum: 320, by: 240)
		Renderer.background = .black
		Application.target(fps: 60)
		
		target = RenderTexture(size: game)
		target.texture.filter(using: .bilinear)
		
		colors = [Color](repeat: 10, value: .random)
	}
	
	mutating func update() {
		let scaled = Window.size / game
		scale = min(scaled.x, scaled.y)
		
		if Keyboard.space.isPressed {
			for i in colors.indices {
				colors[i] = .random
			}
		}
		
		transformation = -(Window.size - game * scale) / 2
		virtualMouse = (Mouse.position + transformation) / scale
		virtualMouse.clamp(between: .zero, and: game)
		
		Mouse.offset(by: transformation)
		Mouse.scale(by: .one / scale)
	}
	
	func render() {
		Renderer.target(target) {
			Renderer.clear(to: .raywhite)
			
			for (i, color) in colors.enumerated() {
				Renderer2D.rectangle(at: 0, (game.y / 10).toInt * i, size: game.x.toInt, (game.y / 10).toInt, color: color)
			}

			Renderer2D.text("If executed inside a window,\nyou can resize the window,\nand see the screen scaling!", at: 10, 25, color: .white)
			Renderer2D.text("Default Mouse: [\(Mouse.x), \(Mouse.y)]", at: 350, 25, color: .green)
			Renderer2D.text("Virtual Mouse: [\(virtualMouse.x.toInt), \(virtualMouse.y.toInt)]", at: 350, 55, color: .yellow)
		}
	}
	
	func draw() {
		Renderer2D.target(target, to: Rectangle(at: -transformation, size: game * scale))
	}
	
}
