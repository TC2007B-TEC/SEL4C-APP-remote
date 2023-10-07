
//  RegisterViewController.swift
//  SEL4C
//
//  Created by Jesús Alexander Meister Careaga on 04/09/23.
//

import UIKit

class RegisterVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == edadPicker {return edades.count}
        if pickerView == paisPicker {return paises.count}
        if pickerView == ramaPicker {return ramas.count}
        if pickerView == generoPicker {return generos.count}
        if pickerView == escuelaPicker {return escuelas.count}
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == edadPicker {return edades[row]}
        if pickerView == paisPicker {return paises[row]}
        if pickerView == ramaPicker {return ramas[row]}
        if pickerView == generoPicker {return generos[row]}
        if pickerView == escuelaPicker {return escuelas[row]}
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == edadPicker {Edad.text = edades[row]; activarBoton()}
        if pickerView == paisPicker {Pais.text = paises[row]; activarBoton()}
        if pickerView == ramaPicker {Rama.text = ramas[row]}
        if pickerView == generoPicker {Genero.text = generos[row]; activarBoton()}
        if pickerView == escuelaPicker {Escuela.text = escuelas[row]; activarBoton()}
    }
    
    @IBOutlet weak var Nombre: UITextField!
    @IBOutlet weak var Apellido: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Genero: UITextField!
    @IBOutlet weak var Edad: UITextField!
    @IBOutlet weak var Pais: UITextField!
    @IBOutlet weak var Escuela: UITextField!
    @IBOutlet weak var Rama: UITextField!
    @IBOutlet weak var Boton: UIButton!

    let edades = ["18-25", "25-30", "30-35", "40-45", "50+"]
    let paises = ["México", "Afganistán","Albania","Alemania","Andorra","Angola","Antigua y Barbuda","Arabia Saudita","Argelia","Argentina","Armenia","Australia","Austria","Azerbaiyán","Bahamas","Bangladés","Barbados","Baréin","Bélgica","Belice","Benín","Bielorrusia","Birmania","Bolivia","Bosnia y Herzegovina","Botsuana","Brasil","Brunéi","Bulgaria","Burkina Faso","Burundi","Bután","Cabo Verde","Camboya","Camerún","Canadá","Catar","Chad","Chile","China","Chipre","Colombia","Comoras","Corea del Norte","Corea del Sur","Costa de Marfil","Costa Rica","Croacia","Cuba","Dinamarca","Dominica","Ecuador","Egipto","El Salvador","Emiratos Árabes Unidos","Eritrea","Eslovaquia","Eslovenia","España","Estados Unidos","Estonia","Etiopía","Filipinas","Finlandia","Fiyi","Francia","Gabón","Gambia","Georgia","Ghana","Granada","Grecia","Guatemala","Guyana","Guinea","Guinea-Bisáu","Guinea Ecuatorial","Haití","Honduras","Hungría","India","Indonesia","Irak","Irán","Irlanda","Islandia","Islas Marshall","Islas Salomón","Israel","Italia","Jamaica","Japón","Jordania","Kazajistán","Kenia","Kirguistán","Kiribati","Kuwait","Laos","Lesoto","Letonia","Líbano","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Madagascar","Malasia","Malaui","Maldivas","Malí","Malta","Marruecos","Mauricio","Mauritania","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Mozambique","Namibia","Nauru","Nepal","Nicaragua","Níger","Nigeria","Noruega","Nueva Zelanda","Omán","Países Bajos","Pakistán","Palaos","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Polonia","Portugal","Reino Unido","República Centroafricana","República Checa","República del Congo","República Democrática del Congo","República Dominicana","Ruanda","Rumania","Rusia","Samoa","San Cristóbal y Nieves","San Marino","Santa Lucía","Santa Vicente y las Granadinas","Santo Tomé y Príncipe","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Siria","Somalia","Sri Lanka","Suazilandia","Sudáfrica","Sudán","Sudán del Sur","Suecia","Suiza","Surinam","Tailandia","Tanzania","Tayikistán","Timor Oriental","Togo","Tonga","Trinidad y Tobago","Túnez","Turkmenistán","Turquía","Tuvalu","Ucrania","Uganda","Uruguay","Uzbekistán","Vanuatu","Vaticano","Venezuela","Vietnam","Yemen","Yibuti","Zambia","Zimbabue"]
    let ramas = ["Ambiente Construido", "Derecho, Economía y Relaciones Internacionales", "Estudios Creativos", "Ingeniería y Ciencias", "Negocios", "Salud"]
    let generos = ["Maculino", "Femenino", "No binario", "Otro", "Prefiero no decirlo"]
    let escuelas = ["Tecnológico de Monterrey", "Otros"]
    
    var edadPicker = UIPickerView()
    var paisPicker = UIPickerView()
    var ramaPicker = UIPickerView()
    var generoPicker = UIPickerView()
    var escuelaPicker = UIPickerView()
    var subViews = [UIView()]
    var toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        Boton.isEnabled = false
        
        edadPicker.delegate = self
        edadPicker.dataSource = self
        edadPicker.backgroundColor = UIColor.white
        edadPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        paisPicker.delegate = self
        paisPicker.dataSource = self
        paisPicker.backgroundColor = UIColor.white
        paisPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        ramaPicker.delegate = self
        ramaPicker.dataSource = self
        ramaPicker.backgroundColor = UIColor.white
        ramaPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        generoPicker.delegate = self
        generoPicker.dataSource = self
        generoPicker.backgroundColor = UIColor.white
        generoPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        escuelaPicker.delegate = self
        escuelaPicker.dataSource = self
        escuelaPicker.backgroundColor = UIColor.white
        escuelaPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
    
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "OK", style: .done, target: self, action: #selector(cerrarToolbar))]
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContinueSegue" {
            let PasswordVC = segue.destination as! PasswordVC
            PasswordVC.nombre = Nombre.text!
            PasswordVC.apellido = Apellido.text!
            PasswordVC.email = Email.text!
            PasswordVC.genero = Genero.text!
            PasswordVC.edad = Edad.text!
            PasswordVC.pais = Pais.text!
            PasswordVC.escuela = Escuela.text!
            PasswordVC.rama = Rama.text!
        }
    }
    
    @objc func cerrarToolbar() {
        for view in subViews{
            view.removeFromSuperview()
        }
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
        let d = validarNom(txt: Escuela.text!)
        
        if a && b && c && d{
            Boton.isEnabled = true
        }
        else {
            Boton.isEnabled = false
        }
    }
    
    @IBAction func Cambio(_ sender: Any) {
        activarBoton()
    }
    
    @IBAction func edadButton(_ sender: Any) {
        self.view.addSubview(edadPicker)
        self.view.addSubview(toolBar)
        subViews.append(edadPicker)
        subViews.append(toolBar)
    }
    
    @IBAction func paisButton(_ sender: Any) {
        self.view.addSubview(paisPicker)
        self.view.addSubview(toolBar)
        subViews.append(paisPicker)
        subViews.append(toolBar)
    }
    
    @IBAction func ramaButton(_ sender: Any) {
        self.view.addSubview(ramaPicker)
        self.view.addSubview(toolBar)
        subViews.append(ramaPicker)
        subViews.append(toolBar)
    }
    
    @IBAction func generoButton(_ sender: Any) {
        self.view.addSubview(generoPicker)
        self.view.addSubview(toolBar)
        subViews.append(generoPicker)
        subViews.append(toolBar)
    }
    
    @IBAction func escuelaButton(_ sender: Any) {
        self.view.addSubview(escuelaPicker)
        self.view.addSubview(toolBar)
        subViews.append(escuelaPicker)
        subViews.append(toolBar)
    }
    
    
    @IBAction func ButtonContinue(_ sender: Any) {
        self.performSegue(withIdentifier: "ContinueSegue", sender: self)
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
