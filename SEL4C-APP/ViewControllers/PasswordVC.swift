//
//  PasswordViewController.swift
//  SEL4C
//
//  Created by Jesús Alexander Meister Careaga on 06/09/23.
//

import UIKit

class PasswordVC: UIViewController {

    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Password2: UITextField!
    @IBOutlet weak var Boton: UIButton!
    @IBOutlet weak var Show1: UIButton!
    @IBOutlet weak var Show2: UIButton!
    @IBOutlet weak var TermsButton: UIButton!
    @IBOutlet weak var PrivacyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var terms = false
    let si = UIImage(systemName: "square.fill")
    let no = UIImage(systemName: "square")
    @IBAction func ChangeTerms(_ sender: Any) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
