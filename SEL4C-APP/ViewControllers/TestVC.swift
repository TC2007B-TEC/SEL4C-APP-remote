//
//  ViewController.swift
//  Test
//
//  Created by Román Mauricio Elias Valencia on 04/09/23.
//

import UIKit

class TestVC: UIViewController {

    @IBOutlet weak var text: UILabel!
    
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var ma_button: UIButton!
    
    @IBOutlet weak var da_button: UIButton!
    
    @IBOutlet weak var nand_button: UIButton!
    
    @IBOutlet weak var pa_button: UIButton!
    
    @IBOutlet weak var na_button: UIButton!
    
    @IBOutlet weak var progress: UIProgressView!
    
 
    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        switch answer!{
        case let str where str.contains("Nada de acuerdo"):
            print("Nada de acuerdo")
        case let str where str.contains("Poco de acuerdo"):
            print("Poco de acuerdo")
        case let str where str.contains("Ni de acuerdo ni desacuerdo"):
            print("Ni de acuerdo ni desacuerdo")
        case let str where str.contains("De acuerdo"):
            print("De acuerdo")
        default:
            print("Muy de acuerdo")
        }
        //sender.backgroundColor = UIColor.purple
        da_button.isEnabled = false
        nand_button.isEnabled = false
        ma_button.isEnabled = false
        na_button.isEnabled = false
        pa_button.isEnabled = false
        
        if engine.nextQuestion() {
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
    
    var engine = EcomplexityEngine(isSecondPart: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progress.progress = engine.getProgress()
        text.text = engine.getText()
        text2.text = engine.getText2()
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
