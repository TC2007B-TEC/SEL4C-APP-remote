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
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var A1Done = false
    var A2Done = false
    var A3Done = false
    
    let group = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 1"
        
        
        
        if let navigationController = navigationController {
                navigationController.navigationBar.barTintColor = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(51) / 255.0, blue: CGFloat(160) / 255.0, alpha: 1.0)
                navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        wasTurnedIn(actName: "A1_1"){success in
            if success {
                self.A1Done = true
                self.img1.image = UIImage(systemName: "brain.head.profile.fill")
            }
            else {
                self.A1Done = false
            }
        }
                
        wasTurnedIn(actName: "A1_2"){success in
            if success {
                self.A2Done = true
                self.img2.image = UIImage(systemName: "person.line.dotted.person.fill")
            }
            else {
                self.A2Done = false
            }
        }

        wasTurnedIn(actName: "A1_3"){success in
            if success {
                self.A3Done = true
                self.img3.image = UIImage(systemName: "figure.walk.circle.fill")
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
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1.1")
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func subact2segue(_ sender: Any) {
        wasTurnedIn(actName: "A1_1"){success in
            if success {
                let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1.2")
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
        wasTurnedIn(actName: "A1_2"){success in
            if success {
                let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1.3")
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
