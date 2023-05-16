//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib
import Darwin

@main struct FollowingEyes: Applet {
	let EYE_RADIUS: Float = 80
	let IRIS_RADIUS: Float = 24
	
	let leftEye: Vector2f
	var leftIris: Vector2f
	let rightEye: Vector2f
	var rightIris: Vector2f

	init() {
		Window.create(800, by: 450, title: "Example - Shapes - Following Eyes")
		Application.target(fps: 60)
		
		let center = Window.size / 2
		
		leftIris = center
		leftIris.x -= 100
		leftEye = leftIris
		
		rightIris = center
		rightIris.x += 100
		rightEye = rightIris
	}
	
	mutating func update() {
		leftIris = Mouse.position
		rightIris = Mouse.position
		
		if !Circle(at: leftEye, radius: EYE_RADIUS - 20).contains(leftIris) {
			let angle = leftEye.angle(with: leftIris)
			leftIris = leftEye + angle.vector(length: EYE_RADIUS - IRIS_RADIUS)
		}
		
		if !Circle(at: rightEye, radius: EYE_RADIUS - 20).contains(rightIris) {
			let angle = rightEye.angle(with: rightIris)
			rightIris = rightEye + angle.vector(length: EYE_RADIUS - IRIS_RADIUS)
		}
	}
	
	func draw() {
		Renderer2D.circle(at: leftEye, radius: EYE_RADIUS, color: .lightGray)
		Renderer2D.circle(at: leftIris, radius: IRIS_RADIUS, color: .brown)
		Renderer2D.circle(at: leftIris, radius: IRIS_RADIUS / 2, color: .black)
		
		Renderer2D.circle(at: rightEye, radius: EYE_RADIUS, color: .lightGray)
		Renderer2D.circle(at: rightIris, radius: IRIS_RADIUS, color: .darkGreen)
		Renderer2D.circle(at: rightIris, radius: IRIS_RADIUS / 2, color: .black)
		
		Renderer2D.fps(at: 10, 10)
	}
	
}
