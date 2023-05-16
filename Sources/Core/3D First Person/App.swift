//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib

@main struct FirstPerson3D: Applet {
	let camera: Camera3D
	let columns: [Column]
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - 3D First Person")
		Application.target(fps: 60)
		
//		camera.position = (Vector3){ 4.0f, 2.0f, 4.0f };
//		camera.target = (Vector3){ 0.0f, 1.8f, 0.0f };
//		camera.up = (Vector3){ 0.0f, 1.0f, 0.0f };
//		camera.fovy = 60.0f;
//		camera.projection = CAMERA_PERSPECTIVE;
		
		columns = [Column](repeat: 20, value: .random)
		
//		SetCameraMode(camera, CAMERA_FIRST_PERSON); // Set a first person camera mode
	}
	
	func update() {
//		camera.update()
	}
	
	func draw() {
		camera.render {
//			DrawPlane((Vector3){ 0.0f, 0.0f, 0.0f }, (Vector2){ 32.0f, 32.0f }, LIGHTGRAY); // Draw ground
//			DrawCube((Vector3){ -16.0f, 2.5f, 0.0f }, 1.0f, 5.0f, 32.0f, BLUE);     // Draw a blue wall
//			DrawCube((Vector3){ 16.0f, 2.5f, 0.0f }, 1.0f, 5.0f, 32.0f, LIME);      // Draw a green wall
//			DrawCube((Vector3){ 0.0f, 2.5f, 16.0f }, 32.0f, 5.0f, 1.0f, GOLD);      // Draw a yellow wall
			
			// Draw some cubes around
//			for (int i = 0; i < MAX_COLUMNS; i++)
//			{
//				DrawCube(positions[i], 2.0f, heights[i], 2.0f, colors[i]);
//				DrawCubeWires(positions[i], 2.0f, heights[i], 2.0f, MAROON);
//			}
		}
		
		Renderer2D.rectangle(at: 10, 10, size: 220, 70, color: .skyBlue.faded(to: 0.5))
		WireRenderer2D.rectangle(at: 10, 10, size: 220, 70, color: .blue)
		
		Renderer.pointSize = 10
		Renderer.textColor = .darkGray
		Renderer2D.text("First person camera default controls:", at: 20, 20, color: .black)
		Renderer2D.text("- Move with keys: W, A, S, D", at: 40, 40)
		Renderer2D.text("- Mouse move to look around", at: 40, 60)
	}
	
}

struct Column {
	let height: Float
	let position: Vector3f
	let color: Color
	
	static var random: Column {
		let height = Random.between(1, and: 12).toFloat
		return Column(
			height: height,
			position: Vector3f(x: .random(in: -15 ..< 15), y: height / 2, z: .random(in: -15 ..< 15)),
			color: .random)
	}
}
