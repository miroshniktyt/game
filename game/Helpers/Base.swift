//
//  Base.swift
//  digger
//
//  Created by amure on 14.04.2021.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func backTaped() {
        self.dismiss(animated: true, completion: nil)
    }

//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}

class BaseNC: UINavigationController {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
