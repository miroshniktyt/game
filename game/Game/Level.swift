//
//  Level.swift
//  game
//
//  Created by toha on 16.06.2021.
//

import Foundation
import UIKit
import SpriteKit

let planets = ["planetGreen", "planetYellow", "planetPurple"]
let allStars = ["starBlue", "starGreen", "starRed", "starPurple", "starYellow", "starOrange"]
let rockets = ["rocketOrange", "rocketPurple", "rocketGreen"]
var stars: [String] { Array(allStars[0...2]) }

var allItemNames: [String] {
    let a = [1, 2, 3, 4, 5]
    let na = a.map { "item\($0)" }
    return na
}

let itemBG = "itemBG"
let itemBG2 = "frame"
let itemBGSelected = "itemBGSelected"

let inAppFont = "Copperplate"

extension UIColor {
    static var main: UIColor {
        return .systemBackground
    }
}

extension UIColor {
    static var accent: UIColor {
        return Settings.shared.colorsMode.color
    }
}

class InAppBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commInit()
    }
    
    func setSecondary() {
        self.backgroundColor = .clear
        self.setTitleColor(.accent, for: .normal)
    }
    
    func commInit() {
        self.backgroundColor = UIColor.accent
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.layer.cornerRadius = 8
        self.setTitleColor(.main, for: .normal)
        self.titleLabel?.font = .init(name: inAppFont, size: 16)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commInit()
    }
}

func printAllFonts() {
    for family in UIFont.familyNames {
        print(family)
        for names: String in UIFont.fontNames(forFamilyName: family) {
            print("== \(names)")
        }
    }
}

class Level {
    
    let key = "LEVEL"
    static let shared = Level()
    
    var level: Int {
        get {
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            guard newValue > 0 else {
                return
            }
            
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: [key : 1])
    }
}

extension UIButton {
    static var inApp: UIButton {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.orange, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .black)
        return btn
    }
}
