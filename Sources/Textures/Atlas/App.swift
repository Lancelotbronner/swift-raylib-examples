import Raylib

@main struct SpritesheetExample: Applet {
	let sprite: Texture
	let spritesheet: Spritesheet
	let source: Rectangle
	let destination: Rectangle
	var rotation: Float = 0
	
	init() throws {
		Window.create(800, by: 450, title: "Example - Textures - Atlas (texture source and destination rectangles)")
		Application.target(fps: 60)
		
		sprite = try Filesystem
			.file(at: "scarfy.png", from: .module)
			.loadAsTexture()
		spritesheet = Spritesheet(of: 1, by: 6, within: sprite.size.toInt)

		source = spritesheet.frame(of: 0, 0)
		destination = Rectangle(at: Window.position / 2, size: source.size * 2)
	}
	
	mutating func update() {

		rotation += 1
	}
	
	func draw() {
		Renderer2D.atlas(sprite, from: source, to: destination, origin: source.size, rotation: rotation);

		Renderer2D.line(from: destination.x, 0, to: destination.x, Window.height.toFloat, color: .gray)
		Renderer2D.line(from: 0, destination.y, to: Window.width.toFloat, destination.y, color: .gray)

		Renderer2D.text("(c) Scarfy sprite by Eiden Marsal", at: Window.width - 200, Window.height - 20, size: 10, color: .gray)
	}
	
}
