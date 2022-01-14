//
//  FallingObject.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class FallingObject : SKSpriteNode {
	var value : Int
	
	init(imageNamed: String, value: Int) {
		self.value = value
		let texture = SKTexture(imageNamed: imageNamed)
		super.init(texture: texture, color: UIColor.clear, size: texture.size())
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

func determineObject() -> FallingObject {
	let rand = random()
	if rand < bombChance {
		return FallingObject(imageNamed: "Bomb", value: 0)
	} else if rand < jewelChance {
		return FallingObject(imageNamed: randomJewel(), value: 2)
	} else {
		return FallingObject(imageNamed: randomFruit(), value: 1)
	}
}

func randomJewel() -> String {
	let val = random(min: 0, max: 4)
	switch Int(val) {
	case 0:
		return "Amethyst"
	case 1:
		return "Coin"
	case 2:
		return "Diamond"
	case 3:
		return "Ruby"
	default:
		print("Invalid falling object of \(val)")
		return ""
	}
}

func randomFruit() -> String {
	let val = random(min: 0, max: 4)
	switch Int(val) {
	case 0:
		return "Banana"
	case 1:
		return "BlueBall"
	case 2:
		return "Grape"
	case 3:
		return "Apple"
	default:
		print("Invalid falling object of \(val)")
		return ""
	}
}
