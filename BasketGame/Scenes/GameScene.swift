//
//  GameScene.swift
//  BasketGame
//
//  Created by Jake on 4/23/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var objectCollision : [SKSpriteNode] = []
	
	let gameLayer = SKNode()
	var pauseLayer : PauseLayer? = nil
	var optionsLayer : OptionsLayer? = nil
	
	var background = SKSpriteNode(imageNamed: backgrounds[player.backgroundIndex].image)
	var basket = SKSpriteNode(imageNamed: baskets[player.basketIndex].image)
	
	let scoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let livesLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let protectionLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	
	var previousTouchX : CGFloat = 0
	
	var score = 0 {
		didSet {
			scoreLabel.text = "💰 \(score)"
			health += 0.5
			if health > maxHealth {
				health = maxHealth
			}
			livesLabel.text = getLifeString(health: health)
		}
	}
	
	let bounceSound = SKAudioNode(fileNamed: "ItemBouncing")
	let catchSound = SKAudioNode(fileNamed: "ItemSwish")
	let explosionSound = SKAudioNode(fileNamed: "BombExplode")
	let pauseButton = Button(defaultButtonImage: "PauseButton", activeButtonImage: "PauseButton", buttonAction: {})
	
	override func didMove(to view: SKView) {
		resetValues()
		
		bounceSound.autoplayLooped = false
		catchSound.autoplayLooped = false
		explosionSound.autoplayLooped = false
		bounceSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		catchSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		explosionSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		addChild(bounceSound)
		addChild(catchSound)
		addChild(explosionSound)
		
		
		scoreLabel.fontSize = 30
		scoreLabel.position = CGPoint(x: frame.width * 0.05, y: frame.height * 0.85)
		scoreLabel.zPosition = 2
		scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		protectionLabel.text = "💣 \(player.bombSaves)"
		protectionLabel.fontSize = 30
		protectionLabel.position = CGPoint(x: frame.width * 0.05, y: frame.height * 0.89)
		protectionLabel.zPosition = 2
		protectionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		
		livesLabel.fontSize = 30
		livesLabel.position = CGPoint(x: frame.width * 0.05, y: frame.height * 0.93)
		livesLabel.zPosition = 2
		livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		
		pauseLayer = PauseLayer(parentScene: self)
		pauseLayer!.isHidden = true
		pauseLayer?.zPosition = 2
		
		optionsLayer = OptionsLayer(parentScene: self)
		optionsLayer!.isHidden = true
		optionsLayer?.zPosition = 3
		
		background = SKSpriteNode(imageNamed: backgrounds[player.backgroundIndex].image)
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = 0
		background.scale(to: frame.size)
		
		pauseButton.action = togglePauseScreen
		pauseButton.position = CGPoint(x: frame.maxX - pauseButton.activeButton.size.width, y: frame.height - pauseButton.activeButton.size.height)
		pauseButton.zPosition = 2
		
		createBasket()
		self.addChild(scoreLabel)
		self.addChild(livesLabel)
		self.addChild(protectionLabel)
		self.addChild(pauseLayer!)
		self.addChild(optionsLayer!)
		gameLayer.addChild(background)
		gameLayer.addChild(pauseButton)
		self.addChild(gameLayer)
		
		setupPhysics()
		
		backgroundMusic = SKAudioNode(fileNamed: music[player.musicIndex].image)
		gameLayer.run(SKAction.sequence([
			SKAction.wait(forDuration: 1.0),
			SKAction.run { self.addChild(backgroundMusic) },
			SKAction.repeatForever(
				SKAction.sequence([
					SKAction.run(addObject),
					SKAction.wait(forDuration: Double(spawnTime))
				])
			)
		]))
	}
	
	func setupPhysics() {
		self.physicsWorld.gravity = gravity
		self.physicsWorld.contactDelegate = self
		let bottomLeft = CGPoint(x: 0, y: 0)
		let bottomRight = CGPoint(x: frame.width, y: 0)
		let topLeft = CGPoint(x: 0, y: frame.height)
		let topRight = CGPoint(x: frame.width, y: frame.height)
		let path = UIBezierPath()
		path.move(to: topLeft)
		path.addLine(to: bottomLeft)
		path.addLine(to: bottomRight)
		path.addLine(to: topRight)
		self.physicsBody = SKPhysicsBody(edgeChainFrom: path.cgPath)
		self.physicsBody?.categoryBitMask = PhysicsCategory.edge
		self.physicsBody?.contactTestBitMask = PhysicsCategory.object
		self.physicsBody?.collisionBitMask = PhysicsCategory.object
		self.physicsBody?.angularDamping = 1
		self.physicsBody?.linearDamping = 1
		self.physicsBody?.restitution = 1
	}
	
	func createBasket() {
		basket = SKSpriteNode(imageNamed: baskets[player.basketIndex].image)
		basket.position = CGPoint(x: frame.width * 0.5, y: basket.size.height/2 + frame.height * 0.05)
		basket.xScale = 1.15
		basket.yScale = 1.3
		basket.zPosition = 1
		basket.physicsBody = SKPhysicsBody(texture: basket.texture!, size: basket.size)
		basket.physicsBody?.affectedByGravity = false
		basket.physicsBody?.isDynamic = false
		basket.physicsBody?.usesPreciseCollisionDetection = true
		basket.physicsBody?.categoryBitMask = PhysicsCategory.basket
		basket.physicsBody?.contactTestBitMask = PhysicsCategory.object
		basket.physicsBody?.collisionBitMask = PhysicsCategory.none
		basket.physicsBody?.angularDamping = 1
		basket.physicsBody?.linearDamping = 1
		basket.physicsBody?.restitution = 1
		gameLayer.addChild(basket)
	}
	
	func displayOptionsScene() {
		optionsLayer?.isHidden = false
		optionsLayer?.present()
		pauseButton.isHidden = true
	}
	
	func optionsSaved() {
		optionsLayer?.isHidden = true
		pauseButton.isHidden = false
	}
	
	func togglePauseScreen() {
		if !optionsLayer!.isHidden {
			return
		}
		gameLayer.isPaused = !gameLayer.isPaused
		pauseLayer!.isHidden = !pauseLayer!.isHidden
		self.physicsWorld.speed = self.physicsWorld.speed == 0 ? 1 : 0
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		var firstBody : SKPhysicsBody
		var secondBody : SKPhysicsBody
		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA
		}
		
		if let object = firstBody.node as? FallingObject {
			if object.position.x < 0 || object.position.x > frame.width {
				object.removeFromParent()
				return
			}
		}
		
		if ((firstBody.categoryBitMask == PhysicsCategory.object) &&
			(secondBody.categoryBitMask == PhysicsCategory.basket)) {
			if let object = firstBody.node as? FallingObject, gameLayer.children.contains(object), !objectCollision.contains(object) {
				contactWithBasket(by: object, at: contact.contactPoint)
				objectCollision.append(object)
			}
		} else if ((firstBody.categoryBitMask == PhysicsCategory.object) &&
				   (secondBody.categoryBitMask == PhysicsCategory.edge)) {
			if let object = firstBody.node as? FallingObject, gameLayer.children.contains(object) {
				contactWithEdge(by: object, at: contact.contactPoint)
			}
		}
	}
	
	func addObject() {
		let object = determineObject()
		object.physicsBody = SKPhysicsBody(texture: object.texture!, size: object.size)
		object.physicsBody?.isDynamic = true
		object.physicsBody?.categoryBitMask = PhysicsCategory.object
		object.physicsBody?.contactTestBitMask = PhysicsCategory.basket
		object.physicsBody?.collisionBitMask = PhysicsCategory.basket
		object.physicsBody?.affectedByGravity = false
		object.physicsBody?.angularDamping = 0
		object.physicsBody?.linearDamping = 0
		object.physicsBody?.restitution = 0
		object.physicsBody?.allowsRotation = true
		object.physicsBody?.usesPreciseCollisionDetection = true
		
		let xSpawn = random(min: object.size.width / 2 + 1, max: frame.width - object.size.width / 2 - 1)
		object.position = CGPoint(x: xSpawn, y: frame.height + object.size.height / 2)
		object.zPosition = 1
		gameLayer.addChild(object)
		
		object.physicsBody?.velocity = CGVector(dx: 0, dy: random(min: minDY, max: maxDY))
	}
	
	func contactWithEdge(by object: FallingObject, at point: CGPoint) {
		if point.y <= object.size.height*0.1 {
			object.removeFromParent()
			guard object.value == 1 else {
				return
			}
			health -= 1
			livesLabel.text = getLifeString(health: health)
			if health <= 0 {
				gameover()
			}
		}
	}
	
	func gameover() {
		let scene = GameOverScene(size: view!.bounds.size)
		self.scene?.view?.presentScene(scene, transition: .crossFade(withDuration: 1.0))
		scene.setScore(score: score)
		if player.setMaxScore(score: score) {
			scene.newHighScore()
		}
		player.coins += score
	}
	
	func contactWithBasket(by object: FallingObject, at point: CGPoint) {
		if (object.value == 0) {
			guard player.bombSaves > 0 else {
				run(SKAction.sequence([SKAction.run {
					self.explosionSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
					self.explosionSound.run(SKAction.play())
				}, SKAction.wait(forDuration: 0.1), SKAction.run {
					self.objectCollision.remove(at: self.objectCollision.firstIndex(of: object)!)
				}]))
				gameover()
				return
			}
			player.bombSaves -= 1
			protectionLabel.text = "💣 \(player.bombSaves)"
			run(SKAction.sequence([SKAction.run {
				self.bounceSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
				self.bounceSound.run(SKAction.play())
			}, SKAction.wait(forDuration: 0.1), SKAction.run {
				self.objectCollision.remove(at: self.objectCollision.firstIndex(of: object)!)
			}]))
			object.removeFromParent()
			return
		}
		guard !isOnCornerOfBasket(object: object, point: point) else {
			bounceObject(object)
			run(SKAction.sequence([SKAction.run {
				self.bounceSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
				self.bounceSound.run(SKAction.play())
			}, SKAction.wait(forDuration: 0.1), SKAction.run {
				self.objectCollision.remove(at: self.objectCollision.firstIndex(of: object)!)
			}]))
			return
		}
		object.removeFromParent()
		score += object.value
		if score % 10 == 0 {
			increaseDifficulty()
		}
		run(SKAction.sequence([SKAction.run {
			self.catchSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
			self.catchSound.run(SKAction.play())
		}, SKAction.wait(forDuration: 0.1), SKAction.run {
			self.objectCollision.remove(at: self.objectCollision.firstIndex(of: object)!)
		}]))
	}
	
	func increaseDifficulty() {
		minDY += difficulty * minDY
		maxDY += difficulty * maxDY
		if edgeTolerance > 0 {
			edgeTolerance -= difficulty
		}
		spawnTime -= difficulty
		gameLayer.removeAllActions()
		gameLayer.run(SKAction.sequence([
			SKAction.repeatForever(
				SKAction.sequence([
					SKAction.run(addObject),
					SKAction.wait(forDuration: Double(spawnTime))
				])
			)
		]))
		//		if score % 50 == 0 {
		//			if maxHealth > minHealth {
		//				maxHealth -= 1
		//				if health > maxHealth {
		//					health = maxHealth
		//				}
		//				livesLabel.text = getLifeString(health: health)
		//			}
		//		}
	}
	
	func bounceObject(_ object: SKSpriteNode) {
		object.physicsBody?.affectedByGravity = true
	}
	
	func isOnCornerOfBasket(object: SKSpriteNode, point: CGPoint) -> Bool {
		let leftEdgeBasket = basket.position.x - basket.size.width/2
		let rightEdgeBasket = basket.position.x + basket.size.width/2
		let leftEdgeObject = object.position.x - object.size.width/2
		let rightEdgeObject = object.position.x + object.size.width/2
		
		return (rightEdgeObject >= rightEdgeBasket + edgeTolerance*object.size.width) || (leftEdgeObject <= leftEdgeBasket - edgeTolerance*object.size.width)
	}
	
	func touchDown(atPoint pos : CGPoint) {
		if (!gameLayer.isPaused) {
			previousTouchX = pos.x
		} else {
			if (!pauseLayer!.contains(pos) && optionsLayer!.isHidden) {
				togglePauseScreen()
				previousTouchX = pos.x
			}
		}
	}
	
	func touchMoved(toPoint pos : CGPoint) {
		if (!gameLayer.isPaused) {
			if pos.x < previousTouchX && basket.position.x - (previousTouchX - pos.x) >= basket.size.width/2 {
				basket.position.x -= previousTouchX - pos.x
			} else if pos.x >= previousTouchX && basket.position.x + (pos.x - previousTouchX) <= frame.width - basket.size.width/2 {
				basket.position.x += pos.x - previousTouchX
			}
			previousTouchX = pos.x
		} else {
			if (!pauseLayer!.contains(pos) && optionsLayer!.isHidden) {
				togglePauseScreen()
			}
		}
	}
	
	func touchUp(atPoint pos : CGPoint) {
		if (!gameLayer.isPaused) {
			previousTouchX = pos.x
		} else {
			if (!pauseLayer!.contains(pos) && optionsLayer!.isHidden) {
				togglePauseScreen()
				previousTouchX = pos.x
			}
		}
	}
	
	func resetValues() {
		score = 0
		minDY = -600
		maxDY = -300
		edgeTolerance = 0.25
		spawnTime = 1.0
		maxHealth = 5.0
		health = 5
		livesLabel.text = getLifeString(health: health)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches { self.touchDown(atPoint: t.location(in: self)) }
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches { self.touchUp(atPoint: t.location(in: self)) }
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches { self.touchUp(atPoint: t.location(in: self)) }
	}
}
