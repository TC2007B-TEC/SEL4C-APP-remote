//
//  ProfileVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 03/09/23.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var usenameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    let group = DispatchGroup()
    func getNombre() -> String{
        
        var respuesta = ""
        let defaults = UserDefaults.standard
        let user = defaults.string(forKey: "USERNAME")
        // preparar los datos json
        let json: [String: Any] = [
            "email": user!
        ]

        print(json)
        let datosJson = try? JSONSerialization.data(withJSONObject: json)
            
        // crear la solicitud post
        let url = URL(string: "http://20.127.122.6:8000/unusuario/")!
        var solicitud = URLRequest(url: url)
        solicitud.httpMethod = "POST"

        // insertar los datos json a la solicitud
        solicitud.httpBody = datosJson
        group.enter()
        let tarea = URLSession.shared.dataTask(with: solicitud) { datos, respuesta, error in
          guard let datos = datos, error == nil else {
            print(error?.localizedDescription ?? "No hay datos")
            return
          }

          let respuestaJSON = try? JSONSerialization.jsonObject(with: datos, options: [])
          if let respuestaJSON = respuestaJSON as? [String: Any] {
            print(respuestaJSON)
          }
          self.group.leave()
        }

        tarea.resume()
        return respuesta
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let user = defaults.string(forKey: "USERNAME")
        let name = getNombre()
        group.wait()
        print(name)
        usenameLabel.text = "\(user!)"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func showResultsWeb(_ sender: Any) {
        //let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ResultsWeb")
        //navigationController?.pushViewController(viewController, animated: true)
        let defaults = UserDefaults.standard
        let user = defaults.string(forKey: "USERNAME")
        let base_url = "http://74.208.39.10:3000/radar/"
        let urlAux = base_url + user!
        
        guard let url = URL(string: urlAux) else { return }
        UIApplication.shared.open(url)
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
