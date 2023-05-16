//
//  File.swift
//  File
//
//  Created by Christophe Bronner on 2021-09-02.
//

import Raylib

@main struct InputMouse: Applet {
	var position = Vector2f(-100)
	var color = Color.darkBlue
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - Input Mouse")
		Application.target(fps: 60)
	}
	
	mutating func update() {
		position = Mouse.position
		
		switch true {
		case Mouse.left.isPressed: color = .maroon
		case Mouse.middle.isPressed: color = .lime
		case Mouse.right.isPressed: color = .darkBlue
		case Mouse.side.isPressed: color = .purple
		case Mouse.extra.isPressed: color = .yellow
		case Mouse.forward.isPressed: color = .orange
		case Mouse.backward.isPressed: color = .beige
		default: break
		}
	}
	
	func draw() {
		Renderer2D.text("Move ball with mouse and use mouse buttons to change color", at: 10, 10, color: .darkGray)
		Renderer2D.circle(at: position, radius: 40, color: color)
	}
}
