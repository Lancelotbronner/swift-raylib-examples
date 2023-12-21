import RaylibKit

@main struct Snake: App {
	
	var initial: Scene {
		GameplayScene()
	}
	
	init() {
		Window.create(800, by: 450, title: "Snake")
		Application.target(fps: 60)
	}
	
}
