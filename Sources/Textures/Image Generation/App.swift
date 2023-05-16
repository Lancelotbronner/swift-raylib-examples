import Raylib

@main struct ImageGeneration: Applet {
	var index = 0

	var textures: [TextureItem]
	
	init() {
		Window.create(800, by: 450, title: "Examples - Textures - Image Generation")
		Application.target(fps: 60)

		textures = [
			TextureItem("VERTICAL GRADIENT", 560, .raywhite,
						Image.gradientV(size: Window.width, by: Window.height, from: .red, to: .blue)),
			TextureItem("HORIZONTAL GRADIENT", 540, .raywhite,
						Image.gradientH(size: Window.width, by: Window.height, from: .red, to: .blue)),
			TextureItem("RADIAL GRADIENT", 580, .lightGray,
						Image.gradientRadial(size: Window.width, by: Window.height, from: .white, to: .black)),
			TextureItem("CHECKED", 680, .raywhite,
						Image.checked(size: Window.width, by: Window.height, tiles: 32, 32, colors: .maroon, .darkBlue)),
			TextureItem("WHITE NOISE", 650, .red,
						Image.whiteNoise(size: Window.width, by: Window.height, factor: 0.5)),
			TextureItem("CELLULAR", 670, .raywhite,
						Image.cellular(size: Window.width, by: Window.height, cell: 32)),
		]
	}

	mutating func update() {
		if Mouse.left.isPressed || Keyboard.right.isPressed {
			index = textures.cycle(after: index)
		}
		if Mouse.right.isPressed || Keyboard.left.isPressed {
			index = textures.cycle(before: index)
		}
	}

	func draw() {
		textures[index].draw()

		Renderer2D.rectangle(at: 30, 400, size: 325, 30, color: .skyBlue.faded(to: 0.5))
		WireRenderer2D.rectangle(at: 30, 400, size: 325, 30, color: .white.faded(to: 0.5))
		Renderer2D.text("MOUSE LEFT BUTTON to CYCLE PROCEDURAL TEXTURES", at: 40, 410, size: 10, color: .white)
	}

}

struct TextureItem {
	let name: String
	let position: Int
	let color: Color
	let texture: Texture

	init(_ name: String, _ position: Int, _ color: Color, _ image: Image) {
		self.name = name
		self.position = position
		self.color = color
		texture = image.upload()
	}

	public func draw() {
		Renderer2D.texture(texture, at: .zero)
		Renderer2D.text(name, at: position, 10, color: color)
	}
}
