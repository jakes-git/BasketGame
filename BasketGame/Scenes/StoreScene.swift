//
//  StoreScene.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class StoreScene: SKScene {
	
	let basketButton = ToggleButton(offButtonImage: "ShopBasketButton", onButtonImage: "ShopBasketButtonSelected", buttonAction: {})
	let backgroundButton = ToggleButton(offButtonImage: "ShopBackgroundButton", onButtonImage: "ShopBackgroundButtonSelected", buttonAction: {})
	let bombButton = ToggleButton(offButtonImage: "ShopBombButton", onButtonImage: "ShopBombButtonSelected", buttonAction: {})
	let musicButton = ToggleButton(offButtonImage: "ShopMusicButton", onButtonImage: "ShopMusicButtonSelected", buttonAction: {})
	
	let leftButton = Button(defaultButtonImage: "LeftShopArrow", activeButtonImage: "LeftShopArrowClicked", buttonAction: {})
	let rightButton = Button(defaultButtonImage: "RightShopArrow", activeButtonImage: "RightShopArrowClicked", buttonAction: {})
	
	let displayedImage = SKSpriteNode(imageNamed: baskets[player.basketIndex].preview)
	
	let buyButton = Button(defaultButtonImage: "ShopBuyButton", activeButtonImage: "ShopBuyButtonPushed", buttonAction: {})
	let selectButton = Button(defaultButtonImage: "ShopSelectButton", activeButtonImage: "ShopSelectButtonPushed", buttonAction: {})
	let selectedButton = Button(defaultButtonImage: "ShopSelectedButton", activeButtonImage: "ShopSelectedButtonPushed", buttonAction: {})
	
	let coinsLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let bombSaveLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	
	let nameLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let descriptionLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let descriptionLabel2 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let costLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	
	override func didMove(to view: SKView) {
		basketButton.action = selectBasketCategory
		backgroundButton.action = selectBackgroundCategory
		bombButton.action = selectBombCategory
		musicButton.action = selectMusicCategory
		leftButton.action = moveLeft
		rightButton.action = moveRight
		buyButton.action = handlePurchase
		selectButton.action = handleSelection
		categorySelection()
		indexSelection()
		updateImage()
		updateBuyUseButton()
		
		handleInitialClickMusic()
		
		let background = SKSpriteNode(imageNamed: "ShopScene")
		background.scale(to: frame.size)
		background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
		background.zPosition = 0
		
		let backButton = Button(defaultButtonImage: "ShopBackArrow", activeButtonImage: "ShopBackArrowPushed", buttonAction: goToStartScene)
		backButton.position = CGPoint(x: 3*backButton.activeButton.size.width/4, y: self.frame.height - 3*backButton.activeButton.size.height/4)
		backButton.zPosition = 1
		
		backgroundButton.position = CGPoint(x: self.frame.midX - backgroundButton.onButton.size.width/2, y: self.frame.height - 3*backgroundButton.onButton.size.height/2)
		basketButton.position = CGPoint(x: self.frame.midX - 3*basketButton.onButton.size.width/2, y: backgroundButton.position.y)
		bombButton.position = CGPoint(x: self.frame.midX + bombButton.onButton.size.width/2, y: backgroundButton.position.y)
		musicButton.position = CGPoint(x: self.frame.midX + 3*musicButton.onButton.size.width/2, y: backgroundButton.position.y)
		backgroundButton.zPosition = 1
		basketButton.zPosition = 1
		bombButton.zPosition = 1
		musicButton.zPosition = 1
		
		leftButton.position = CGPoint(x: 0.75 * leftButton.activeButton.size.width, y: self.frame.midY)
		rightButton.position = CGPoint(x: self.frame.width - 0.75 * leftButton.activeButton.size.width, y: self.frame.midY)
		leftButton.zPosition = 1
		rightButton.zPosition = 1
		
		displayedImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
		displayedImage.zPosition = 1
		
		buyButton.position = CGPoint(x: self.frame.midX, y: 2*buyButton.activeButton.size.height)
		buyButton.zPosition = 1
		selectButton.position = CGPoint(x: self.frame.midX, y: 2*selectButton.activeButton.size.height)
		selectButton.zPosition = 1
		selectedButton.position = CGPoint(x: self.frame.midX, y: 2*selectedButton.activeButton.size.height)
		selectedButton.zPosition = 1
		
		coinsLabel.fontSize = 30
		coinsLabel.position = CGPoint(x: 0.65*self.frame.size.width, y: 0.93*self.frame.size.height)
		coinsLabel.zPosition = 1
		coinsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		coinsLabel.text = "💰 \(player.coins)"
		
		bombSaveLabel.fontSize = 30
		bombSaveLabel.position = CGPoint(x: 0.65*self.frame.size.width, y: 0.88*self.frame.size.height)
		bombSaveLabel.zPosition = 1
		bombSaveLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		bombSaveLabel.text = "💣 \(player.bombSaves)"
		
		nameLabel.fontColor = UIColor.black
		nameLabel.fontSize = 20
		nameLabel.position = CGPoint(x: 0.1*self.frame.size.width, y: 0.3*self.frame.size.height)
		nameLabel.zPosition = 1
		nameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		
		descriptionLabel.fontColor = UIColor.black
		descriptionLabel.fontSize = 20
		descriptionLabel.position = CGPoint(x: 0.1*self.frame.size.width, y: 0.25*self.frame.size.height)
		descriptionLabel.zPosition = 1
		descriptionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		descriptionLabel2.fontColor = UIColor.black
		descriptionLabel2.fontSize = 20
		descriptionLabel2.position = CGPoint(x: 0.1*self.frame.size.width, y: 0.22*self.frame.size.height)
		descriptionLabel2.zPosition = 1
		descriptionLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
		
		costLabel.fontColor = UIColor.black
		costLabel.fontSize = 20
		costLabel.position = CGPoint(x: 0.1*self.frame.size.width, y: self.frame.size.height/8)
		costLabel.zPosition = 1
		costLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left

		self.addChild(background)
		self.addChild(basketButton)
		self.addChild(backgroundButton)
		self.addChild(bombButton)
		self.addChild(musicButton)
		self.addChild(leftButton)
		self.addChild(rightButton)
		self.addChild(backButton)
		self.addChild(displayedImage)
		self.addChild(buyButton)
		self.addChild(selectButton)
		self.addChild(selectedButton)
		self.addChild(coinsLabel)
		self.addChild(bombSaveLabel)
		self.addChild(descriptionLabel)
		self.addChild(descriptionLabel2)
		self.addChild(nameLabel)
		self.addChild(costLabel)
	}
	
	func handlePurchase() {
		if player.handlePurchase() {
			let buySound = SKAudioNode(fileNamed: "ShopBuy")
			buySound.isPositional = false
			buySound.autoplayLooped = false
			buySound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
			self.addChild(buySound)
			self.run(SKAction.run {
				buySound.run(SKAction.play())
			})
			if player.selectedShopCategory != .bomb {
				buyButton.isHidden = true
				selectButton.isHidden = false
			}
			coinsLabel.text = "💰 \(player.coins)"
			bombSaveLabel.text = "💣 \(player.bombSaves)"
		}
	}
	
	func handleSelection() {
		if player.selectedShopCategory == .basket {
			player.basketIndex = player.storeViewedBasket
		} else if player.selectedShopCategory == .background {
			player.backgroundIndex = player.storeViewedBackground
		} else if player.selectedShopCategory == .music {
			player.musicIndex = player.storeViewedMusic
		} else {
			print("error, player selecting a bomb")
		}
		selectButton.isHidden = true
		selectedButton.isHidden = false
	}
	
	func updateBuyUseButton() {
		buyButton.isHidden = true
		selectButton.isHidden = true
		selectedButton.isHidden = true
		switch player.selectedShopCategory {
		case .basket:
			if !player.ownsBasket(index: player.storeViewedBasket) {
				buyButton.isHidden = false
			} else if player.basketIndex != player.storeViewedBasket {
				selectButton.isHidden = false
			} else {
				selectedButton.isHidden = false
			}
		case .background:
			if !player.ownsBackground(index: player.storeViewedBackground) {
				buyButton.isHidden = false
			} else if player.backgroundIndex != player.storeViewedBackground {
				selectButton.isHidden = false
			} else {
				selectedButton.isHidden = false
			}
		case .bomb:
			buyButton.isHidden = false
		case .music:
			if !player.ownsMusic(index: player.storeViewedMusic) {
				buyButton.isHidden = false
			} else if player.musicIndex != player.storeViewedMusic {
				selectButton.isHidden = false
			} else {
				selectedButton.isHidden = false
			}
		}
	}
	
	func handleInitialClickMusic() {
		if player.selectedShopCategory == .music {
			backgroundMusic.removeFromParent()
			self.run(SKAction.wait(forDuration: 0.7), completion: {
				self.addChild(backgroundMusic)
			})
		}
	}
	
	func updateImage() {
		backgroundMusic.removeFromParent()
		descriptionLabel2.text = ""
		switch player.selectedShopCategory {
		case .basket:
			displayedImage.texture = SKTexture(imageNamed: baskets[player.storeViewedBasket].preview)
			nameLabel.text = baskets[player.storeViewedBasket].name
			if (baskets[player.storeViewedBasket].description.contains("\n")) {
				descriptionLabel.text = baskets[player.storeViewedBasket].description.components(separatedBy: "\n")[0]
				descriptionLabel2.text = baskets[player.storeViewedBasket].description.components(separatedBy: "\n")[1]
			} else {
				descriptionLabel.text = baskets[player.storeViewedBasket].description
			}
			costLabel.text = "Costs: \(baskets[player.storeViewedBasket].price)"
		case.background:
			displayedImage.texture = SKTexture(imageNamed: backgrounds[player.storeViewedBackground].preview)
			nameLabel.text = backgrounds[player.storeViewedBackground].name
			if (backgrounds[player.storeViewedBackground].description.contains("\n")) {
				descriptionLabel.text = backgrounds[player.storeViewedBackground].description.components(separatedBy: "\n")[0]
				descriptionLabel2.text = backgrounds[player.storeViewedBackground].description.components(separatedBy: "\n")[1]
			} else {
				descriptionLabel.text = backgrounds[player.storeViewedBackground].description
			}
			costLabel.text = "Costs: \(backgrounds[player.storeViewedBackground].price)"
		case.bomb:
			displayedImage.texture = SKTexture(imageNamed: misc[player.storeViewedBomb].preview)
			nameLabel.text = misc[player.storeViewedBomb].name
			if (misc[player.storeViewedBomb].description.contains("\n")) {
				descriptionLabel.text = misc[player.storeViewedBomb].description.components(separatedBy: "\n")[0]
				descriptionLabel2.text = misc[player.storeViewedBomb].description.components(separatedBy: "\n")[1]
			} else {
				descriptionLabel.text = misc[player.storeViewedBomb].description
			}
			costLabel.text = "Costs: \(misc[player.storeViewedBomb].price)"
		case .music:
			displayedImage.texture = SKTexture(imageNamed: music[player.storeViewedMusic].preview)
			nameLabel.text = music[player.storeViewedMusic].name
			if (music[player.storeViewedMusic].description.contains("\n")) {
				descriptionLabel.text = music[player.storeViewedMusic].description.components(separatedBy: "\n")[0]
				descriptionLabel2.text = music[player.storeViewedMusic].description.components(separatedBy: "\n")[1]
			} else {
				descriptionLabel.text = music[player.storeViewedMusic].description
			}
			costLabel.text = "Costs: \(music[player.storeViewedMusic].price)"
			backgroundMusic = SKAudioNode(fileNamed: music[player.storeViewedMusic].image)
			self.addChild(backgroundMusic)
		}
	}
	
	func indexSelection() {
		leftButton.clickable = true
		rightButton.clickable = true
		switch player.selectedShopCategory {
		case .basket:
			if player.storeViewedBasket == 0 {
				leftButton.clickable = false
			}
			if player.storeViewedBasket == numBaskets - 1 {
				rightButton.clickable = false
			}
		case .background:
			if player.storeViewedBackground == 0 {
				leftButton.clickable = false
			}
			if player.storeViewedBackground == numBackgrounds - 1 {
				rightButton.clickable = false
			}
		case .bomb:
			if player.storeViewedBomb == 0 {
				leftButton.clickable = false
			}
			if player.storeViewedBomb == numBombs - 1 {
				rightButton.clickable = false
			}
		case .music:
			if player.storeViewedMusic == 0 {
				leftButton.clickable = false
			}
			if player.storeViewedMusic == numMusic - 1 {
				rightButton.clickable = false
			}
		}
		updateImage()
		updateBuyUseButton()
	}
	
	func moveRight() {
		switch player.selectedShopCategory {
		case .basket:
			if player.storeViewedBasket == numBaskets - 1 {
				return
			}
			player.storeViewedBasket += 1
		case .background:
			if player.storeViewedBackground == numBackgrounds - 1 {
				return
			}
			player.storeViewedBackground += 1
		case .bomb:
			if player.storeViewedBomb == numBombs - 1 {
				return
			}
			player.storeViewedBomb += 1
		case .music:
			if player.storeViewedMusic == numMusic - 1 {
				return
			}
			player.storeViewedMusic += 1
		}
		indexSelection()
	}
	
	func moveLeft() {
		switch player.selectedShopCategory {
		case .basket:
			if player.storeViewedBasket == 0 {
				return
			}
			player.storeViewedBasket -= 1
		case .background:
			if player.storeViewedBackground == 0 {
				return
			}
			player.storeViewedBackground -= 1
		case .bomb:
			if player.storeViewedBomb == 0 {
				return
			}
			player.storeViewedBomb -= 1
		case .music:
			if player.storeViewedMusic == 0 {
				return
			}
			player.storeViewedMusic -= 1
		}
		indexSelection()
	}
	
	func categorySelection() {
		basketButton.toggleOff()
		backgroundButton.toggleOff()
		bombButton.toggleOff()
		musicButton.toggleOff()
		switch player.selectedShopCategory {
		case .basket:
			basketButton.toggleOn()
		case .background:
			backgroundButton.toggleOn()
		case .bomb:
			bombButton.toggleOn()
		case .music:
			musicButton.toggleOn()
		}
		indexSelection()
	}
	
	func selectMusicCategory() {
		player.selectedShopCategory = .music
		categorySelection()
	}
	
	func selectBasketCategory() {
		player.selectedShopCategory = .basket
		categorySelection()
	}
	
	func selectBackgroundCategory() {
		player.selectedShopCategory = .background
		categorySelection()
	}
	
	func selectBombCategory() {
		player.selectedShopCategory = .bomb
		categorySelection()
	}
	
	func goToStartScene() {
		let scene = StartScene(size: view!.bounds.size)
		self.scene?.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.5))
	}
}
