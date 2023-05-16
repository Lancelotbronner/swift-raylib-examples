//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Raylib

//MARK: - Gameplay Scene

struct GameplayScene: Scene {
	
	//MARK: Properties
	
	var isPaused = false
	
	var player: Player
	var ball: Ball
	var bricks: [[Brick]]
	var numberOfBricks: Int
	let sizeOfBrick: Vector2f
	
	//MARK: Initialization
	
	init() {
		sizeOfBrick = Vector2f(Window.width.toFloat / Configuration.bricksPerLine.toFloat, Window.height.toFloat / 3 / Configuration.linesOfBricks.toFloat)
		
		player = Player(
			body: Rectangle(at: Window.width.toFloat / 2, Window.height.toFloat * 7 / 8, size: Window.width.toFloat / 10, Window.height.toFloat / 25),
			lives: Configuration.playerLives)
		
		ball = Ball(
			body: Circle(at: Window.width.toFloat / 2, Window.height.toFloat * 7 / 8, radius: 7),
			speed: .zero,
			isActive: false)
		
		numberOfBricks = Configuration.linesOfBricks * Configuration.bricksPerLine
		
		bricks = []
		bricks.reserveCapacity(Configuration.linesOfBricks)
		for i in 0 ..< Configuration.linesOfBricks {
			var line: [Brick] = []
			line.reserveCapacity(Configuration.bricksPerLine)
			let positionY = i.toFloat * sizeOfBrick.y + sizeOfBrick.y
			
			for j in 0 ..< Configuration.bricksPerLine {
				let positionX = j.toFloat * sizeOfBrick.x
				line.append(Brick(position: Vector2f(positionX, positionY), isActive: true))
			}
			bricks.append(line)
		}
	}
	
	//MARK: Simulation Methods
	
	mutating func update() -> SceneAction {
		if Keyboard.p.isPressed {
			isPaused.toggle()
		}
		
		guard !isPaused else {
			return .continue
		}
		
		// Player: Movement Logic
		
		if Keyboard.left.isDown {
			player.body.x -= 5
			player.body.x.minimum(of: 0)
		}
		
		if Keyboard.right.isDown {
			player.body.x += 5
			player.body.x.maximum(of: Window.width.toFloat - player.body.width)
		}
		
		// Ball: Launching Logic
		
		if !ball.isActive && Keyboard.space.isPressed {
			ball.isActive = true
			ball.speed = Vector2f(0, -5)
		}
		
		// Ball: Movement Logic
		
		if ball.isActive {
			ball.body.position += ball.speed
		} else {
			ball.body.position = Vector2f(player.body.center.x, Window.height.toFloat * 7 / 8 - 30)
		}
		
		// Collision Logic: Ball & Wall
		
		if ball.body.right.x >= Window.width.toFloat || ball.body.left.x <= 0 {
			ball.speed.x.negate()
		}
		
		if ball.body.top.y <= 0 {
			ball.speed.y.negate()
		}
		
		if ball.body.bottom.y >= Window.height.toFloat {
			ball.speed = .zero
			ball.isActive = false
			player.lives -= 1
		}
		
		// Collision Logic: Ball & Player
		
		if ball.body.collided(with: player.body), ball.speed.y > 0 {
			ball.speed.y.negate()
			ball.speed.x = (ball.body.position.x - player.body.center.x) / (player.body.size.x / 2) * 5
		}
			
		// Collision Logic: Ball & Brick
		
		var newSpeedOfBall = ball.speed
		for i in bricks.indices {
			for j in bricks[i].indices where bricks[i][j].isActive {
				let brick = Rectangle(at: bricks[i][j].position, size: sizeOfBrick)
				var collision = false
				
				if ball.body.translated(by: 0, ball.speed.y).collided(with: brick) {
					collision = true
					newSpeedOfBall.y = -ball.speed.y
				}

				if ball.body.translated(by: ball.speed.x, 0).collided(with: brick) {
					collision = true
					newSpeedOfBall.x = -ball.speed.x
				}
				 
				if collision {
					bricks[i][j].isActive = false
					numberOfBricks -= 1
				}
			}
		}
		
		ball.speed = newSpeedOfBall
		
		if player.lives <= 0 || numberOfBricks == 0 {
			return .replace(with: GameOverScene())
		}
		
		return .continue
	}
	
	//MARK: Drawing Methods
	
	func draw() {
		Renderer2D.rectangle(player.body, color: .black)
		Renderer2D.circle(ball.body, color: .maroon)
		
		for i in 0 ..< player.lives {
			Renderer2D.rectangle(at: 20 + 40 * i, Window.height - 30, size: 35, 10, color: .lightGray)
		}
		
		for i in bricks.indices {
			for j in bricks[i].indices where bricks[i][j].isActive {
				let color: Color = (i + j) % 2 == 0 ? .gray : .darkGray
				Renderer2D.rectangle(at: bricks[i][j].position, size: sizeOfBrick, color: color)
			}
		}
		
		if isPaused {
			Renderer2D.text(center: "GAME PAUSED", size: 40, color: .gray)
		}
	}
	
}
