//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib

@main struct BouncingBall: Applet {
	let BALL_RADIUS = 20
	
	var position: Vector2f
	var speed: Vector2f
	var paused = false
	var blink = Timeline()
	
	init() {
		Window.create(800, by: 450, title: "Example - Shapes - Bouncing Ball")
		Application.target(fps: 30)
		
		position = Window.size / 2
		speed = Vector2f(5, 4)
	}
	
	mutating func update() {
		if Keyboard.space.isPressed {
			paused.toggle()
		}
		
		guard !paused else {
			blink.update()
			return
		}
		
		position += speed
		
		if position.x.toInt >= Window.width - BALL_RADIUS || position.x.toInt <= BALL_RADIUS {
			speed.x.negate()
		}
		
		if position.y.toInt >= Window.height - BALL_RADIUS || position.y.toInt <= BALL_RADIUS {
			speed.y.negate()
		}
	}
	
	func draw() {
		Renderer2D.circle(at: position, radius: BALL_RADIUS.toFloat, color: .maroon)
		Renderer2D.text("PRESS SPACE to PAUSE BALL MOVEMENT", at: 10, Window.height - 25, color: .lightGray)
		
		if paused, blink.intervals(seconds: 0.5) {
			Renderer2D.text("PAUSED", at: 350, 200, size: 40, color: .gray)
		}
		
		Renderer2D.fps(at: 10, 10)
	}
	
}
