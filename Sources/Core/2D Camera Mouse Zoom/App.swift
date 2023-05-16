import Raylib

//MARK: - Application

@main struct ExampleCamera2DMouseZoom: Applet {
	let ZOOM_INCREMENT: Float = 0.125

	var player: Rectangle
	var camera: Camera2D
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - 2D Camera Mouse Zoom")
		Renderer.background = .black
		Application.target(fps: 60)
		
		player = Rectangle(at: 400, 280, size: 40, 40)
		camera = Camera2D()
	}
	
	mutating func update() {
		if Mouse.right.isDown {
			camera.translate(by: Mouse.delta)
		}
		
		if Mouse.wheel != 0 {
			camera.offset = Mouse.position
			camera.target = camera.toWorld(screen: Mouse.position)
			camera.zoom += Mouse.wheel * ZOOM_INCREMENT;
			camera.zoom.minimum(of: ZOOM_INCREMENT)
		}
	}
	
	func draw() {
		Renderer.camera(camera) {
			/*
			 // Draw the 3d grid, rotated 90 degrees and centered around 0,0
			 // just so we have something in the XY plane
			 rlPushMatrix();
			 rlTranslatef(0, 25*50, 0);
			 rlRotatef(90, 1, 0, 0);
			 DrawGrid(100, 50);
			 rlPopMatrix();

			 // Draw a reference circle
			 DrawCircle(100, 100, 50, YELLOW);
			 */

			Renderer2D.circle(at: 100, 100, radius: 50, color: .yellow)
		}

		Renderer2D.text("Mouse right button drag to move, mouse wheel to zoom", at: 10, 10, color: .white);
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
}
