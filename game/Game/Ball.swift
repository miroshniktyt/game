//
//  Ball.swift
//  Wild Wolf Quest
//
//  Created by Amour Feel on 21/01/2021.
//

import SpriteKit

class Ball: SKShapeNode {
    
    var backColor: UIColor {
        let color = Settings.shared.colorsMode.color
        return color
    }
    
    let treasure: SKNode
    
    init(size: CGSize, systemName: String) {
        let treasureTexure = SKTexture(systemName: systemName, color: Settings.shared.colorsMode.color)
        let aspect = treasureTexure.size().width / treasureTexure.size().height
        let height = size.width * 0.75
        let isHeigh = aspect > 1
        let treasureHeight = !isHeigh ? height : height / aspect
        let treasureWidth = !isHeigh ? height * aspect : height
        let treasureSize = CGSize(width: treasureWidth, height: treasureHeight)
        self.treasure = SKSpriteNode(texture: treasureTexure, color: .clear, size: treasureSize)
        treasure.zPosition = 10
        
        super.init()
        let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
        self.path = UIBezierPath(roundedRect: rect, cornerRadius: size.height / 2).cgPath
        self.lineWidth = 0.1
        
        self.name = systemName
        setBody()
        treasure.isHidden = true
        self.addChild(treasure)
        
        self.fillColor = .gray.withAlphaComponent(0.25)
        self.strokeColor = backColor
    }
    
    func setBody() {
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width / 2)
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass = 1
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 0.6
        self.physicsBody?.categoryBitMask = ballCategory
        self.physicsBody?.contactTestBitMask = worldCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isOpened: Bool = false {
        didSet {
            self.fillColor = isOpened ? .gray.withAlphaComponent(0.25) : backColor.withAlphaComponent(0.5)
            treasure.isHidden = !isOpened
        }
    }
    
    func explode() {
        
        if let particles = SKEmitterNode(fileNamed: "exp") {
            particles.position = self.position
            if let parent = self.parent {
                parent.addChild(particles)
            }

            let removeAfterDead = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()])
            particles.run(removeAfterDead)
        }
        
        self.isHidden = true
    }
}

class AimItemNode: SKNode {

    let aimItem: Ball
    
    init(aimItemName: String) {
        let itemHeight: CGFloat = 40
        aimItem = Ball(size: .init(width: itemHeight, height: itemHeight), systemName: aimItemName)
        aimItem.isOpened = true
        aimItem.physicsBody = nil
        
        super.init()
        
        let label = InAppSKLabel()
        label.fontSize = 16
        label.text = "AIM ITEM : "
        label.color = .normlabel
        label.verticalAlignmentMode = .center
        label.zPosition = 10
        
        let width = 8 + aimItem.frame.width + label.frame.width
        label.position.x = -width / 2 + label.frame.width / 2
        aimItem.position.x = width / 2 - aimItem.frame.width / 2
        aimItem.zPosition = 10
        
        let bfSize = CGSize(width: width + 32, height: itemHeight + 16)
        let bg = SKShapeNode(rectOf: bfSize, cornerRadius: 16)
        bg.fillColor = .normlabel.withAlphaComponent(0.2) //Settings.shared.colorsMode.color
        bg.strokeColor = .clear //Settings.shared.colorsMode.color
        
        self.addChild(label)
        self.addChild(bg)
        self.addChild(aimItem)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InAppSKLabel: SKLabelNode {
    
    let weight: UIFont.Weight
    
    init(weight: UIFont.Weight = .regular) {
        self.weight = weight
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String? {
        didSet {
            let font = UIFont.systemFont(ofSize: self.fontSize, weight: weight)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            self.attributedText = NSAttributedString(string: self.text ?? "", attributes: [
                .font: font,
                .foregroundColor: self.fontColor,
                .paragraphStyle: paragraphStyle
            ])
        }
    }
}
