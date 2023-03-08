//
//  PreviewScene.swift
//  MayanDiamonds
//
//  Created by 1 on 21.03.2022.
//

import SpriteKit

class PreviewScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.setupNewGame()
    }
    
    func setupNewGame() {
        
        self.removeAllChildren()
        
        physicsWorld.gravity = .init(dx: 0, dy: 0)
        self.run(.wait(forDuration: 1)) {
            self.physicsWorld.gravity = .init(dx: 0, dy: -1)
        }
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        let itemNames = Settings.shared.themeType.textureNames
        
        let count = itemNames.count
        let coef: CGFloat = 7.0
        let width = self.frame.width / coef
        let height = width
        let size = CGSize(width: width, height: height)
        let spacing: CGFloat = 4
        
        let extr = count % 3
        let shortLenth: Int = count / 3
        let longLenth = extr == 0 ? shortLenth : shortLenth + 1

        var rowsCount: [Int] = []
        switch extr {
        case 0: rowsCount = [longLenth, longLenth, longLenth]
        case 1: rowsCount = [shortLenth, longLenth, shortLenth]
        case 2: rowsCount = [longLenth, shortLenth, longLenth]
        default: rowsCount = []
        }
        
        var index = 0
        for row in rowsCount.enumerated() {
            let rowLenth = row.element
            let isLongRow = row.element == longLenth
            let xAddOffset: CGFloat = isLongRow ? 0 : width / 2
            let xOffset: CGFloat = -xAddOffset + (width * CGFloat(longLenth) / 2) - 0.5 * width
            let yCoef: CGFloat = extr == 0 ? 1.0 : 0.9
            let yOffset: CGFloat = frame.height / 2 - height
            for j in 0..<rowLenth {
                let itemName = itemNames[index]
                let item = Ball(size: size, systemName: itemName)
                self.addChild(item)
                let x: CGFloat = (width + spacing) * CGFloat(j) - xOffset
                let y: CGFloat = (height + spacing) * CGFloat(row.offset) * yCoef + yOffset
                let position = CGPoint(x: x, y: y)
                item.position = position
                item.isOpened = true
                
                index += 1
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else { return }
        guard let tappedBall = nodes(at: position).first(where: { $0 is Ball }) as? Ball else {
            return
        }
        tappedBall.isOpened.toggle()
    }
    
}
