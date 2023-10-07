//
//  FirstVCViewController.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 07/10/23.
//

import UIKit

class FirstVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        let defaults = UserDefaults.standard
        let isUserLogged = defaults.bool(forKey: "ISUSERLOGGEDIN")
        if (isUserLogged) {
            //El usuario ya está logueado, navegar a home screen
            goToHomeScreen()
            
            // Do any additional setup after loading the view.
        }
        
        func goToHomeScreen() {
            
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBarVC
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        
        
    }
}
