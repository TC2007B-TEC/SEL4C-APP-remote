//
//  PasswordViewController.swift
//  SEL4C
//
//  Created by Jesús Alexander Meister Careaga on 06/09/23.
//

import UIKit
import Foundation

class PasswordVC: UIViewController {

    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Password2: UITextField!
    @IBOutlet weak var Boton: UIButton!
    @IBOutlet weak var Show1: UIButton!
    @IBOutlet weak var Show2: UIButton!
    @IBOutlet weak var TermsButton: UIButton!
    @IBOutlet weak var PrivacyButton: UIButton!
    
    var nombre: String?
    var apellido: String?
    var email: String?
    var genero: String?
    var edad: String?
    var pais: String?
    var escuela: String?
    var rama: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let isUserLogged = defaults.bool(forKey: "ISUSERLOGGEDIN")
        // Do any additional setup after loading the view.
    }
    
    // Para el teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    var terms = false
    let si = UIImage(systemName: "square.fill")
    let no = UIImage(systemName: "square")
    @IBAction func ChangeTerms(_ sender: Any) {
        print(nombre!)
        terms = !terms
        if terms == true{
            TermsButton.setImage(si, for: .normal)
            activarBoton()
        }
        else {
            TermsButton.setImage(no, for: .normal)
            activarBoton()
        }
    }
    
    @IBAction func PrivacyLink(_ sender: Any) {
        let link = URL(string: "https://tec.mx/es/aviso-de-privacidad-sel4c")!
        UIApplication.shared.open(link)
    }

    func validarPassword(txt:String)-> Bool{
        let exp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$"
        let validar = NSPredicate(format:"SELF MATCHES %@", exp)
        let esValido = validar.evaluate(with: txt)
        return esValido
    }
    
    func validarPassEqual()->Bool{
        if Password.text! == Password2.text! {return true}
        else {return false}
    }
    
    func activarBoton(){
        let a = validarPassword(txt: Password.text!)
        let b = validarPassEqual()
        
        if a && b && terms == true{
            Boton.isEnabled = true
        }
        else {
            Boton.isEnabled = false
        }
    }
    
    @IBAction func Cambio(_ sender: Any) {
        activarBoton()
    }
    
    var mostrar1 = false
    @IBAction func Mostrar1(_ sender: Any) {
        mostrar1 = !mostrar1
        if mostrar1 == true {
            Password.isSecureTextEntry = false
            Show1.setTitle("Ocultar", for: .normal)
        }
        else{
            Password.isSecureTextEntry = true
            Show1.setTitle("Mostrar", for: .normal)
        }
    }
    
    var mostrar2 = false
    @IBAction func Mostrar2(_ sender: Any) {
        mostrar2 = !mostrar2
        if mostrar2 == true {
            Password2.isSecureTextEntry = false
            Show2.setTitle("Ocultar", for: .normal)
        }
        else {
            Password2.isSecureTextEntry = true
            Show2.setTitle("Mostrar", for: .normal)
        }
    }
    
    func passStrenght(txt:String)-> Int{
        var n = 0
        let exps = ["[A-Z]", "[a-z]", "[0-9]", ".{8,}"]
        for exp in exps {
            let regexp = try! NSRegularExpression(pattern: exp)
            let rango = NSRange(location: 0, length: txt.count)
            let matches = regexp.numberOfMatches(in: txt, range: rango)
            if matches > 0{
                n = n + 1
            }
        }
        return n
    }
    
    @IBAction func PassChange(_ sender: Any) {
        let rojo = UIColor.init(red: 0.988, green: 0.847, blue: 0.847, alpha: 1)
        let naranja = UIColor.init(red: 1, green: 0.882, blue: 0.749, alpha: 1)
        let amarillo = UIColor.init(red: 1, green: 0.957, blue: 0.749, alpha: 1)
        let verde = UIColor.init(red: 0.882, green: 1, blue: 0.749, alpha: 1)
        
        let n = passStrenght(txt: Password.text!)
        switch n {
        case 1:
            Password.backgroundColor = rojo
        case 2:
            Password.backgroundColor = naranja
        case 3:
            Password.backgroundColor = amarillo
        case 4:
            Password.backgroundColor = verde
        default:
            Password.backgroundColor = rojo
        }
    }
    
    let group = DispatchGroup()
    func postAPI(){
        // preparar los datos json
        let json: [String: Any] = [
            "email": self.email!,
            "password": self.Password.text!,
            "name": self.nombre!,
            "lname": self.apellido!,
            "gender": self.genero!,
            "age": self.edad!,
            "country": self.pais!,
            "discipline": self.rama!,
            "school": self.escuela!
        ]

        let datosJson = try? JSONSerialization.data(withJSONObject: json)

        // crear la solicitud post
        let url = URL(string: "http://20.127.122.6:8000/usuario/")!
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

    }
    
    @IBAction func createUser(_ sender: Any) {
        postAPI()
        group.wait()
        
        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
        UserDefaults.standard.set(email, forKey: "USERNAME")
        
        self.performSegue(withIdentifier: "testSegue", sender: self)
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
