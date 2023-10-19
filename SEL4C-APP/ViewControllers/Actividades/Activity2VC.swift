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
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    
    var A1Done = false
    var A2Done = false
    var A3Done = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 2"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        wasTurnedIn(actName: "A2_1"){success in
            if success {
                self.A1Done = true
                self.img1.image = UIImage(systemName: "globe.americas.fill")
            }
            else {
                self.A1Done = false
            }
        }
                
        wasTurnedIn(actName: "A2_2"){success in
            if success {
                self.A2Done = true
                self.img2.image = UIImage(systemName: "book.pages.fill")
            }
            else {
                self.A2Done = false
            }
        }

        wasTurnedIn(actName: "A2_3"){success in
            if success {
                self.A3Done = true
                self.img3.image = UIImage(systemName: "tree.fill")
            }
            else {
                self.A3Done = false
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
            let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2.1")
            navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func subact2segue(_ sender: Any) {
        wasTurnedIn(actName: "A2_1"){success in
            if success {
                let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2.2")
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else {
                let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alerta, animated: true)
            }
        }
    }
    
    @IBAction func subact3segue(_ sender: Any) {
        wasTurnedIn(actName: "A2_2"){success in
            if success {
                let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2.3")
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
