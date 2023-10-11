//  LoginViewController.swift
//  SEL4C
//
//  Created by Jesús Alexander Meister Careaga on 04/09/23.
//

import UIKit
import CryptoKit

class LoginVC: UIViewController {
    
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
                        print("Respuesta: \(result)")
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
    
    var test1Completado = false
    var test2Completado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let defaults = UserDefaults.standard
        let isUserLogged = defaults.bool(forKey: "ISUSERLOGGEDIN")
        // Do any additional setup after loading the view.
        Login.isEnabled = false
        ErrorUser.text = ""
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBOutlet weak var Pass: UITextField!
    @IBOutlet weak var User: UITextField!
    @IBOutlet weak var ErrorUser: UILabel!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var Show: UIButton!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func validarEmail(txt:String)-> Bool{
        let exp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        let validar = NSPredicate(format:"SELF MATCHES[c] %@", exp)
        let esValido = validar.evaluate(with: txt)
        return esValido
    }
    
    //    func validarPassword(txt:String)-> Bool{
    //        let exp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^\\w\\s]).{8,}$"
    //        let validar = NSPredicate(format:"SELF MATCHES %@", exp)
    //        let esValido = validar.evaluate(with: txt)
    //        return esValido
    //    }
    
    func activarBoton(){
        if (validarEmail(txt: User.text!) && Pass.text!.count > 0){
            Login.isEnabled = true
        }
        else {
            Login.isEnabled = false
        }
    }
    
    @IBAction func Cambio1(_ sender: Any) {
        activarBoton()
        if validarEmail(txt: User.text!) == false {
            ErrorUser.text = "Ingrese una dirección de Email valida"
        }
        else{
            ErrorUser.text = ""
        }
        
    }
    
    @IBAction func Cambio2(_ sender: Any) {
        activarBoton()
    }
    
    var mostrar = false
    @IBAction func Mostrar(_ sender: Any) {
        mostrar = !mostrar
        if mostrar == true {
            Pass.isSecureTextEntry = false
            Show.setTitle("Ocultar", for: .normal)
        }
        else {
            Pass.isSecureTextEntry = true
            Show.setTitle("Mostrar", for: .normal)
        }
    }
    

//    let group = DispatchGroup()
    
//    func fetchAPI(email: String, password: String){
//        group.enter()
//            // Define la URL de la API
//        let url = URL(string:"http://20.127.122.6:8000/usuario/?email=\(email)&password=\(password)")!
//            // Crea la tarea de descarga
//            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                if let error = error {
//                    print("Error: \(error)")
//                } else if let data = data {
//                    // Imprime los datos como una cadena
//                    let str = String(data: data, encoding: .utf8)
//                    print("Received data:\n\(str ?? "")")
//                    if (str == "[]") {self.condicion = false}
//                    else {self.condicion = true}
//                }
//                self.group.leave()
//            }
//            task.resume()
//        }
    
    
    var condicion = false
    
//    func getAPI(email: String,password: String){
//        // preparar los datos json
//        let json: [String: Any] = [
//            "email": email,
//            "password": password,
//        ]
//
//        print(json)
//
//        let datosJson = try? JSONSerialization.data(withJSONObject: json)
//
//        print(datosJson)
//
//        // crear la solicitud post
//        let url = URL(string: "http://20.127.122.6:8000/usuariolog/")!
//        var solicitud = URLRequest(url: url)
//        solicitud.httpMethod = "POST"
//
//        // insertar los datos json a la solicitud
//        solicitud.httpBody = datosJson
//        group.enter()
//
//        let tarea = URLSession.shared.dataTask(with: solicitud) { datos, respuesta, error in
//          guard let datos = datos, error == nil else {
//              print("tarea entro")
//            print(error?.localizedDescription ?? "No hay datos")
//            return
//          }
//
//          let respuestaJSON = try? JSONSerialization.jsonObject(with: datos, options: [])
//          if let respuestaJSON = respuestaJSON as? [String: Any] {
//            print("Respuestas JSON entro")
//            print(respuestaJSON)
//          }
//          self.group.leave()
//        }
//
//        tarea.resume()
//
//    }
    
    
    func getAPI(email: String,password: String){
        // Definir la URL del endpoint de la API
        let url = URL(string: "http://20.127.122.6:8000/usuariolog/")!

        // Crear un objeto URLRequest con el método POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Crear el objeto JSON que se enviará como cuerpo de la solicitud
        let json = [
            "email": email,
            "password": password
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
    
    func sha256(_ input: String) -> String {
        // Convertir el string a datos binarios
        let data = Data(input.utf8)
        // Calcular el hash SHA-256 usando la librería CryptoKit
        let hash = SHA256.hash(data: data)
        // Convertir el hash a un string hexadecimal
        let hexString = hash.compactMap { String(format: "%02x", $0) }.joined()
        // Regresar el string hexadecimal
        return hexString
    }
    
        @IBAction func login ( sender: UIButton) {
            getAPI(email: User.text!,password: sha256(Pass.text!))
            group.wait()
            
            let defaults = UserDefaults.standard
        
            if condicion == true {
                
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set(User.text, forKey: "USERNAME")
                
                // revisar si el test inicial ya fue hecho
                let email = defaults.string(forKey: "USERNAME")!
                test1Completado = verificarTest(testType: "D1", usuario: email)
                group.wait()
                test2Completado = verificarTest(testType: "D2", usuario: email)
                group.wait()
                
                if test1Completado == false{
                    let viewController = UIStoryboard(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "testID")

                    navigationController?.pushViewController(viewController, animated: true)
                }
                else if test2Completado == false {
                    let viewController = UIStoryboard(name: "Test", bundle:nil).instantiateViewController(withIdentifier: "test2VC")
                                    
                    navigationController?.pushViewController(viewController, animated: true)
                }
                else if test1Completado && test2Completado {
                    goToHomeScreen()
                }
                
                //self.performSegue (withIdentifier: "loginSegue", sender: self)

                //Navegar a Home Screen
                //
            } else {
                print ("La condición no se cumplió")
                let alerta = UIAlertController(title: "El usuario y/o la contraseña son incorrectos", message: "Ingresa un usuario y contraseña existentes", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alerta, animated: true)
            }
        }
    
    func goToHomeScreen() {
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBarVC
        self.navigationController?.pushViewController(homeVC, animated: true)
        }


}

