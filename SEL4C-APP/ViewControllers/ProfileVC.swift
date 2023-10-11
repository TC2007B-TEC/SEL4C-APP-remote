//
//  ProfileVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 03/09/23.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var usenameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let user = defaults.string(forKey: "USERNAME")
        usenameLabel.text = "\(user!)"

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func showResultsWeb(_ sender: Any) {
        let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ResultsWeb")
        navigationController?.pushViewController(viewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
