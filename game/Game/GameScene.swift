//
//  GameScene.swift
//  Elvis Match
//
//  Created by Danil on 12/08/2020.
//

import SpriteKit
import GameplayKit

let worldCategory   : UInt32 = 0x1 << 1
let ballCategory    : UInt32 = 0x1 << 2

let inAppFontName = "a_MachinaOrtoSls-Bold"

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum GameState { case isFalling, waitingForTap, poused }
    
    var level = 0
    var itemsCount: Int { level + 3 }
    var items: [Ball] = []

    weak var gameOverDelegate: GameOverable?
    
    var aimName: String?
    var aim: AimItemNode!
        
    var gameState: GameState = .waitingForTap
    
    var randomImpuls: CGVector {
        let impuls: CGFloat = 88
        return CGVector.init(dx: .random(in: -impuls...impuls), dy: .random(in: -impuls...impuls))
    }
    
    var isComplete: Bool {
        var isComplete = true
        items.forEach {
            let isAim = $0.name == self.aimName
            let isClosed = !$0.isOpened
            let isClosedAndAim = isAim && isClosed
            if isClosedAndAim {
                isComplete = false
            }
        }
        return isComplete
    }
        
    override func didMove(to view: SKView) {
        
        self.setupNewGame()
        
        aim = AimItemNode(aimItemName: aimName!)
        aim.position.x = frame.midX
        aim.position.y = frame.maxY + aim.calculateAccumulatedFrame().height / 2
        self.addChild(aim)
        
        physicsWorld.gravity = .init(dx: 0, dy: 0)
        let topOff = aim.calculateAccumulatedFrame().height
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: .init(top: 0, left: 0, bottom: topOff, right: 0)) )
        physicsWorld.contactDelegate = self
        physicsBody?.categoryBitMask = worldCategory
        
        let str = "REMEMBER ALL THE ITEM POSITIONS\nCOLLECT ALL THE AIM ITEMS"
        _ = TapToStartNode(info: str, scene: self, complition: {
            self.dropTheBalls()
        })
    }
    
    func setupNewGame() {
        items.forEach { $0.removeFromParent() }
        items.removeAll()

        let n = 3
        let allItemNames = Settings.shared.themeType.textureNames.shuffled()
        let itemNames = allItemNames[0..<n]
        aimName = itemNames.randomElement()!
        
        let extr = itemsCount % 3
        let shortLenth: Int = itemsCount / 3
        let longLenth = extr == 0 ? shortLenth : shortLenth + 1
        
        let coefMin: CGFloat = 7.0
        let coefMax = CGFloat(longLenth + 2)
        let coef = min(coefMin, coefMax)
        let width = self.frame.width / coef
        let height = width
        let size = CGSize(width: width, height: height)
        let spacing: CGFloat = 4

        var rowsCount: [Int] = []
        switch extr {
        case 0: rowsCount = [longLenth, longLenth, longLenth]
        case 1: rowsCount = [shortLenth, longLenth, shortLenth]
        case 2: rowsCount = [longLenth, shortLenth, longLenth]
        default: rowsCount = []
        }
        
        for row in rowsCount.enumerated() {
            let rowLenth = row.element
            let isLongRow = row.element == longLenth
            let xAddOffset: CGFloat = isLongRow ? 0 : width / 2
            let xOffset: CGFloat = -xAddOffset + (width * CGFloat(longLenth) / 2) - 0.5 * width
            let yCoef: CGFloat = extr == 0 ? 1.0 : 0.9
            let yOffset: CGFloat = frame.height / 2 - height
            for j in 0..<rowLenth {
                let colorIndex = (items.count % n)
                let systemName = itemNames[colorIndex]
                let item = Ball(size: size, systemName: systemName)
                self.addChild(item)
                let x: CGFloat = (width + spacing) * CGFloat(j) - xOffset
                let y: CGFloat = (height + spacing) * CGFloat(row.offset) * yCoef + yOffset
                let position = CGPoint(x: x, y: y)
                item.position = position
                item.isOpened = true
                items.append(item)
            }
        }

        self.items.forEach { $0.isOpened = true }
        gameState = .waitingForTap
    }
    
    func dropTheBalls() {

        self.items.forEach { $0.isOpened = false }
        
        self.run(.sequence([
            .wait(forDuration: 1),
            .run {
                self.explode()
            },
            .wait(forDuration: 4),
            .run {
                self.showAim()
                self.items.forEach { $0.physicsBody = nil }
                self.gameState = .poused
            }
        ]))
        
        gameState = .isFalling
    }
    
    func showAim() {
        let y: CGFloat = aim.calculateAccumulatedFrame().height + 8
        aim.run(SKAction.moveBy(x: 0, y: -y, duration: 0.5))
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        switch gameState {
        case .waitingForTap:
            print("3,2,1,,,")
        case .isFalling:
            print("wait...")
        case .poused:
            guard let position = touches.first?.location(in: self) else { return }
            guard let tappedBall = nodes(at: position).first(where: { $0 is Ball }) as? Ball else {
                return
            }
            tappedBall.isOpened = true
            if tappedBall.name != aimName {
                wrongTapped(ball: tappedBall)
            } else {
                correctTapped(ball: tappedBall)
            }
        }
    }
    
    func wrongTapped(ball: Ball) {
        let bombBalls = items.filter { $0.name != aimName }
        bombBalls.forEach { $0.isOpened = true }
        
        var sequence = [SKAction]()
        sequence.append(SKAction.wait(forDuration: 0.5))
        for ball in items {
            if ball.name != aimName {
                sequence.append(SKAction.wait(forDuration: 0.1))
                sequence.append(SKAction.run { ball.explode() })
                sequence.append(.run {
                    SoundManager.sharedInstance.play(sound: .boom, node: self)
                })
            } else {
                ball.isOpened = true
            }
        }
        sequence.append(SKAction.wait(forDuration: 1))
        sequence.append(SKAction.run { self.gameOver(isWinner: false) })
        self.run(SKAction.sequence(sequence))
    }
    
    func correctTapped(ball: Ball) {
        SoundManager.sharedInstance.play(sound: .coin, node: self)
        
        ball.run(.fadeOut(withDuration: 1))

        if isComplete {
            self.run(.wait(forDuration: 0.5)) {
                self.gameOver(isWinner: true)
            }
        }
    }

    func gameOver(isWinner: Bool) {
        self.removeAllActions()
        
        gameOverDelegate?.gameOver(isWinner: isWinner)
    }
    
    func explode() {
        SoundManager.sharedInstance.play(sound: .explosion, node: self)

        self.items.forEach {
            $0.physicsBody?.applyTorque(CGFloat.random(in: -20...20))
            $0.physicsBody?.applyImpulse (self.randomImpuls)
        }

//        if let particles = SKEmitterNode(fileNamed: "Explosion") {
//            particles.position = .init(x: frame.midX, y: frame.midY)
//            particles.setScale(2)
//            self.addChild(particles)
//
//            let removeAfterDead = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()])
//            particles.run(removeAfterDead)
//        }
    }
    
}
