//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib

//MARK: - Constants

struct Configuration {
	
	/// The number of lives for the player
	static let playerLives = 5
	
	/// The number of lines of bricks
	static let linesOfBricks = 5
	
	/// The number of bricks per line
	static let bricksPerLine = 20
	
}

//MARK: - Structures

struct Player {
	var body: Rectangle
	var lives: Int
}

struct Ball {
	var body: Circle
	var speed: Vector2f
	var isActive: Bool
}

struct Brick {
	var position: Vector2f
	var isActive: Bool
}
