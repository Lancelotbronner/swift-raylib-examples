import RaylibKit

//MARK: - Application

@main struct BlendModes: Applet {
	let background: Texture
	let foreground: Texture
	var index = 0
	
	let modes: [BlendItem] = [
		BlendItem("ALPHA", BlendMode.alpha),
		BlendItem("ADDITIVE", BlendMode.additive),
		BlendItem("MULTIPLIED", BlendMode.multiplied),
		BlendItem("ADD COLORS", BlendMode.addColors),
		BlendItem("SUBTRACT COLORS", BlendMode.subtractColors),
		BlendItem("ALPHA PREMULTIPLIED", BlendMode.alphaPremultiply),
	]
	
	init() throws {
		Window.create(800, by: 450, title: "Example - Textures - Blend Modes")
		Application.target(fps: 60)

		background = try Texture(at: "background.png", bundle: .module)
		foreground = try Texture(at: "foreground.png", bundle: .module)
	}
	
	mutating func update() {
		if Keyboard.space.isPressed {
			index = modes.cycle(after: index)
		}
	}
	
	func draw() {
		let mode = modes[index]

		Renderer2D.texture(background, at: Window.size / 2 - background.size / 2)
		mode.draw(texture: foreground)
		
		// Draw the texts
		Renderer.pointSize = 10
		Renderer.textColor = .gray
		Renderer2D.text(center: "Press SPACE to change blend modes.", offset: 0, 140)
		Renderer2D.text(center: "Current: \(mode.name)", offset: 0, 160)
		
		Renderer2D.text("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", at: Window.width - 330, Window.height - 20)
	}
}

struct BlendItem {
	let name: String
	let mode: BlendMode

	init(_ name: String, _ mode: BlendMode) {
		self.name = name
		self.mode = mode
	}

	func draw(texture: Texture) {
		Renderer.blend(mode) {
			Renderer2D.texture(texture, at: Window.size / 2 - texture.size / 2)
		}
	}
}
