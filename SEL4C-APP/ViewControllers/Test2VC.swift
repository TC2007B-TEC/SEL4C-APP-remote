//
//  Test2VC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 10/10/23.
//

import UIKit

class Test2VC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let defaults = UserDefaults.standard
        //let user = defaults.string(forKey: "USERNAME")
        
        // Do any additional setup after loading the view.
    }
}
