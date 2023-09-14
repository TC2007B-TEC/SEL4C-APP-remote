
//  RegisterViewController.swift
//  SEL4C
//
//  Created by Jesús Alexander Meister Careaga on 04/09/23.
//

import UIKit

class RegisterVC: UIViewController {

    
    @IBOutlet weak var Nombre: UITextField!
    @IBOutlet weak var Apellido: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Edad: UITextField!
    @IBOutlet weak var Pais: UITextField!
    @IBOutlet weak var Escuela: UITextField!
    @IBOutlet weak var Rama: UITextField!
    @IBOutlet weak var Boton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Boton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    

    func validarNom(txt:String)-> Bool{
        let exp = "[\\p{L}\\s]+"
        let validar = NSPredicate(format:"SELF MATCHES[c] %@", exp)
        let esValido = validar.evaluate(with: txt)
        return esValido
    }
    
    func validarEmail(txt:String)-> Bool{
        let exp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        let validar = NSPredicate(format:"SELF MATCHES[c] %@", exp)
        let esValido = validar.evaluate(with: txt)
        return esValido
    }
    
    func validarNum(txt:String)-> Bool{
        let exp = "[1-9][0-9]*"
        let validar = NSPredicate(format:"SELF MATCHES[c] %@", exp)
        let esValido = validar.evaluate(with: txt)
        return esValido
    }
    
    func activarBoton(){
        let a = validarNom(txt: Nombre.text!)
        let b = validarNom(txt: Apellido.text!)
        let c = validarEmail(txt: Email.text!)
        let d = validarNom(txt: Pais.text!)
        let e = validarNom(txt: Escuela.text!)
        let f = validarNom(txt: Rama.text!)
        let g = validarNum(txt: Edad.text!)
        
        if a && b && c && d && e && f && g{
            Boton.isEnabled = true
        }
        else {
            Boton.isEnabled = false
        }
    }
    
    @IBAction func Cambio(_ sender: Any) {
        activarBoton()
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

// This is a test line
