//
//  FirstVCViewController.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 07/10/23.
//

import UIKit

class FirstVC: UIViewController {
    
    var group = DispatchGroup()
    func verificarTest(testType: String, usuario: String) -> Bool {
        var respuesta = false
        // Construye la URL con los parámetros
        let baseUrl = "http://20.127.122.6:8000/getpreguntas/?"
        let parameters = "test_type=\(testType)&usuario=\(usuario)"
        if let url = URL(string: baseUrl + parameters) {
            // Crea la sesión de URLSession
            group.enter()
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error al realizar la solicitud: \(error)")
                    return
                }
                
                if let data = data {
                    // Procesa los datos de la respuesta
                    if let result = String(data: data, encoding: .utf8) {
                        //print("Respuesta: \(result)")
                        if result != "{\"message\":\"No se encontraron preguntas\"}" {
                            respuesta = true
                        }
                    } else {
                        print("No se pudo decodificar la respuesta")
                    }
                }
                self.group.leave()
            }
            // Inicia la tarea
            task.resume()
            group.wait()
            return respuesta
        } else {
            print("URL no válida")
        }
        return respuesta
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let defaults = UserDefaults.standard
        
        let isUserLogged = defaults.bool(forKey: "ISUSERLOGGEDIN")
        if (isUserLogged) {
            
            let email = defaults.string(forKey: "USERNAME")!
            
            var test1Completado = verificarTest(testType: "D1", usuario: email)
            group.wait()
            var test2Completado = verificarTest(testType: "D2", usuario: email)
            group.wait()
            // Revisar si el usuario ya hizo su test inicial:
            
            if test1Completado == false{
                let viewController = UIStoryboard(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "testID")
                
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            else if test2Completado == false {
                let viewController = UIStoryboard(name: "Test", bundle:nil).instantiateViewController(withIdentifier: "test2VC")
                                
                navigationController?.pushViewController(viewController, animated: true)
            }
            else if test1Completado && test2Completado{
                //El usuario ya está logueado, navegar a home screen
                goToHomeScreen()
            }
            
            // Do any additional setup after loading the view.
        }
        
        func goToHomeScreen() {
            
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBarVC
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
        
}
