//
//  Activity1VC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 05/10/23.
//

import UIKit

class Activity2VC: UIViewController {
    
    @IBOutlet weak var subact1But: UIControl!
    @IBOutlet weak var subact2But: UIControl!
    @IBOutlet weak var subact3But: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 2"
    }
    
    @IBAction func subact1segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2.1")
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func subact2segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2.2")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func subact3segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2.3")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
