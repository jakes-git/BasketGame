//
//  Button.swift
//  BasketGame
//
//  Created by Jake on 4/27/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class Button: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
	var clickable = true {
		didSet {
			if clickable {
				activeButton.isHidden = true
				defaultButton.isHidden = false
			} else {
				activeButton.isHidden = false
				defaultButton.isHidden = true
			}
		}
	}
	
	let clickDown = SKAudioNode(fileNamed: "ButtonClick1")
	let clickUp = SKAudioNode(fileNamed: "ButtonClick2")
	
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: @escaping () -> Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.isHidden = true
        action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
		clickDown.autoplayLooped = false
		clickUp.autoplayLooped = false
		clickDown.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		clickUp.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
		clickUp.isPositional = false
		clickDown.isPositional = false
		addChild(clickDown)
		addChild(clickUp)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		activeButton.isHidden = false
		defaultButton.isHidden = true
		if clickable {
			run(SKAction.run {
				self.clickDown.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
				self.clickDown.run(SKAction.play())
			})
		}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if defaultButton.contains(touch.location(in: self)) {
                activeButton.isHidden = false
                defaultButton.isHidden = true
            } else {
				if clickable {
                	activeButton.isHidden = true
                	defaultButton.isHidden = false
				}
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if defaultButton.contains(touch.location(in: self)) {
               action()
            }
			if clickable {
            	activeButton.isHidden = true
            	defaultButton.isHidden = false
				run(SKAction.run {
					self.clickUp.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
					self.clickUp.run(SKAction.play())
				})
			}
        }
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
