//
//  TurninVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 08/10/23.
//

import UIKit
import AVKit
import MobileCoreServices


class TurninVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraSelector(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Utilizar camara", message: "Accion a realizar", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Foto", style: .default, handler: { [self] _ in
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Video", style: .default, handler: { _ in
            
            print("Camera Available")

           let videoPicker = UIImagePickerController()
           videoPicker.delegate = self
           videoPicker.sourceType = .camera
           videoPicker.mediaTypes = [kUTTypeMovie as String] // MobileCoreServices
           videoPicker.allowsEditing = false

            self.present(videoPicker, animated: true, completion: nil)
           
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        imageView.image = info[.originalImage] as? UIImage
        print(imageView.image?.pngData())
    }
    
    @IBAction func guardarImagen(_ sender: Any) {
        saveImage(imageName: "test.png")
    }
    
    func saveImage(imageName: String) {
        //Crear instancia del FileManager
        let fileManager = FileManager.default
        //Obtener el path de la imagen
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as NSString).appendingPathComponent(imageName)
        //obtener la imagen que tomamos con la cámara
        let image = imageView.image!
        //Obtener los datos PNG de la imagen
        let data = image.pngData()
        fileManager.createFile(atPath: imagePath, contents: data, attributes: nil)
        
        Task{
            do{
                let datos = try await MultipartRequest.sendImage(user: "jose.molina", activity: "activity1", evidence_name: "evidencia1", imagen: imageView.image!)
                print("se hizo la llamada")
            }catch{
                print("falló la llamada")
            }
        }
    }

}
