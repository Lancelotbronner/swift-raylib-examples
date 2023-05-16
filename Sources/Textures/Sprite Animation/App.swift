import Raylib

@main struct SpritesheetExample: Applet {
	let ANIMATION_SPEED_RANGE: ClosedRange<UInt> = 1 ... 15
	
	let sprite: Texture
	let spritesheet: Spritesheet
	
	var position: Vector2f
	var frame: Rectangle
	var timeline = Timeline()
	var index = 0
	var framesPerSecond: UInt = 8
	
	init() throws {
		Window.create(800, by: 450, title: "Example - Textures - Sprite Animation")
		Application.target(fps: 60)
		
		sprite = try Filesystem
			.file(at: "scarfy.png", from: .module)
			.loadAsTexture()
		spritesheet = Spritesheet(of: 1, by: 6, within: sprite.size.toInt)
		
		position = Vector2(350, 280)
		frame = spritesheet.frame(of: 0, 0)
	}
	
	mutating func update() {
		timeline.update()
		
		timeline.every(timesPerSecond: framesPerSecond) {
			index += 1
			if index > 5 {
				index = 0
			}
			
			frame = spritesheet.frame(of: index, 0)
		}

		if Keyboard.right.isPressed {
			framesPerSecond += 1
			framesPerSecond.maximum(of: ANIMATION_SPEED_RANGE.upperBound)
		} else if Keyboard.left.isPressed {
			framesPerSecond -= 1
			framesPerSecond.minimum(of: ANIMATION_SPEED_RANGE.lowerBound)
		}
	}
	
	func draw() {
		Renderer2D.texture(sprite, at: 15, 40)
		WireRenderer2D.rectangle(at: 15, 40, size: sprite.width, sprite.height, color: .lime)
		WireRenderer2D.rectangle(at: 15 + frame.x.toInt, 40 + frame.y.toInt, size: frame.width.toInt, frame.height.toInt, color: .red)

		Renderer.pointSize = 10
		Renderer.textColor = .darkGray
		Renderer2D.text("FRAME SPEED:", at: 165, 210)
		Renderer2D.text("\(framesPerSecond, format: "%02i") FPS", at: 575, 210)
		Renderer2D.text("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", at: 290, 240)

		for i in 0 ..< ANIMATION_SPEED_RANGE.upperBound {
			let rectangle = Rectangle(at: 250 + 21 * i.toFloat, 205, size: 20, 20)
			if i < framesPerSecond {
				Renderer2D.rectangle(rectangle, color: .red)
			} else {
				WireRenderer2D.rectangle(rectangle, color: .red)
			}
		}

		Renderer2D.atlas(sprite, from: frame, at: position)

		Renderer2D.text("(c) Scarfy sprite by Eiden Marsal", at: Window.width - 200, Window.height - 20, color: .gray)
	}
	
}
