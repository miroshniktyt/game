//
//  MenuViewController.swift
//  digger
//
//  Created by toha on 06.03.2021.
//

import GameKit


class MenuViewController: UIViewController {
    
    @IBOutlet weak var startBtn: InAppButton!
    @IBOutlet weak var settingBtn: InAppButton!
    @IBOutlet weak var infoBtn: InAppButton!
    @IBOutlet weak var loggo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.layer.cornerRadius = 8
        setColors()
    }
    
    func setColors() {
        let color = Settings.shared.colorsMode.color
        navigationController?.navigationBar.tintColor = color
        
        infoBtn.tintColor = color
        loggo.tintColor = color
        settingBtn.tintColor = color
        startBtn.backgroundColor = color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setColors()
    }
}
