//
//  GameOverScene.swift
//  BasketGame
//
//  Created by Jake on 4/27/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
	
	let scoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let highscoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.red
		
		let gameOverLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		gameOverLabel.text = "Game Over"
		gameOverLabel.fontColor = UIColor.white
		gameOverLabel.fontSize = 60
		gameOverLabel.position = CGPoint(x: frame.midX, y: 0.8*self.frame.size.height)
		gameOverLabel.zPosition = 1
		gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
		
		highscoreLabel.fontSize = 30
		highscoreLabel.fontColor = UIColor.white
		highscoreLabel.position = CGPoint(x: frame.midX, y: 0.5*self.frame.size.height)
		highscoreLabel.zPosition = 1
		highscoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
		highscoreLabel.numberOfLines = 2
		
		scoreLabel.fontSize = 30
		scoreLabel.fontColor = UIColor.white
		scoreLabel.position = CGPoint(x: frame.midX, y: 0.3*self.frame.size.height)
		scoreLabel.zPosition = 1
		scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
		
//		let dyingSound = SKAudioNode(fileNamed: "DyingNoise")
//		dyingSound.autoplayLooped = false
//		dyingSound.isPositional = false
//		dyingSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
//		run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run({
//			dyingSound.run(SKAction.changeVolume(to: player.sfxVolume, duration: 0))
//			dyingSound.run(SKAction.play())
//		})]))
		
		addChild(gameOverLabel)
		addChild(scoreLabel)
		addChild(highscoreLabel)
//		addChild(dyingSound)
    }
	
	func setScore(score : Int) {
		scoreLabel.text = "You earned \(score) coins!"
		highscoreLabel.text = "Your highscore: \(player.maxScore)"
	}
	
	func newHighScore() {
		highscoreLabel.text = "New HighScore!\nYour highscore: \(player.maxScore)"
	}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = StartScene(size: view!.bounds.size)
        //scene.scaleMode = .aspectFill
        self.scene?.view?.presentScene(scene, transition: .crossFade(withDuration: 1.0))
    }
    
}
