//
//  InAppButton.swift
//  digger
//
//  Created by toha on 06.03.2021.
//

import SpriteKit

class InAppButton: UIButton {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        SoundManager.sharedInstance.play(sound: .select)
//        super.touchesBegan(touches, with: event)
//    }
}

extension SKLabelNode {
    
    func addStroke(color: UIColor = .black, width: CGFloat = 2) {
        if #available(iOS 11.0, *) {
            guard let labelText = self.text else { return }
            
            let font = UIFont(name: self.fontName!, size: self.fontSize)
            
            let attributedString:NSMutableAttributedString
            if let labelAttributedText = self.attributedText {
                attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
            } else {
                attributedString = NSMutableAttributedString(string: labelText)
            }
            
            let attributes:[NSAttributedString.Key:Any] = [.strokeColor: color, .strokeWidth: -width, .font: font!, .foregroundColor: self.fontColor!]
            attributedString.addAttributes(attributes, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        } else {
            // Fallback on earlier versions
        }
    }

}


func threeTwoOneGo(node: SKNode, completion: (() -> Void)?) {
    
    let startLabel = SKLabelNode()
    startLabel.position = .init(x: node.frame.midX, y: node.frame.midY)
    startLabel.text = "3"
    startLabel.zPosition = 100
    startLabel.horizontalAlignmentMode = .center
    startLabel.verticalAlignmentMode = .center
    startLabel.fontSize = 128
//    startLabel.fontName = "a_MachinaOrtoSls-Bold"
    startLabel.fontColor = .normlabel
    node.addChild(startLabel)
    
    let seq = SKAction.sequence([
        .wait(forDuration: 0.5),
        .run { startLabel.text = "3" },
        .wait(forDuration: 1),
        .run { startLabel.text = "2" },
        .wait(forDuration: 1),
        .run { startLabel.text = "1" },
        .wait(forDuration: 1),
        .removeFromParent()
    ])
    startLabel.run(seq) {
        completion?()
    }
}
