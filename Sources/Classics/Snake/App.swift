import Raylib

@main struct Snake: App {
	
	//MARK: Computed Properties
	
	var initial: Scene {
		GameplayScene()
	}
	
	//MARK: Initialization
	
	init() {
		Window.create(800, by: 450, title: "Snake")
		Application.target(fps: 60)
	}
	
}
