//
//  Activity1.1.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 06/10/23.
//

import UIKit

class Activity2VC1: UIViewController, TurninVCDelegate{
    
    @IBOutlet weak var turninBut: UIButton!
    @IBOutlet weak var wasTurnedin: UIControl!
    
    let actName = "A2_1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 2.1"
        wasTurnedin.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        self.wasTurnedIn()
        
    }
    
    
    
    @IBAction func turninSegue(_ sender: Any) {
        
        //let des = segue.destination as! TurninVC
        //des.delegate = self
        
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Turnin") as! TurninVC
        viewController.receivedActivity = actName


        //navigationController?.pushViewController(viewController, animated: true)
        let modalViewController = viewController
        modalViewController.delegate = self
        present(viewController, animated: true) {
            
            self.wasTurnedIn()
        }
    }
    
    func wasTurnedIn() {
            let defaults = UserDefaults.standard
            let email = defaults.string(forKey: "USERNAME")!

            ActivityDoneAPI.shared.getAPI(email: email, name: self.actName) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        self?.turninBut.isHidden = true
                        self?.wasTurnedin.isHidden = false
                    }
                }
            }
        }
    
    func uploadFailed() {
        let alerta = UIAlertController(title: "Hubo un error", message: "Intentalo de nuevo mas tarde", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alerta, animated: true)
    }
}
