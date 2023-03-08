//
//  InfoViewController.swift
//  game
//
//  Created by toha on 30.03.2021.
//


import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var fire: UIImageView!
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fire.addPart()
        
//        makeEventsSandable()
    }
}
