//
//  TapToStart.swift
//  MayanDiamonds
//
//  Created by 1 on 22.03.2022.
//

import SpriteKit

class TapToStartNode: SKSpriteNode {
    
    let complition: (() -> ())
    
    init(info: String, scene: SKScene, complition: @escaping () -> ()) {
        
        self.complition = complition
        
        super.init(texture: nil, color: .clear, size: scene.size)
            
        self.anchorPoint = .init(x: 0, y: 0.5)
        scene.addChild(self)
        
//        let startLabel = SKLabelNode()
        let startLabel = InAppSKLabel(weight: .regular)
        startLabel.fontSize = 16
        startLabel.position.y = 32
        startLabel.zPosition = 100
        startLabel.fontName = inAppFont
        startLabel.fontColor = .normlabel
        startLabel.horizontalAlignmentMode = .center
        startLabel.verticalAlignmentMode = .bottom
        startLabel.text = "TAP   ANYWEAR   TO   START"
        startLabel.run(.repeatForever(.sequence([
            .scale(to: 0.9, duration: 1),
            .scale(to: 1, duration: 1),
        ])))
        self.addChild(startLabel)
        
//        let aboutLabel = SKLabelNode()
        let aboutLabel = InAppSKLabel(weight: .regular)
        aboutLabel.fontSize = 16
        aboutLabel.position.y = frame.height - 32
        aboutLabel.zPosition = 100
        aboutLabel.fontColor = .normlabel.withAlphaComponent(0.6)
        aboutLabel.fontName = inAppFont
        aboutLabel.horizontalAlignmentMode = .center
        aboutLabel.verticalAlignmentMode = .top
        aboutLabel.numberOfLines = 0
        aboutLabel.preferredMaxLayoutWidth = scene.frame.width - 32
//        aboutLabel.text = "HOW TO PLAY:\n\n" + info
        aboutLabel.text = info

        self.addChild(aboutLabel)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.complition()
        self.removeFromParent()
    }
}
