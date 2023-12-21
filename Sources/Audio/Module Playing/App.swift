import RaylibKit

@main struct PlayingSoundsExample: Applet {
	var circles: [CircleWave]
	let music: Music
	var pause = false
	var pitch: Float = 1
	var progress: Float = 0

	init() throws {
		//TODO: Review View/Window flags
		ConfigurationFlags.msaa4x.configure()

		Window.create(800, by: 450, title: "Example - Audio - Module Playing")
		Application.target(fps: 60)

		AudioDevice.initialize()

		circles = []
		circles.reserveCapacity(CircleWave.max)
		for _ in 0..<CircleWave.max {
			circles.append(.random())
		}

		music = try Filesystem
			.file(at: "mini1111.xm", from: .module)
			.loadAsMusic()
		music.isLooping = false;
		music.play()
	}

	mutating func update() {
		music.update()

		// restart music
		if Keyboard.space.isPressed {
			music.restart()
			pause = false
		}

		// pause/resume music
		if Keyboard.p.isPressed {
			pause = !pause;
			music.paused(is: pause)
		}

		if Keyboard.down.isDown {
			pitch -= 0.01
		} else if Keyboard.up.isDown {
			pitch += 0.01
		}
		music.set(pitch: pitch)

		// scale the time played to the bar's dimensions
		progress = (music.played / music.length) * (Window.width - 40).toFloat

		// animate the color circles
		if !pause {
			for i in circles.indices {
				var wave = circles[i]
				wave.alpha += wave.speed
				wave.circle.radius += wave.speed * 10
				if wave.alpha > 1 {
					wave.speed *= -1
				} else if wave.alpha <= 0 {
					wave = .random()
				}
				circles[i] = wave
			}
		}
	}

	func draw() {
		for wave in circles {
			Renderer2D.circle(wave.circle, color: wave.color.faded(to: wave.alpha))
		}

		// draw the progress bar
		let y = Window.height - 20 - 12
		Renderer2D.rectangle(at: 20, y, size: Window.width - 40, 12, color: .lightGray)
		Renderer2D.rectangle(at: 20, y, size: progress.toInt, 12, color: .maroon)
		WireRenderer2D.rectangle(at: 20, y, size: Window.width - 40, 12, color: .gray)

		// Draw help instructions
		Renderer2D.rectangle(at: 20, 20, size: 425, 145, color: .white)
		WireRenderer2D.rectangle(at: 20, 20, size: 425, 145, color: .gray)
		Renderer.pointSize = 20
		Renderer2D.text("PRESS SPACE TO RESTART MUSIC", at: 40, 40)
		Renderer2D.text("PRESS P TO PAUSE/RESUME", at: 40, 70)
		Renderer2D.text("PRESS UP/DOWN TO CHANGE SPEED", at: 40, 100)
		Renderer2D.text("SPEED: \(pitch, decimals: 2)", at: 40, 130, color: .maroon)
	}

	func unload() {
		AudioDevice.close()
	}

}

struct CircleWave {
	static let max = 64
	static let colors = [Color.orange, .red, .gold, .lime, .blue, .violet, .brown, .lightGray, .pink, .yellow, .green, .skyBlue, .purple, .beige]

	var circle: Circle
	var alpha: Float = 0
	var speed: Float
	var color: Color

	static func random() -> CircleWave {
		let radius = Random.between(10, and: 40)
		let x = Random.between(radius, and: Window.width)
		let y = Random.between(radius, and: Window.height)
		let speed = Random.between(1, and: 100).toFloat / 2000
		let color = Random.element(in: CircleWave.colors)
		return CircleWave(
			circle: Circle(at: x.toFloat, y.toFloat, radius: radius.toFloat),
			speed: speed,
			color: color)
	}
}
