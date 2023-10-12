//
//  WebVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 09/10/23.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    @IBOutlet var webView : WKWebView!
    var testF = false

    override func viewDidLoad() {
        super.viewDidLoad()
        url()
    }
    
    func url() {
        let defaults = UserDefaults.standard
        let user = defaults.string(forKey: "USERNAME")
        let base_url = "https://74.208.39.10:3000/radar/"
        let urlAux = base_url + user!
        
        guard let url = URL(string: urlAux) else { return }
        webView.load( URLRequest(url: url) )
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
    
    @IBAction func return2prof(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
