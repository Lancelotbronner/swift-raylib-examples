import RaylibKit

struct GameplayScene: Scene {
	
	private let area: Rectangle
	private let grid: Point2
	
	private var timeline = Timeline()
	private var segments: [Vector2] = []
	private var speed = Vector2.zero
	private var food: Vector2?
	
	private var score = 0
	private var isPaused = false
	
	init() {
		let offset = Point2(Window.size) % Point2(Constants.sizeOfTile)
		area = Rectangle(at: Vector2(offset / 2), size: Window.size - Vector2(offset))
		grid = Point2(Window.size / Constants.sizeOfTile)

		segments.reserveCapacity(256)
		segments.append(Vector2(grid / 2) * Constants.sizeOfTile + area.position)
	}

	private var head: Vector2 {
		get { segments[0] }
		set { segments[0] = newValue }
	}

	private var body: DropFirstSequence<[Vector2]> {
		segments.dropFirst()
	}
	
	mutating func update() -> SceneAction {

		// Pause Controls
		
		if Keyboard.p.isPressed {
			isPaused.toggle()
		}
		
		guard !isPaused else {
			return .continue
		}
		
		// Components
		
		timeline.update()
		
		// Player Controls
		
		var horizontal: Float = 0
		var vertical: Float = 0
		var hasMovement = true
		
		switch true {
		case Keyboard.right.isDown: horizontal = 1
		case Keyboard.left.isDown: horizontal = -1
		case Keyboard.up.isDown: vertical = -1
		case Keyboard.down.isDown: vertical = 1
		default: hasMovement = false
		}
		
		if hasMovement {
			let newSpeed = Vector2(horizontal, vertical) * Constants.sizeOfTile
			var apply = true
			
			if segments.count > 1, head + newSpeed == segments[1] {
				apply = false
			}
			
			if apply {
				speed = newSpeed
			}
		}
		
		// 200ms timer for movement and collisions
		
		guard timeline.every(milliseconds: 120) else {
			return .continue
		}
		
		// Snake Movement
		
		for i in stride(from: segments.count - 1, through: 1, by: -1) {
			segments[i] = segments[i - 1]
		}
		
		head += speed
		
		// Collision with Walls
		
		guard area.contains(head) else {
			return .replace(with: GameOverScene())
		}

		// Collision with yourself
		
		if body.contains(head) {
			return .replace(with: GameOverScene())
		}
		
		// Food generation

		while food == nil {
			let positionInTiles = Point2(.random(in: 0 ..< grid.x), .random(in: 0 ..< grid.y))
			let position = Vector2(positionInTiles) * Constants.sizeOfTile
			guard !segments.contains(position) else { continue }
			food = position + area.position
		}
		
		// Food collecting
		
		if head == food {
			segments.append(segments[segments.count - 1])
			food = nil
			score += 1
		}
		
		return .continue
	}
	
	func draw() {
		// Draw grid lines
		
		Renderer.color = .lightGray
		
		for i in 0 ..< grid.x + 1 {
			let x = i.toFloat * Constants.sizeOfTile.x + area.x
			Renderer2D.line(from: x, area.y, to: x, area.bottom.y)
		}
		
		for i in 0 ..< grid.y + 1 {
			let y = i.toFloat * Constants.sizeOfTile.y + area.y
			Renderer2D.line(from: area.x, y, to: area.right.x, y)
		}
		
		// Draw snake
		
		Renderer2D.rectangle(at: head, size: Constants.sizeOfTile, color: .darkBlue)
		
		for segment in body {
			Renderer2D.rectangle(at: segment, size: Constants.sizeOfTile, color: .blue)
		}
		
		// Draw Food
		
		if let food = food {
			Renderer2D.rectangle(at: food, size: Constants.sizeOfTile, color: .skyBlue)
		}
		
		// User Interface
		
		Renderer2D.text("SCORE: \(score)", at: 8, 8, color: .red)
	
		if isPaused {
			Renderer2D.text(center: "GAME PAUSED", size: 40, color: .maroon)
		}
	}
	
}
