//
//  LevelsIndicatorView.swift
//  LevelUp
//
//  Created by 1 on 15.12.2021.
//

import UIKit

class LevelsIndicatorView: UIView {
    
    var levels: Int {
        didSet {
            self.subviews.forEach { $0.removeFromSuperview() }
            imageViews.removeAll()
            commInit()
        }
    }
    
    var levelsDone = 0 {
        didSet {
            let index = levelsDone - 1
            let imageView = imageViews[index]
            imageView.image = UIImage(systemName: "checkmark.square.fill")
            imageView.tintColor = .systemGreen
            let animation = { imageView.transform = .init(scaleX: 1.4, y: 1.4) }
            UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: animation) {_ in
                imageView.transform = .identity
            }
        }
    }
    
    var imageViews: [UIImageView] = []
    
    init(levels: Int) {
        self.levels = levels
        super.init(frame: .zero)
        
        commInit()
    }
    
    func commInit() {
        self.clipsToBounds = false
        self.backgroundColor = .clear
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        for _ in 1...levels {
            let image = UIImage(systemName: "square")!
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white
            imageView.makeSqr()
            imageViews.append(imageView)
            stack.addArrangedSubview(imageView)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        stack.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        self.levels = 3
        super.init(coder: coder)

        commInit()
    }
}
