//
//  TempActivityvc.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 06/09/23.
//

import UIKit

class Activity3VC: UIViewController {
    
    @IBOutlet weak var subact1But: UIControl!
    @IBOutlet weak var subact2But: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 3"
    }
    
    @IBAction func subact1segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad3.1")
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func subact2segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad3.2")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


