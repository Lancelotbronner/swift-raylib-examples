import Raylib

@main struct BasicWindow: Applet {
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - Basic Window")
		Application.target(fps: 60)
	}
	
	func draw() {
		Renderer2D.text(center: "Congrats! You created your first window!", color: Color.lightGray)
	}

}
