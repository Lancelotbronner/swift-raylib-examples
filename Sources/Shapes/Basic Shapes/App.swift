//
//  File.swift
//  File
//
//  Created by Christophe Bronner on 2021-09-06.
//

import Raylib

@main struct BasicShapes: Applet {
	var rotation: Float = 0.0

	init() {
		Window.create(800, by: 450, title: "Example - Shapes - Basic Shapes")
		Application.target(fps: 60)
	}

	mutating func update() {
		rotation += 0.2
	}
	
	func draw() {
		Renderer2D.text("some basic shapes available on raylib", at: 20, 20, color: .darkGray)
		
		// Circle shapes and lines
		let circleX = Window.width / 5
		Renderer2D.circle(at: circleX, 120, radius: 35, color: .darkBlue)
		Renderer2D.circle(at: circleX, 220, radius: 60, gradient: .green, .skyBlue)
		WireRenderer2D.circle(at: circleX, 340, radius: 80, color: .darkBlue)
		
		// Rectangle shapes and lines
		let rectangleX = Window.width / 4 * 2
		Renderer2D.rectangle(at: rectangleX - 60, 100, size: 120, 60, color: .red)
		Renderer2D.rectangle(at: rectangleX - 90, 170, size: 180, 130, gradientH: .maroon, .gold)
		WireRenderer2D.rectangle(at: rectangleX - 40, 320, size: 80, 60, color: .orange)
		
		// Triangle shapes and lines
		let triangleX = Window.width.toFloat / 4 * 3
		Renderer2D.triangle(
			a: triangleX, 80,
			b: triangleX - 60, 150,
			c: triangleX + 60, 150,
			color: .violet)

		WireRenderer2D.triangle(
			a: triangleX, 160,
			b: triangleX - 20, 230,
			c: triangleX + 20, 230,
			color: .darkBlue)
		
		// Polygon shapes and lines
		let polygonX = Window.width / 4 * 3
		Renderer2D.polygon(at: polygonX, 330, sides: 6, radius: 80, rotation: .degrees(rotation), color: .brown)
		WireRenderer2D.polygon(at: polygonX, 330, sides: 6, radius: 90, rotation: .degrees(rotation), color: .brown)
		WireRenderer2D.polygon(at: polygonX, 330, sides: 6, radius: 85, rotation: .degrees(rotation), thickness: 6, color: .beige)
		
		Renderer2D.line(from: 18, 42, to: Window.width.toFloat - 18, 42, color: .black)
	}
}
