//
//  Activity1VC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 05/10/23.
//

import UIKit

class Activity1VC: UIViewController {
    
    @IBOutlet weak var subact1But: UIControl!
    @IBOutlet weak var subact2But: UIControl!
    @IBOutlet weak var subact3But: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 1"
        
        if let navigationController = navigationController {
                navigationController.navigationBar.barTintColor = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(51) / 255.0, blue: CGFloat(160) / 255.0, alpha: 1.0)
                navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        
        
    }
    
    @IBAction func subact1segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1.1")
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func subact2segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1.2")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func subact3segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1.3")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
