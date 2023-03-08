//
//  Theme.swift
//  MayanDiamonds
//
//  Created by 1 on 20.03.2022.
//

import Foundation
import SpriteKit
 
enum ThemeType: Int {
    
    case transport, nature, shapes
    
    var textureNames: [String] {
        switch self {
        case .transport:
            return ["car.fill", "train.side.front.car", "tram.fill", "ferry.fill", "bicycle", "airplane", "scooter"]
        case .nature:
            return ["drop.fill", "bolt.fill", "tortoise.fill", "ant.fill", "leaf.fill", "pawprint.circle.fill", "ladybug.fill"]
        case .shapes:
            return ["circle.fill", "square.fill", "triangle.fill", "hexagon.fill", "seal.fill", "pentagon.fill", "rhombus.fill"]
        }
    }
    
}

enum ColorsType: Int {
    case warm, cold, grey
    
    var colors: [UIColor] {
        switch self {
        case .warm:
            return [
                .init(named: "red0")!,
                .init(named: "red1")!,
                .init(named: "red2")!,
            ]
        case .cold:
            return [
                .init(named: "blue0")!,
                .init(named: "blue1")!,
                .init(named: "blue2")!,
            ]
        case .grey:
            return [
                .init(named: "green0")!,
                .init(named: "green1")!,
                .init(named: "green2")!,
            ]
        }
    }
    
    var color: UIColor {
        switch self {
        case .warm:
            return .systemBlue
        case .cold:
            return .systemRed
        case .grey:
            return .systemGreen
        }
    }
}

class Settings {
    
    static let shared = Settings()
    
    var darkMode: UIUserInterfaceStyle {
        get {
            let int = UserDefaults.standard.integer(forKey: "darkModeType")
            return UIUserInterfaceStyle.init(rawValue: int)!
        }
        set {
            let int = newValue.rawValue
            UserDefaults.standard.set(int, forKey: "darkModeType")
            setDarkMode()
        }
    }
    
    var themeType: ThemeType {
        get {
            let int = UserDefaults.standard.integer(forKey: "themeType")
            return ThemeType.init(rawValue: int)!
        }
        set {
            let int = newValue.rawValue
            UserDefaults.standard.set(int, forKey: "themeType")
        }
    }
    
    var colorsMode: ColorsType {
        get {
            let int = UserDefaults.standard.integer(forKey: "colorsMode")
            return ColorsType.init(rawValue: int)!
        }
        set {
            let int = newValue.rawValue
            UserDefaults.standard.set(int, forKey: "colorsMode")
        }
    }
    
    var music: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "music")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "music")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["darkModeType" : 2])
        UserDefaults.standard.register(defaults: ["themeType" : 0])
        UserDefaults.standard.register(defaults: ["colorsMode" : 0])
        UserDefaults.standard.register(defaults: ["music" : true])
    }
    
    func setDarkMode() {
        let style = Settings.shared.darkMode
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = style
        }
    }
}


extension SKTexture {
    convenience init(systemName: String, color: UIColor = .white) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 256, weight: .bold, scale: .large)
        let image = UIImage(systemName: systemName, withConfiguration: largeConfig)!.withTintColor(color)
        let data = image.pngData()
        let newImage = UIImage(data: data!)!
        self.init(image: newImage)
    }
}

extension UIColor {
    var hexString: String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
