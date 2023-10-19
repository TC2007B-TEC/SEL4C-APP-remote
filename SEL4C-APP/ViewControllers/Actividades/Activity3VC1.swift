//
//  Activity3VC1.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 11/10/23.
//

import UIKit
import WebKit

class Activity3VC1: UIViewController, TurninVCDelegate{
    
    @IBOutlet weak var turninBut: UIButton!
    @IBOutlet weak var wasTurnedin: UIControl!
    
    @IBOutlet weak var web1: WKWebView!
    @IBOutlet weak var web2: WKWebView!
    
    let actName = "A3_1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 3.1"
        wasTurnedin.isHidden = true
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        self.wasTurnedIn()
        
        if let URL1 = URL(string: "https://www.sistemab.org/ser-b/") {
                    let request = URLRequest(url: URL1)
            web1.load(request)
                }
        
        if let URL2 = URL(string: "https://www.ashoka.org/en-us/our-network") {
                    let request = URLRequest(url: URL2)
            web2.load(request)
                }
        
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
