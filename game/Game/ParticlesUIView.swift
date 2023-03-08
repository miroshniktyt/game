//
//  ParticlesUIView.swift
//  digger
//
//  Created by 1 on 12.10.2021.
//

import SpriteKit

class ParticlesUIView: SKView {
    
    var part: SKNode!

    init() {
        super.init(frame: .zero)
        commInit()
    }

    func commInit() {
        self.backgroundColor = .yellow

        let size = CGSize(width: 64, height: 64)
        let scene = PartScene(size: size)
        scene.scaleMode = .aspectFill
        self.presentScene(scene)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commInit()
    }
}

class PartScene: SKScene {
    
    override func didMove(to view: SKView) {
//        self.backgroundColor = .red
        let part = SKEmitterNode(fileNamed: "expBig")!
        part.position = .init(x: frame.midX, y: frame.midY)
        self.addChild(part)
    }
}

extension UIView {
    func addPart() {
        let skView = SKView()
        self.addSubview(skView)
//        skView.fillSuperView()
        
        let scene = PartScene(size: .init(width: 64, height: 64))
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        skView.allowsTransparency = true
        skView.presentScene(scene)
    }
}

class PVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addPart()
    }
}
