import Raylib

@main struct LogoRaylib: Applet {
	let logo: Texture
	
	init() throws {
		Window.create(800, by: 450, title: "Example - Textures - Logo Raylib")
		Application.target(fps: 60)
		
		logo = try Filesystem
			.file(at: "logo.png", from: .module)
			.loadAsTexture()
	}
	
	func draw() {
		Renderer2D.texture(logo, at: Window.size / 2 - logo.size / 2)
		Renderer2D.text("this IS a texture!", at: 360, 370, size: 10, color: .gray)
	}
}
