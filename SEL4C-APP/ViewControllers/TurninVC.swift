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
    
    // CODIGO DE YOUTUBE
    let url: URL = URL(string: "http://127.0.0.1:8000/simple_upload")!
    let boundary: String = "Boundary-\(UUID().uuidString)"
    
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
        
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")!
        
        uploadImageToAPI(name: "A3", author: email, image: imageView.image!) { error in
            if let error = error {
                print("Error uploading file: \(error)")
            } else {
                print("File uploaded successfully!")
            }
        }
        
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
        
        
        
        
        
        
        
//        THIS IS FOR MOLINA'S VERSION
        
//        Task{
//            do{
//                let datos = try await MultipartRequest.sendImage(user: "jose.molina", activity: "activity1", evidence_name: "evidencia1", imagen: imageView.image!)
//                print("se hizo la llamada")
//            }catch{
//                print("falló la llamada")
//            }
//        }
//        let requestBody = self.multipartFormDataBody(self.boundary, "CodeBrah", self.imageArray)
//                let request = self.generateRequest(httpBody: requestBody)
//                
//                URLSession.shared.dataTask(with: request) { data, resp, error in
//                    if let error = error {
//                        print(error)
//                        return
//                    }
//                    
//                    print("success")
//                }.resume()
        
    }
    
    
    
//    private func generateRequest(httpBody: Data) -> URLRequest {
//            var request = URLRequest(url: self.url)
//            request.httpMethod = "POST"
//            request.httpBody = httpBody
//            request.setValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
//            return request
//        }
//        
//        private func multipartFormDataBody(_ boundary: String, _ fromName: String, _ images: [UIImage]) -> Data {
//            
//            let lineBreak = "\r\n"
//            var body = Data()
//            
//            body.append("--\(boundary + lineBreak)")
//            body.append("Content-Disposition: form-data; name=\"fromName\"\(lineBreak + lineBreak)")
//            body.append("\(fromName + lineBreak)")
//            
//            for image in images {
//                if let uuid = UUID().uuidString.components(separatedBy: "-").first {
//                    body.append("--\(boundary + lineBreak)")
//                    body.append("Content-Disposition: form-data; name=\"imageUploads\"; filename=\"\(uuid).jpg\"\(lineBreak)")
//                    body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
//                    body.append(image.jpegData(compressionQuality: 0.99)!)
//                    body.append(lineBreak)
//                }
//            }
//            
//            body.append("--\(boundary)--\(lineBreak)") // End multipart form and return
//            return body
//        }
    
    
    func uploadImageToAPI(name: String, author: String, image: UIImage, completion: @escaping (Error?) -> Void) {
        // Prepare URL
        let apiUrl = URL(string: "http://20.127.122.6:8000/fileup/")!
        
        // Create a request
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        
        // Create boundary for multipart form data
        let boundary = UUID().uuidString
        
        // Set Content-Type header with boundary
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the body of the request
        var body = Data()
        
        // Add name parameter
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n")
        body.append("\(name)\r\n")
        
        // Add author parameter
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"author\"\r\n\r\n")
        body.append("\(author)\r\n")
        
        // Convert image to Data
        guard let imageData = image.pngData() else {
            print("Failed to convert image to data")
            return
        }
        
        // Add image data
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.png\"\r\n")
        body.append("Content-Type: image/png\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        
        // Add closing boundary
        body.append("--\(boundary)--\r\n")
        
        // Set the request body
        request.httpBody = body
        
        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            // Check for response status code
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                let statusCode = httpResponse.statusCode
                completion(NSError(domain: "HTTP Error", code: statusCode, userInfo: nil))
                return
            }
            
            // If everything is successful, call completion with nil error
            completion(nil)
        }
        
        // Start the task
        task.resume()
    }



}
