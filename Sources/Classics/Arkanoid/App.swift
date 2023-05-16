//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib

@main struct Arkanoid: App {
	
	//MARK: Computed Properties
	
	var initial: Scene {
		GameplayScene()
	}
	
	//MARK: Initialization
	
	init() {
		Window.create(800, by: 450, title: "Arkanoid")
		Application.target(fps: 60)
	}
	
}
