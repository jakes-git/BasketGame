//
//  HeartTextDisplay.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import Foundation

func getLifeString(health : Double) -> String {
	switch health {
	case 5.0: return "❤️❤️❤️❤️❤️"
	case 4.5: return "❤️❤️❤️❤️💔"
	case 4.0: return "❤️❤️❤️❤️🖤"
	case 3.5: return "❤️❤️❤️💔🖤"
	case 3.0: return "❤️❤️❤️🖤🖤"
	case 2.5: return "❤️❤️💔🖤🖤"
	case 2.0: return "❤️❤️🖤🖤🖤"
	case 1.5: return "❤️💔🖤🖤🖤"
	case 1.0: return "❤️🖤🖤🖤🖤"
	case 0.5: return "💔🖤🖤🖤🖤"
	default: return "🖤🖤🖤🖤🖤"
	}
}
