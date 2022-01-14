//
//  Player.swift
//  BasketGame
//
//  Created by Jake on 5/17/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import SpriteKit

let player = Player()

public class Player {
	public var selectedShopCategory = StoreCategory.basket {
		didSet { UserDefaults.standard.set(selectedShopCategory.rawValue, forKey: "selectedShopCategory") }
	}
	
	public var basketIndex = 0 {
		didSet { UserDefaults.standard.set(basketIndex, forKey: "basketIndex") }
	}
	public var backgroundIndex = 0 {
		didSet { UserDefaults.standard.set(backgroundIndex, forKey: "backgroundIndex") }
	}
	public var musicIndex = 0 {
		didSet { UserDefaults.standard.set(musicIndex, forKey: "musicIndex") }
	}
	
	public var storeViewedBasket = 0 {
		didSet { UserDefaults.standard.set(storeViewedBasket, forKey: "storeViewedBasket") }
	}
	public var storeViewedBackground = 0 {
		didSet { UserDefaults.standard.set(storeViewedBackground, forKey: "storeViewedBackground") }
	}
	public var storeViewedBomb = 0 {
		didSet { UserDefaults.standard.set(storeViewedBomb, forKey: "storeViewedBomb") }
	}
	public var storeViewedMusic = 0 {
		didSet { UserDefaults.standard.set(storeViewedMusic, forKey: "storeViewedMusic") }
	}
	
	public var musicVolume: Float = 1.0 {
		didSet {
			backgroundMusic.run(SKAction.changeVolume(to: musicVolume, duration: 0))
			UserDefaults.standard.set(musicVolume, forKey: "musicVolume")
		}
	}
	public var sfxVolume: Float = 1.0 {
		didSet { UserDefaults.standard.set(sfxVolume, forKey: "sfxVolume") }
	}
	
	var maxScore = 0 {
		didSet { UserDefaults.standard.set(maxScore, forKey: "maxScore") }
	}
	var bestTime = 0 {
		didSet { UserDefaults.standard.set(bestTime, forKey: "bestTime") }
	}
	
	var coins = 4000  {
		didSet { UserDefaults.standard.set(coins, forKey: "coins") }
	}
	var bombSaves = 0 {
		didSet { UserDefaults.standard.set(bombSaves, forKey: "bombSaves") }
	}
	
	var ownedBaskets = [0] {
		didSet { UserDefaults.standard.set(ownedBaskets, forKey: "ownedBaskets") }
	}
	var ownedBackgrounds = [0] {
		didSet { UserDefaults.standard.set(ownedBackgrounds, forKey: "ownedBackgrounds") }
	}
	var ownedMusic = [0] {
		didSet { UserDefaults.standard.set(ownedMusic, forKey: "ownedMusic") }
	}
	
	func setMaxScore(score: Int) -> Bool {
		if score > maxScore {
			maxScore = score
			return true
		}
		return false
	}
	
	func loadData() {
		selectedShopCategory = StoreCategory(rawValue: UserDefaults.standard.object(forKey: "selectedShopCategory") as? StoreCategory.RawValue ?? selectedShopCategory.rawValue)!
		
		basketIndex = UserDefaults.standard.object(forKey: "basketIndex") as? Int ?? basketIndex
		backgroundIndex = UserDefaults.standard.object(forKey: "backgroundIndex") as? Int ?? backgroundIndex
		musicIndex = UserDefaults.standard.object(forKey: "musicIndex") as? Int ?? musicIndex
		
		storeViewedBasket = UserDefaults.standard.object(forKey: "storeViewedBasket") as? Int ?? storeViewedBasket
		storeViewedBackground = UserDefaults.standard.object(forKey: "storeViewedBackground") as? Int ?? storeViewedBackground
		storeViewedBomb = UserDefaults.standard.object(forKey: "storeViewedBomb") as? Int ?? storeViewedBomb
		storeViewedMusic = UserDefaults.standard.object(forKey: "storeViewedMusic") as? Int ?? storeViewedMusic
		
		musicVolume = UserDefaults.standard.object(forKey: "musicVolume") as? Float ?? musicVolume
		sfxVolume = UserDefaults.standard.object(forKey: "sfxVolume") as? Float ?? sfxVolume
		
		maxScore = UserDefaults.standard.object(forKey: "maxScore") as? Int ?? maxScore
		bestTime = UserDefaults.standard.object(forKey: "bestTime") as? Int ?? bestTime
		
		coins = UserDefaults.standard.object(forKey: "coins") as? Int ?? coins
		bombSaves = UserDefaults.standard.object(forKey: "bombSaves") as? Int ?? bombSaves
		
		ownedBaskets = UserDefaults.standard.object(forKey: "ownedBaskets") as? [Int] ?? ownedBaskets
		ownedBackgrounds = UserDefaults.standard.object(forKey: "ownedBackgrounds") as? [Int] ?? ownedBackgrounds
		ownedMusic = UserDefaults.standard.object(forKey: "ownedMusic") as? [Int] ?? ownedMusic
	}
	
	func ownsBasket(index : Int) -> Bool {
		return ownedBaskets.contains(index)
	}
	
	func ownsBackground(index : Int) -> Bool {
		return ownedBackgrounds.contains(index)
	}
	
	func ownsMusic(index : Int) -> Bool {
		return ownedMusic.contains(index)
	}
	
	func handlePurchase() -> Bool {
		switch selectedShopCategory {
		case .basket:
			let item = baskets[storeViewedBasket]
			if coins < item.price {
				return false
			}
			ownedBaskets.append(storeViewedBasket)
			coins -= item.price
		case .background:
			let item = backgrounds[storeViewedBackground]
			if coins < item.price {
				return false
			}
			ownedBackgrounds.append(storeViewedBackground)
			coins -= item.price
		case .bomb:
			let item = misc[storeViewedBomb]
			if coins < item.price {
				return false
			}
			bombSaves += 1
			coins -= item.price
		case .music:
			let item = music[storeViewedMusic]
			if coins < item.price {
				return false
			}
			ownedMusic.append(storeViewedMusic)
			coins -= item.price
		}
		return true
	}
}
