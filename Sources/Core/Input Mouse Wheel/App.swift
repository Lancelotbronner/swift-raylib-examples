//
//  File.swift
//  File
//
//  Created by Christophe Bronner on 2021-09-02.
//

import Raylib

@main struct InputMouseWheel: Applet {
	var y: Float
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - Input Mouse Wheel")
		Application.target(fps: 60)
		
		y = Window.size.y / 2 - 40
	}
	
	mutating func update() {
		y -= Mouse.wheel * 4
	}
	
	func draw() {
		Renderer2D.rectangle(at: Window.width / 2 - 40, y.toInt, size: 80, 80, color: .maroon)
		
		Renderer2D.text("Use mouse wheel to move the cube up and down!", at: 10, 10, color: .gray)
		Renderer2D.text("Box position Y: \(y, decimals: 0, digits: 3)", at: 10, 40, color: .lightGray);
	}
}
