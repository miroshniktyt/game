//
//  SettingsVC.swift
//  MeasureNoise
//
//  Created by 1 on 13.03.2022.
//

import UIKit
import SpriteKit

class SettingsVC: UITableViewController {
    @IBOutlet weak var soundSwitch: UISwitch!
    
    @IBOutlet weak var darkSwitch: UISegmentedControl!
    @IBOutlet weak var colorsSwitch: UISegmentedControl!
    @IBOutlet weak var itemsSwitch: UISegmentedControl!
    
    @IBOutlet weak var skView: SKView!
    var scene: PreviewScene!
    
    @IBAction func darkMode(_ sender: Any) {
        guard let segment = sender as? UISegmentedControl else { return }
        
        let int = segment.selectedSegmentIndex
        let darkMode = UIUserInterfaceStyle(rawValue: int)!
        Settings.shared.darkMode = darkMode
        scene.setupNewGame()
    }
    
    @IBAction func colorMode(_ sender: Any) {
        guard let segment = sender as? UISegmentedControl else { return }
        
        let int = segment.selectedSegmentIndex
        let colorMode = ColorsType.init(rawValue: int)!
        Settings.shared.colorsMode = colorMode
        scene.setupNewGame()
        
        navigationController?.navigationBar.tintColor = Settings.shared.colorsMode.color
    }
    
    @IBAction func itemsMode(_ sender: Any) {
        guard let segment = sender as? UISegmentedControl else { return }
        
        let int = segment.selectedSegmentIndex
        let themeType = ThemeType.init(rawValue: int)!
        Settings.shared.themeType = themeType
        scene.setupNewGame()
    }
    
    @IBAction func soundSwitch(_ sender: Any) {
        guard let soundSwitch = sender as? UISwitch else { return }
        
        SoundManager.sharedInstance.isMuted = !soundSwitch.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        
        soundSwitch.isOn = !SoundManager.sharedInstance.isMuted
        darkSwitch.selectedSegmentIndex = Settings.shared.darkMode.rawValue
        print(Settings.shared.darkMode.rawValue)
        colorsSwitch.selectedSegmentIndex = Settings.shared.colorsMode.rawValue
        print(Settings.shared.colorsMode.rawValue)
        itemsSwitch.selectedSegmentIndex = Settings.shared.themeType.rawValue

//        addDoneToNavigatin()
    }
    
    private var viewFirstDidLayoutSubviews = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !viewFirstDidLayoutSubviews {
            viewFirstDidLayoutSubviews = true
            setGame()
        }
    }
    
    func setGame() {
        scene = PreviewScene(size: self.skView.bounds.size)
        
        scene.backgroundColor = .clear
        scene.anchorPoint = .init(x: 0.5, y: 0.0)
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.allowsTransparency = true
    }
    
}

extension UIViewController {
    func addDoneToNavigatin() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisss))
//        let barButtonItem = UIBarButtonItem(title: "asd", style: .done, target: self, action: #selector(dismisss))
        navigationItem.leftBarButtonItem = barButtonItem //UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(dismisss))
    }
    
    @objc func dismisss() {
        self.dismiss(animated: true, completion: nil)
    }
}
