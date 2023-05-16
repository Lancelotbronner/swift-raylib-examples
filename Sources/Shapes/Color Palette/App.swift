import Raylib

@main struct ColorPalette: Applet {
	var palette = [
		PaletteItem("DARK GRAY", .darkGray),
		PaletteItem("MAROON", .maroon),
		PaletteItem("ORANGE", .orange),
		PaletteItem("DARK GREEN", .darkGreen),
		PaletteItem("DARK BLUE", .darkBlue),
		PaletteItem("DARK PURPLE", .darkPurple),
		PaletteItem("DARK BROWN", .darkBrown),
		PaletteItem("GRAY", .gray),
		PaletteItem("RED", .red),
		PaletteItem("GOLD", .gold),
		PaletteItem("LIME", .lime),
		PaletteItem("BLUE", .blue),
		PaletteItem("VIOLET", .violet),
		PaletteItem("BROWN", .brown),
		PaletteItem("LIGHT GRAY", .lightGray),
		PaletteItem("PINK", .pink),
		PaletteItem("YELLOW", .yellow),
		PaletteItem("GREEN", .green),
		PaletteItem("SKY BLUE", .skyBlue),
		PaletteItem("PURPLE", .purple),
		PaletteItem("BEIGE", .beige),
	]
	
	init() {
		Window.create(800, by: 450, title: "Example - Shapes - Color Palette")
		Application.target(fps: 60)
	}
	
	mutating func update() {
		let mouse = Mouse.position
		for i in palette.indices {
			palette[i].hovered = palette[i].frame.contains(mouse)
		}
	}
	
	func draw() {
		Renderer2D.text("raylib color palette", at: 28, 42)
		Renderer2D.text("press SPACE to see all colors", at: Window.width - 180, Window.height - 40, size: 10, color: .gray)
		
		for item in palette {
			item.draw(details: Keyboard.space.isDown)
		}
	}
}

struct PaletteItem {
	static let size: Float = 100
	static var index = 0
	
	let name: String
	let color: Color
	let position: Vector2f
	var hovered = false
	
	var frame: Rectangle {
		Rectangle(at: position.x, position.y, size: Self.size, Self.size)
	}
	
	init(_ name: String, _ color: Color) {
		self.name = name
		self.color = color

		let row = (PaletteItem.index / 7).toFloat
		let column = (PaletteItem.index % 7).toFloat
		let x = 20 + PaletteItem.size * column + 10 * column
		let y = 80 + PaletteItem.size * row + 10 * row
		position = Vector2f(x, y)

		Self.index += 1
	}

	func draw(details: Bool) {
		Renderer2D.rectangle(frame, color: color.faded(to: hovered ? 0.6 : 1))

		guard details || hovered else { return }

		Renderer2D.rectangle(at: frame.left.x.toInt, frame.bottom.y.toInt - 26, size: PaletteItem.size.toInt, 20, color: .black)
		WireRenderer2D.rectangle(frame, thickness: 6, color: .black.faded(to: 0.3))
		Renderer2D.text(name, at: frame.right.x.toInt - 12, frame.bottom.y.toInt - 20, size: 10, alignment: .right, color: color)
	}
	
}
