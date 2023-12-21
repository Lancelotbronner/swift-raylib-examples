import RaylibKit

struct GameOverScene: Scene {
	
	init() {
		
	}
	
	func update() -> SceneAction {
		if Keyboard.enter.isPressed {
			return .replace(with: GameplayScene())
		}
		
		return .continue
	}
	
	func draw() {
		Renderer2D.text(center: "PRESS [ENTER] TO PLAY AGAIN", size: 40, color: .gray)
	}
	
}
