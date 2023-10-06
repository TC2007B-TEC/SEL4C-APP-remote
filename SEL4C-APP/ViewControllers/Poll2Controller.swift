//
//  Poll2Controller.swift
//  Test
//
//  Created by Román Mauricio Elias Valencia on 06/09/23.
//

import UIKit

class Poll2Controller: UIViewController {
    
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
    
    var psc = 0
    var psh = 0
    var psav = 0
    
    var pcc = 0
    var pch = 0
    var pcav = 0
    
    var pcrc = 0
    var pcrh = 0
    var pcrav = 0

    var pic = 0
    var pih = 0
    var piav = 0
    
    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        var ans = Answer(answer: 0)
            switch answer!{
            case let str where str.contains("Nada de acuerdo"):
                ans.answer = 1
                //print("Nada de acuerdo")
            case let str where str.contains("Poco de acuerdo"):
                ans.answer = 2
                //print("Poco de acuerdo")
            case let str where str.contains("Ni de acuerdo ni desacuerdo"):
                ans.answer = 3
                //print("Ni de acuerdo ni desacuerdo")
            case let str where str.contains("De acuerdo"):
                ans.answer = 4
                //print("De acuerdo")
            default:
                ans.answer = 5
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
                Task{
                    do{
                        try await userResponsesController.insertUserResponses(newUserResponses: userResponses)
                        updateUserResponses(title: "Las respuestas fueron almacenas con éxito en el servidor")
                    }catch{
                        displayErrorUserResponses(UserResponsesError.itemNotFound, title: "No se pudo accer almacenar las respuestas en la base de datos")
                    }
                }
                
               if engine.questionIndex > 0 || engine.questionIndex < 3 {
                   psc += ans.answer
                  print(psc)
               }
                
                else if engine.questionIndex > 2 || engine.questionIndex < 5 {
                    psh += ans.answer
                   print(psh)
                }
                
                else if engine.questionIndex > 4 || engine.questionIndex < 7 {
                    psav += ans.answer
                   print(psav)
                }
                //----
                else if engine.questionIndex > 6 || engine.questionIndex < 10 {
                    pcc += ans.answer
                   print(pcc)
                }
                 
                 else if engine.questionIndex > 9 || engine.questionIndex < 13 {
                     pch += ans.answer
                    print(pch)
                 }
                 
                 else if engine.questionIndex == 13 {
                     pcav += ans.answer
                    print(pcav)
                 }
                //----
                else if engine.questionIndex > 13 || engine.questionIndex < 16 {
                    pcrc += ans.answer
                   print(pcrc)
                }
                 
                 else if engine.questionIndex > 15 || engine.questionIndex < 18 {
                     pcrh += ans.answer
                    print(pcrh)
                 }
                 
                 else if engine.questionIndex > 17 || engine.questionIndex < 20 {
                     pcrav += ans.answer
                    print(pcrav)
                 }
                //----
                else if engine.questionIndex > 19 || engine.questionIndex < 22 {
                    pic += ans.answer
                   print(pic)
                }
                 
                 else if engine.questionIndex > 21 || engine.questionIndex < 25 {
                     pih += ans.answer
                    print(pih)
                 }
                 
                 else if engine.questionIndex == 25 {
                     piav += ans.answer
                    print(piav)
                 } 
                
                //--
               
                if engine.questionIndex == 24 {
                    // Cambiar a "Poll2Segue" después de la pregunta 24
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
        
        var engine = EcomplexityEngine(isSecondPart: true) // Comienza en la segunda parte
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            progress.progress = engine.getProgress()
            text.text = engine.getText()
            text2.text = engine.getText2()
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
