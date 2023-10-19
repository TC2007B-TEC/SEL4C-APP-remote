//
//  TempActivityvc.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 06/09/23.
//

import UIKit
import WebKit

class ActivityFinalVC: UIViewController, TurninVCDelegate{
    
    @IBOutlet weak var turninBut: UIButton!
    @IBOutlet weak var wasTurnedin: UIControl!
    
    let actName = "A5"
    @IBOutlet weak var video: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad Final"
        wasTurnedin.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        self.wasTurnedIn()
        
        if let youtubeURL1 = URL(string: "https://www.youtube.com/embed/E7EzITdzarI") {
                    let request = URLRequest(url: youtubeURL1)
            video.load(request)
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
