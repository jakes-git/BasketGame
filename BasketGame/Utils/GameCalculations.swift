//
//  GameCalculations.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
	static let all      : UInt32 = UInt32.max
	static let none     : UInt32 = 0b0
	static let object   : UInt32 = 0b1
	static let basket   : UInt32 = 0b10
	static let edge		: UInt32 = 0b11
}

var backgroundMusic = SKAudioNode(fileNamed: music[player.musicIndex].image) {
	didSet {
		backgroundMusic.isPositional = false
		backgroundMusic.run(SKAction.changeVolume(to: player.musicVolume, duration: 0))
	}
}

var maxHealth = 5.0
var health = 5.0


let gravity = CGVector(dx: 0, dy: -2)
let difficulty: CGFloat = 0.03
var edgeTolerance: CGFloat = 0.25
var spawnTime: CGFloat = 1.0
var minDY: CGFloat = -600
var maxDY: CGFloat = -300
let bombChance: CGFloat = 0.15
let jewelChance: CGFloat = 0.25

func random() -> CGFloat {
	return CGFloat.random(in: 0...1)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
	return CGFloat.random(in: min...max)
}
