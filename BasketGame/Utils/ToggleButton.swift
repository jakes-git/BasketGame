//
//  ToggleButton.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class ToggleButton: SKNode {
	var offButton: SKSpriteNode
	var onButton: SKSpriteNode
	var action: () -> Void
	
	let clickDown = SKAudioNode(fileNamed: "ButtonClick1")
	let clickUp = SKAudioNode(fileNamed: "ButtonClick2")
	
	init(offButtonImage: String, onButtonImage: String, buttonAction: @escaping () -> Void) {
		offButton = SKSpriteNode(imageNamed: offButtonImage)
		onButton = SKSpriteNode(imageNamed: onButtonImage)
		onButton.isHidden = true
		action = buttonAction
		
		super.init()
		
		isUserInteractionEnabled = true
		addChild(offButton)
		addChild(onButton)
		clickDown.autoplayLooped = false
		clickUp.autoplayLooped = false
		clickDown.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		clickUp.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		addChild(clickDown)
		addChild(clickUp)
	}
	
	func toggleOn() {
		offButton.isHidden = true
		onButton.isHidden = false
		run(SKAction.run {
			self.clickDown.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
			self.clickDown.run(SKAction.play())
		})
	}
	
	func toggleOff() {
		offButton.isHidden = false
		onButton.isHidden = true
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			if onButton.contains(touch.location(in: self)) {
				action()
				run(SKAction.run {
					self.clickUp.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
					self.clickUp.run(SKAction.play())
				})
			}
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
