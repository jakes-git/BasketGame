//
//  PauseLayer.swift
//  BasketGame
//
//  Created by Jake on 4/27/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class PauseLayer : SKNode {
    
    let pauseScene = SKScene()
    var parentScene : SKScene
    
    init(parentScene : SKScene) {
        self.parentScene = parentScene
        super.init()
        let background = SKSpriteNode(imageNamed: "PauseMenu")
        background.position = CGPoint(x: parentScene.frame.midX, y: parentScene.frame.midY)
        addChild(background)
        
        
        let menuButton = Button(defaultButtonImage: "MenuButton", activeButtonImage: "MenuButtonPushed", buttonAction: goToStartScene)
        let bSize = menuButton.activeButton.size.height
        menuButton.position = CGPoint(x: parentScene.frame.midX,
                                      y: parentScene.frame.midY - background.size.height/2 + bSize*0.65)
        menuButton.zPosition = background.zPosition + 1
        
        let optionsButton = Button(defaultButtonImage: "PauseMenuOptionsButton", activeButtonImage: "PauseMenuOptionsButtonPushed", buttonAction: goToOptionsScene)
        optionsButton.position = CGPoint(x: parentScene.frame.midX, y: menuButton.position.y + 1.15*bSize)
        optionsButton.zPosition = background.zPosition + 1
        
        
        addChild(optionsButton)
        addChild(menuButton)
    }
    
    func goToStartScene() {
        let scene = StartScene(size: parentScene.view!.bounds.size)
        self.scene?.view?.presentScene(scene, transition: .crossFade(withDuration: 1.0))
    }
    
    func goToOptionsScene() {
		if let scene = parentScene as? GameScene {
			scene.displayOptionsScene()
		}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
