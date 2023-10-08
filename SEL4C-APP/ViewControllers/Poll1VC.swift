//
//  ViewController.swift
//  Test
//
//  Created by Román Mauricio Elias Valencia on 04/09/23.
//

import UIKit

class Poll1VC: UIViewController {

    @IBOutlet weak var text: UILabel!
    
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var ma_button: UIButton!
    
    @IBOutlet weak var da_button: UIButton!
    
    @IBOutlet weak var nand_button: UIButton!
    
    @IBOutlet weak var pa_button: UIButton!
    
    @IBOutlet weak var na_button: UIButton!
    
    @IBOutlet weak var progress: UIProgressView!
    
    var userResponses = UserResponses()
    var userResponsesController = UserResponsesController()
    var email: String?
    
    var autocResul = 0
    var liderResul = 0
    var concResul = 0
    var innoResul = 0
 
    var respuestas = [Int]()

    func sendTestJSON() {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")
        
        let data = [
            "test_type": "Diagnostico 1",
            "usuario": email
        ] as [String: Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        sendJSONData(jsonData, to: "http://20.127.122.6:8000/newtest/") { result in
            switch result {
            case .success:
                print("JSON para nuevo test enviado con éxito")
            case .failure(let error):
                print("Error al enviar JSON para nuevo test: \(error)")
            }
        }
    }

    func sendQuestionJSON(idpregunta: Int, respuesta: Int) {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")
        
        let data = [
            "idpregunta": idpregunta,
            "usuario": email,
            "test_type": "Diagnostico 1",
            "resp": respuesta

        ] as [String: Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        sendJSONData(jsonData, to: "http://20.127.122.6:8000/newpregunta/") { result in
            switch result {
            case .success:
                print("JSON para nueva pregunta enviado con éxito")
            case .failure(let error):
                print("Error al enviar JSON para nueva pregunta: \(error)")
            }
        }
    }

    func sendJSONData(_ jsonData: Data, to urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(UserResponsesError.itemNotFound))
            }
        }.resume()
    }
    
    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        var ans = Answer(answer: 0)
            switch answer!{
            case let str where str.contains("Nada de acuerdo"):
                ans.answer = 1
                respuestas.append(1)
                //print("Nada de acuerdo")
            case let str where str.contains("Poco de acuerdo"):
                ans.answer = 2
                respuestas.append(2)
                //print("Poco de acuerdo")
            case let str where str.contains("Ni de acuerdo ni desacuerdo"):
                ans.answer = 3
                respuestas.append(3)
                //print("Ni de acuerdo ni desacuerdo")
            case let str where str.contains("De acuerdo"):
                ans.answer = 4
                respuestas.append(4)
                //print("De acuerdo")
            default:
                ans.answer = 5
                respuestas.append(5)
                //print("Muy de acuerdo")
            }
            //sender.backgroundColor = UIColor.purple
            userResponses.responses.append(ans)
            da_button.isEnabled = false
            nand_button.isEnabled = false
            ma_button.isEnabled = false
            na_button.isEnabled = false
            pa_button.isEnabled = false
            
        
        if engine.nextQuestion() {
            
            if engine.questionIndex > 0 || engine.questionIndex < 5 {
                autocResul += ans.answer
               print(autocResul)
            }
             
             else if engine.questionIndex > 4 || engine.questionIndex < 11 {
                 liderResul += ans.answer
                print(liderResul)
             }
             
             else if engine.questionIndex > 10 || engine.questionIndex < 18 {
                 concResul += ans.answer
                print(concResul)
             }
             else if engine.questionIndex > 17 || engine.questionIndex < 25 {
                 innoResul += ans.answer
                print(innoResul)
             }
            
            if engine.questionIndex == 24 {
                for i in 0..<respuestas.count {
                    let namepregunta = text.text!
                    let idpregunta = i
                    let respuesta = respuestas[i]
                    sendQuestionJSON(idpregunta: idpregunta, respuesta: respuesta)
                }
                performSegue(withIdentifier: "Poll2Segue", sender: self)
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
            } else if engine.questionIndex == 47 {
                // Cambiar a "ResultadosSegue" después de la pregunta 49
                performSegue(withIdentifier: "ResultadosSegue", sender: self)
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
            } else {
                // Agregar un temporizador después de cambiar de pregunta en otros casos
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
            }
        } else {
            // Agregar un temporizador en el caso del else
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
        }

    }
    
    var engine = EcomplexityEngine(isSecondPart: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progress.progress = engine.getProgress()
        text.text = engine.getText()
        text2.text = engine.getText2()
        sendTestJSON()
    }
    
    func updateUserResponses(title: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: "Datos almacenados con éxito", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default)
            alert.addAction(continueAction)
            self.present(alert,animated: true)
        }
    }
    func displayErrorUserResponses(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    @objc func nextQuestion(){
        text.text = engine.getText()
        text2.text = engine.getText2()
        progress.progress = engine.getProgress()
        da_button.backgroundColor = UIColor.white
        nand_button.backgroundColor = UIColor.white
        ma_button.backgroundColor = UIColor.white
        na_button.backgroundColor = UIColor.white
        pa_button.backgroundColor = UIColor.white
        
        da_button.isEnabled = true
        nand_button.isEnabled = true
        ma_button.isEnabled = true
        na_button.isEnabled = true
        pa_button.isEnabled = true
    }
}

