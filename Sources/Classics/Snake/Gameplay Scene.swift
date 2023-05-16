import Raylib

//MARK: - Gameplay Scene

struct GameplayScene: Scene {
	
	//MARK: Properties
	
	private let area: Rectangle
	private let grid: Vector2i
	
	private var timeline = Timeline()
	private var segments: [Vector2f] = []
	private var speed = Vector2f.zero
	private var food: Vector2f?
	
	private var score = 0
	private var isPaused = false
	
	//MARK: Computed Properties
	
	private var head: Vector2f {
		get { segments[0] }
		set { segments[0] = newValue }
	}
	
	private var body: DropFirstSequence<[Vector2f]> {
		segments.dropFirst()
	}
	
	//MARK: Initialization
	
	init() {
		let offset = (Window.size.toInt % Constants.sizeOfTile.toInt).toFloat
		area = Rectangle(at: offset / 2, size: Window.size - offset)
		grid = (Window.size / Constants.sizeOfTile).toInt
		
		segments.reserveCapacity(256)
		segments.append((grid / 2).toFloat * Constants.sizeOfTile + area.position)
	}
	
	//MARK: Update
	
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
			let newSpeed = Vector2f(horizontal, vertical) * Constants.sizeOfTile
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
			let positionInTiles = Vector2i(.random(in: 0 ..< grid.x), .random(in: 0 ..< grid.y))
			let position = positionInTiles.toFloat * Constants.sizeOfTile
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
	
	//MARK: Drawing
	
	func draw() {
		// Draw grid lines
		
		Renderer.color = .lightGray
		
		for i in 0 ..< grid.x + 1 {
			Renderer2D.line(from: i.toFloat * Constants.sizeOfTile.x + area.x, area.y, to: i.toFloat * Constants.sizeOfTile.y + area.x, area.bottom.y)
		}
		
		for i in 0 ..< grid.y + 1 {
			Renderer2D.line(from: area.x, i.toFloat * Constants.sizeOfTile.y + area.y, to: area.right.x, i.toFloat * Constants.sizeOfTile.y + area.y)
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
