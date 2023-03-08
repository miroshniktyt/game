//
//  LevelsGrid.swift
//  Roobet
//
//  Created by 1 on 04.03.2022.
//

import UIKit
import GameKit

class LevelsStackViewController: UIViewController {
    
    let numberOfRows = 5
    let numberOfColums = 5
    var level = Level.shared.level
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLevels()
    }
    
    private func setupLevels() {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)
        stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        stackView.ancherToSuperviewsCenter()
        
        var levelNumber = 1
        for _ in 0 ..< numberOfRows {
            
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 12
            
            for _ in 0 ..< numberOfColums {

                let isLevelOpened = levelNumber <= level//TODO
                
                let levelButton = UIButton()
                levelButton.imageView?.contentMode = .scaleAspectFit
                let bgColor: UIColor = isLevelOpened ? .accent : .lightGray.withAlphaComponent(0.7)
                levelButton.backgroundColor = bgColor
                levelButton.titleLabel?.font = .init(name: inAppFont + "-Bold", size: 24)
                levelButton.layer.cornerRadius = 8
                levelButton.setTitleColor(.main, for: .normal)

                if isLevelOpened {
                    levelButton.tag = levelNumber
                    levelButton.setTitle("\(levelNumber)", for: .normal)
                    levelButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                } else {
                    let image = UIImage(systemName: "lock.fill")?.withTintColor(.main)
                    levelButton.setImage(image, for: .normal)
                    levelButton.tintColor = .main
                }
                
                rowStackView.addArrangedSubview(levelButton)
                levelNumber += 1
            }
            
            stackView.addArrangedSubview(rowStackView)
        }
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let vc = SqnsViewController()
        vc.level = sender.tag
        print(sender.tag)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

extension UIStackView {
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}

extension UIView {
    func stickToButtonSqr() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: heightAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
}
