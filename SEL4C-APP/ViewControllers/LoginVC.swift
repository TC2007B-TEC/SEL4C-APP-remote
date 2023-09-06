//  LoginViewController.swift
//  SEL4C
//
//  Created by Jesús Alexander Meister Careaga on 04/09/23.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
