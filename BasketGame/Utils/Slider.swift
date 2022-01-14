//
//  Slider.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

class Slider: UISlider {
	override func trackRect(forBounds bounds: CGRect) -> CGRect {
		var result = super.trackRect(forBounds: bounds)
		result.size.height *= 5
		return result
	}
}
