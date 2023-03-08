//
//  SqnsViewController.swift
//  LevelUp
//
//  Created by 1 on 15.12.2021.
//

import SpriteKit

protocol GameOverable: AnyObject {
    func gameOver(isWinner: Bool)
}

class SqnsViewController: UIViewController, GameOverable {
    
    var level = 0
    let steps = 3
    private var currentGameIndex = 0
    
    lazy var levelsIndicatorView = LevelsIndicatorView(levels: steps)

    let gameView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
                
        self.view.addSubview(gameView)
        gameView.fillSuperViewsSafeArea()
        
        self.navigationItem.titleView = levelsIndicatorView
    }
        
    private var viewFirstDidLayoutSubviews = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !viewFirstDidLayoutSubviews {
            viewFirstDidLayoutSubviews = true
            
            gameView.showsPhysics = false
            gameView.backgroundColor = .clear
            gameView.ignoresSiblingOrder = true
            gameView.allowsTransparency = true
            
            setGame()
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setGame() {
        let scene = GameScene(size: gameView.bounds.size)
        scene.gameOverDelegate = self
        scene.level = level + currentGameIndex
        print(level + currentGameIndex)
        scene.anchorPoint = .init(x: 0.5, y: 0.0)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        
        gameView.presentScene(scene)
        gameView.isHidden = false
    }
    
    func gameOver(isWinner: Bool) {
        
        let wasLastGame = steps == (currentGameIndex + 1)
        let playNextGame = !wasLastGame && isWinner
        
        if playNextGame {
            setNextGame()
        } else {
            if isWinner && Level.shared.level == level {
                Level.shared.level += 1
            }
            presentFinal(isWinner: isWinner)
        }
    }
    
    func presentFinal(isWinner: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "final") as! FinalViewController
        vc.isWinner = isWinner
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func setNextGame() {
        currentGameIndex += 1
        levelsIndicatorView.levelsDone = self.currentGameIndex
        setYouWin()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.setGame()
        }
    }
    
    func setYouWin() {
        let sceanSize = gameView.bounds.size
        let scene = SKScene(size: sceanSize)
        scene.backgroundColor = .clear
        
        let texture = SKTexture(systemName: "hand.thumbsup.fill", color: .systemGreen)
        let startLabel = SKSpriteNode(texture: texture, color: .clear, size: .init(width: 256, height: 256))
        startLabel.position = .init(x: scene.frame.midX, y: scene.frame.midY)
        scene.addChild(startLabel)
        
        startLabel.setScale(0.01)
        let appear = SKAction.group([SKAction.scale(to: 0.5, duration: 0.25), SKAction.fadeIn(withDuration: 0.25)])
        let disappear = SKAction.group([SKAction.scale(to: 1, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)])
        let sequence = SKAction.sequence([appear, SKAction.wait(forDuration: 0.25), disappear, SKAction.removeFromParent()])
        startLabel.run(sequence)
        
        gameView.presentScene(scene)
    }
}
