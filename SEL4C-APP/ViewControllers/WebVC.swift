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

    override func viewDidLoad() {
        super.viewDidLoad()
        loadYoutube()
    }
    
    func loadYoutube() {
        guard let youtubeURL = URL(string: "https://youtu.be/t_mypMqSXNw?si=3ScdZqI0NvuE1fqT") else { return }
        webView.load( URLRequest(url: youtubeURL) )
    }
    

    @IBAction func return2prof(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
        navigationController?.pushViewController(viewController, animated: true)
    }
    

}
