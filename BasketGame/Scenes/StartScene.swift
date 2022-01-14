//
//  StartScene.swift
//  BasketGame
//
//  Created by Jake on 4/27/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
	
	var optionsLayer : OptionsLayer? = nil
	
	let optionsButton = Button(defaultButtonImage: "OptionsButton", activeButtonImage: "OptionsButtonPushed", buttonAction: {})
	let storeButton = Button(defaultButtonImage: "ShopButton", activeButtonImage: "ShopButtonPushed", buttonAction: {})
	let playButton = Button(defaultButtonImage: "StartButton", activeButtonImage: "StartButtonPushed", buttonAction: {})
	
	override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "MainBackground")
		let minY = (frame.height - background.size.height)/2
		background.scale(to: frame.size)
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = 0
		
		optionsButton.action = goToOptionsScene
		storeButton.action = goToStoreScene
		playButton.action = goToGameScene
		
		optionsLayer = OptionsLayer(parentScene: self)
		optionsLayer!.isHidden = true
		optionsLayer?.zPosition = 2
		
		let buttonHeight = optionsButton.activeButton.size.height
		var height =  minY + buttonHeight * 0.75;
		
		optionsButton.position = CGPoint(x: frame.midX, y: height)
		optionsButton.zPosition = 1
		height += buttonHeight * 1.1
		
		storeButton.position = CGPoint(x: frame.midX, y: height)
		storeButton.zPosition = 1
		height += buttonHeight * 1.1
		
		playButton.position = CGPoint(x: frame.midX, y: height)
		playButton.zPosition = 1
		
		let coinsLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		coinsLabel.fontSize = 30
		coinsLabel.position = CGPoint(x: 0.65*frame.width, y: 0.93*frame.height)
		coinsLabel.zPosition = 1
		coinsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		coinsLabel.text = "💰 \(player.coins)"
		
		let bombSaveLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		
		bombSaveLabel.fontSize = 30
		bombSaveLabel.position = CGPoint(x: 0.65*frame.width, y: 0.88*frame.height)
		bombSaveLabel.zPosition = 1
		bombSaveLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		bombSaveLabel.text = "💣 \(player.bombSaves)"
		
		self.addChild(background)
		self.addChild(playButton)
		self.addChild(storeButton)
		self.addChild(optionsButton)
		self.addChild(coinsLabel)
		self.addChild(bombSaveLabel)
		self.addChild(optionsLayer!)
		
		backgroundMusic = SKAudioNode(fileNamed: "Smooth Lovin")
		self.run(SKAction.wait(forDuration: 0.7)) {
			self.addChild(backgroundMusic)
		}
	}
	
	func goToGameScene() {
		let scene = GameScene(size: view!.bounds.size)
		self.scene?.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.5))
	}
	
	func goToStoreScene() {
		let scene = StoreScene(size: view!.bounds.size)
		self.scene?.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.5))
	}
	
	func goToOptionsScene() {
		optionsLayer?.isHidden = false
		optionsLayer?.present()
		optionsButton.isHidden = true
		storeButton.isHidden = true
		playButton.isHidden = true
	}
	
	func optionsSaved() {
		optionsLayer?.isHidden = true
		optionsButton.isHidden = false
		storeButton.isHidden = false
		playButton.isHidden = false
	}
}
