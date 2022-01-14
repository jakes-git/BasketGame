//
//  OptionsLayer.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class OptionsLayer : SKNode {
	
	let optionsScene = SKScene()
	var parentScene : SKScene
	
	var volumeSlider : Slider
	var sfxSlider : Slider
	
	let musicVolumeLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	let sfxVolumeLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
	
	init(parentScene : SKScene) {
		self.parentScene = parentScene
		
		let background = SKSpriteNode(imageNamed: "OptionsMenu")
		background.position = CGPoint(x: parentScene.frame.midX, y: parentScene.frame.midY)
		background.zPosition = parentScene.zPosition + 1
		
		volumeSlider = Slider(frame: CGRect(x: background.position.x - background.size.width/3, y: 0.75*background.position.y, width: 2*background.size.width/3, height: 20))
		sfxSlider = Slider(frame: CGRect(x: background.position.x - background.size.width/3, y: 1.05*background.position.y, width: 2*background.size.width/3, height: 20))
		
		super.init()
		
		addChild(background)
		
		let saveButton = Button(defaultButtonImage: "OptionsMenuSaveButton", activeButtonImage: "OptionsMenuSaveButtonPushed", buttonAction: removeElements)
		saveButton.position = CGPoint(x: parentScene.frame.midX, y: parentScene.frame.midY - background.size.height/2 + saveButton.activeButton.size.height)
		saveButton.zPosition = background.zPosition + 1
		addChild(saveButton)
		
		
		musicVolumeLabel.fontColor = UIColor.black
		musicVolumeLabel.fontSize = 20
		musicVolumeLabel.position = CGPoint(x: background.position.x, y: 1.45*volumeSlider.layer.position.y)
		musicVolumeLabel.zPosition = saveButton.zPosition
		musicVolumeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
		musicVolumeLabel.text = "Music Volume: \(Int(player.musicVolume*11))"
		addChild(musicVolumeLabel)
		
		sfxVolumeLabel.fontColor = UIColor.black
		sfxVolumeLabel.fontSize = 20
		sfxVolumeLabel.position = CGPoint(x: background.position.x, y: 0.77*sfxSlider.layer.position.y)
		sfxVolumeLabel.zPosition = saveButton.zPosition
		sfxVolumeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
		sfxVolumeLabel.text = "SFX Volume: \(Int(player.sfxVolume*11))"
		addChild(sfxVolumeLabel)
		
		volumeSlider.minimumValue = 0
		volumeSlider.maximumValue = 1
		volumeSlider.isContinuous = true
		volumeSlider.minimumTrackTintColor = UIColor.blue
		volumeSlider.maximumTrackTintColor = UIColor.brown
		volumeSlider.thumbTintColor = UIColor.cyan
		volumeSlider.value = player.musicVolume
		volumeSlider.addTarget(self, action: #selector(updateMusicVolume), for: .valueChanged)
		
		sfxSlider.minimumValue = 0
		sfxSlider.maximumValue = 1
		sfxSlider.isContinuous = true
		sfxSlider.minimumTrackTintColor = UIColor.blue
		sfxSlider.maximumTrackTintColor = UIColor.brown
		sfxSlider.thumbTintColor = UIColor.cyan
		sfxSlider.value = player.sfxVolume
		sfxSlider.addTarget(self, action: #selector(updateSFXVolume), for: .valueChanged)
	}
	
	func present() {
		parentScene.view?.addSubview(volumeSlider)
		parentScene.view?.addSubview(sfxSlider)
	}
	
	func removeElements() {
		optionsScene.removeAllChildren()
		optionsScene.removeFromParent()
		volumeSlider.removeFromSuperview()
		sfxSlider.removeFromSuperview()
		if let scene = parentScene as? StartScene {
			scene.optionsSaved()
		} else if let scene = parentScene as? GameScene {
			scene.optionsSaved()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func updateMusicVolume() {
		player.musicVolume = volumeSlider.value
		musicVolumeLabel.text = "Music Volume: \(Int(player.musicVolume*11))"
	}
	
	@objc func updateSFXVolume() {
		player.sfxVolume = sfxSlider.value
		sfxVolumeLabel.text = "SFX Volume: \(Int(player.sfxVolume*11))"
	}

}

