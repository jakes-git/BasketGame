//
//  GameData.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import Foundation

public enum StoreCategory : Int {
	case basket = 0, background = 1 , bomb = 2, music = 3
}

var baskets : [ShopItem] = []
var backgrounds : [ShopItem] = []
var misc : [ShopItem] = []
var music : [ShopItem] = []
var numBaskets = 0
var numBackgrounds = 0
var numBombs = 0
var numMusic = 0

func loadData() {
	guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
		return
	}
	do {
		let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
		let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
		guard let result = jsonResult as? [String : NSArray], let basketData = result["baskets"], let backgroundData = result["backgrounds"], let miscData = result["misc"], let musicData = result["music"] else {
				return
		}
		for data in basketData {
			if let data = data as? [String : Any], let name = data["name"] as? String, let desc = data["description"] as? String, let image = data["image"] as? String, let preview = data["preview"] as? String, let price = data["price"] as? Int {
				baskets.append(ShopItem(name: name, description: desc, image: image, preview: preview, price: price))
			}
		}
		for data in backgroundData {
			if let data = data as? [String : Any], let name = data["name"] as? String, let desc = data["description"] as? String, let image = data["image"] as? String, let preview = data["preview"] as? String, let price = data["price"] as? Int {
				backgrounds.append(ShopItem(name: name, description: desc, image: image, preview: preview, price: price))
			}
		}
		for data in miscData {
			if let data = data as? [String : Any], let name = data["name"] as? String, let desc = data["description"] as? String, let image = data["image"] as? String, let preview = data["preview"] as? String, let price = data["price"] as? Int {
				misc.append(ShopItem(name: name, description: desc, image: image, preview: preview, price: price))
			}
		}
		for data in musicData {
			if let data = data as? [String : Any], let name = data["name"] as? String, let desc = data["description"] as? String, let image = data["image"] as? String, let preview = data["preview"] as? String, let price = data["price"] as? Int {
				music.append(ShopItem(name: name, description: desc, image: image, preview: preview, price: price))
			}
		}
		numBaskets = baskets.count
		numBackgrounds = backgrounds.count
		numBombs = misc.count
		numMusic = music.count
	} catch {
		print("error loading gamedata")
	}
}
