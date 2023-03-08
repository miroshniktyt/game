//
//  FinalViewController.swift
//  Buffalo Up
//
//  Created by toha on 23.03.2021.
//

import GameKit

class FinalViewController: BaseVC {
        
    var isWinner: Bool = false

    @IBOutlet weak var playButton: InAppButton!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        playButton.layer.cornerRadius = 8
        playButton.backgroundColor = Settings.shared.colorsMode.color
        
        levelLabel.isHidden = true
        
        if !isWinner {
            label.text = "GAME OVER"
//            levelLabel.isHidden = true
        } else {
            label.text = "YOU WIN"
//            levelLabel.isHidden = false
//            Level.shared.level += 1
//            let level = Level.shared.level
//            levelLabel.text = "LEVEL \(level) IS OPENED NOW"
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let mainWindow = appDelegate?.window
        let stroy = UIStoryboard(name: "Main", bundle: nil)
        let nc = stroy.instantiateViewController(withIdentifier: "init")
        mainWindow?.rootViewController = nc
    }
    
}
