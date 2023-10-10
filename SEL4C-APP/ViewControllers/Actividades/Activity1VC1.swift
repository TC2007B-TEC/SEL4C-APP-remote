//
//  Activity1.1.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 06/10/23.
//

import UIKit

class Activity1VC1: UIViewController{
    
    @IBOutlet weak var turninBut: UIButton!
    @IBOutlet weak var actStatus: UILabel!
    let actName = "A1_1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actividad 1.1"
        actStatus.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")!
            //turninBut.isHidden = true // Hide the button when returning to this view controller
        
        getAPI(email: email,name: actName)
        group.wait()
        if condicion == true {
            
            turninBut.isHidden = true
            actStatus.isHidden = false
            
            
            //self.performSegue (withIdentifier: "loginSegue", sender: self)

            //Navegar a Home Screen
            //
        }
    }
    
    
    
    @IBAction func turninSegue(_ sender: Any) {
        
        //let des = segue.destination as! TurninVC
        //des.delegate = self
        
        let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Turnin") as! TurninVC
        viewController.receivedActivity = actName


        //navigationController?.pushViewController(viewController, animated: true)
        present(viewController, animated: true) {
            
            let defaults = UserDefaults.standard
            let email = defaults.string(forKey: "USERNAME")!

            let group = DispatchGroup()
            self.getAPI(email: email, name: self.actName)
            self.group.wait()

            if self.condicion == true {
                self.turninBut.isHidden = true
                self.actStatus.isHidden = false
            }
        }
    }
    
    func isturnedin(){
        
    }
    
    
    
    var condicion = false
    let group = DispatchGroup()
    
    func getAPI(email: String,name: String){
        // Definir la URL del endpoint de la API
        let url = URL(string: "http://20.127.122.6:8000/verifact/")!

        // Crear un objeto URLRequest con el método POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Crear el objeto JSON que se enviará como cuerpo de la solicitud
        let json = [
            "name": name,
            "email": email
        ]

        // Codificar el objeto JSON a datos binarios
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        

        // Asignar los datos binarios al cuerpo de la solicitud
        request.httpBody = jsonData

        // Asignar el tipo de contenido adecuado a los encabezados de la solicitud
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        group.enter()
        
        // Crear una tarea URLSession para enviar la solicitud y recibir la respuesta
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Comprobar si hay algún error
            if let error = error {
                print("Error al enviar la solicitud: \(error)")
                return
            }
            
            // Comprobar si hay datos en la respuesta
            if let data = data {
                // Intentar decodificar los datos como un objeto JSON
                if let json = try? JSONSerialization.jsonObject(with: data) {
                    // Imprimir el objeto JSON
                    print("Respuesta JSON: \(json)")
                    self.condicion = true
                } else {
                    // Imprimir los datos como una cadena
                    print("Respuesta de texto: \(String(data: data, encoding: .utf8) ?? "")")
                    
                }
            }
            self.group.leave()
        }

        // Iniciar la tarea
        task.resume()


    }
    
}
