//
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
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Password2: UITextField!
    @IBOutlet weak var Edad: UITextField!
    @IBOutlet weak var Pais: UITextField!
    @IBOutlet weak var Escuela: UITextField!
    @IBOutlet weak var Rama: UITextField!
    @IBOutlet weak var Boton: UIButton!
    @IBOutlet weak var Show1: UIButton!
    @IBOutlet weak var Show2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Boton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    

    func validarNom(txt:String)-> Bool{
        let exp = "[a-z A-Z]+"
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
        let a = validarNom(txt: Nombre.text!)
        let b = validarNom(txt: Apellido.text!)
        let c = validarEmail(txt: Email.text!)
        let d = validarNom(txt: Pais.text!)
        let e = validarNom(txt: Escuela.text!)
        let f = validarNom(txt: Rama.text!)
        let g = validarNum(txt: Edad.text!)
        let h = validarPassEqual()
        let i = validarPassword(txt: Password.text!)
        
        if a && b && c && d && e && f && g && h && i{
            Boton.isEnabled = true
        }
        else {
            Boton.isEnabled = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    @IBAction func PassChange(_ sender: Any) {
        let rojo = UIColor.init(red: 0.988, green: 0.847, blue: 0.847, alpha: 1)
        let naranja = UIColor.init(red: 1, green: 0.882, blue: 0.749, alpha: 1)
        let amarillo = UIColor.init(red: 1, green: 0.957, blue: 0.749, alpha: 1)
        let verde = UIColor.init(red: 0.882, green: 1, blue: 0.749, alpha: 1)
        
        let n = passStrenght(txt: Password.text!)
        print(n)
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
}
