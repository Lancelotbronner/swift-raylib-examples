//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib

@main struct DropFiles: Applet {
	
	init() {
		Window.create(800, by: 450, title: "Example - Core - Drop Files")
		Application.target(fps: 60)
	}

	func update() {
		DragAndDrop.refresh()
	}
	
	func draw() {
		Renderer2D.text("Drop your files to this window!", at: 100, 40, size: 20, color: .darkGray)

		for (i, path) in DragAndDrop.paths.enumerated() {
			Renderer2D.rectangle(at: 0, 85 + 40 * i, size: Window.width, 40, color: .lightGray.faded(to: i % 2 == 0 ? 0.5 : 0.3))
			Renderer2D.text(path.description, at: 120, 100 + 40 * i, size: 10, color: .gray)
		}

		Renderer2D.text("Drop new files...", at: 100, 110 + 40 * DragAndDrop.paths.count, size: 20, color: .darkGray)
	}
	
	func unload() {
		DragAndDrop.clear()
	}
	
}
