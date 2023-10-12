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
    
    var A1Done = false
    var A2Done = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 3"
        
        wasTurnedIn(actName: "A3_1"){success in
            if success {
                self.A1Done = true
            }
            else {
                self.A1Done = false
            }
        }
        
        wasTurnedIn(actName: "A3_2"){success in
            if success {
                self.A2Done = true
            }
            else {
                self.A2Done = false
            }
        }
        
    }
    
    func wasTurnedIn(actName: String, completion: @escaping (Bool) -> Void) {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")!

        ActivityDoneAPI.shared.getAPI(email: email, name: actName) { [weak self] success in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    @IBAction func subact1segue(_ sender: Any) {
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad3.1")
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func subact2segue(_ sender: Any) {
        wasTurnedIn(actName: "A3_1"){success in
            if success {
                let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad3.2")
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else {
                let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alerta, animated: true)
            }
        }
    }
    
}


