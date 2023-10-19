//
//  TurninVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 08/10/23.
//

import UIKit
import AVKit
import MobileCoreServices

public protocol TurninVCDelegate: AnyObject {
    func wasTurnedIn()
    func uploadFailed()
}

class TurninVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentPickerDelegate  {
    
    weak var delegate: TurninVCDelegate?
    
    var receivedActivity: String?
    
    @IBOutlet weak var uploadingLbl: UILabel!
    
    //@IBOutlet weak var imageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    let videoPicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        videoPicker.delegate = self
        uploadingLbl.isHidden = true
        self.title = "Entregar"

    }
    
    @IBAction func cameraSelector(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Utilizar camara", message: "Accion a realizar", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Foto", style: .default, handler: { [self] _ in
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Video", style: .default, handler: {[self]  _ in

           videoPicker.sourceType = .camera
           videoPicker.mediaTypes = [kUTTypeMovie as String] // MobileCoreServices
           videoPicker.allowsEditing = false

            self.present(videoPicker, animated: true, completion: nil)
           
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func gallerySelector(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Utilizar galería", message: "Accion a realizar", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Foto", style: .default, handler: { [self] _ in
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Video", style: .default, handler: {[self]  _ in

           videoPicker.sourceType = .photoLibrary
           videoPicker.mediaTypes = [kUTTypeMovie as String] // MobileCoreServices
           videoPicker.allowsEditing = false

            self.present(videoPicker, animated: true, completion: nil)
           
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func fileSelector(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeData)], in: .import)
                documentPicker.delegate = self
                documentPicker.modalPresentationStyle = .formSheet
                present(documentPicker, animated: true, completion: nil)
        
//        let actionSheet = UIAlertController(title: "Subir archivo", message: "Accion a realizar", preferredStyle: .actionSheet)
//        
//        actionSheet.addAction(UIAlertAction(title: "Escribir aqui", style: .default, handler: { [self] _ in
//            //Pantalla para escribir aquí
//            
//            let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "TextInputVC") as! TextInputVC
//
//            //navigationController?.pushViewController(viewController, animated: true)
////            let modalViewController = viewController
////            modalViewController.delegate = self
////            present(viewController, animated: true) {
////                
////                self.wasTurnedIn()
////            }
//            
//        }))
//        
//        actionSheet.addAction(UIAlertAction(title: "Acceder a archivos del iPhone", style: .default, handler: {[self]  _ in
//
//            let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeData)], in: .import)
//                    documentPicker.delegate = self
//                    documentPicker.modalPresentationStyle = .formSheet
//                    present(documentPicker, animated: true, completion: nil)
//                }))
//           
//        
//        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
//        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")!
        
        if let mediaType = info[.mediaType] as? String {
            if mediaType == kUTTypeImage as String {
                // It's an image
                let imageView = info[.originalImage] as? UIImage
                print(imageView!.pngData())
                uploadingLbl.isHidden = false
                
                uploadImageToAPI(name: receivedActivity!, author: email, image: imageView!) { error in
                    if let error = error {
                        print("Error uploading file: \(error)")
                        DispatchQueue.main.async {
                            self.dismiss(animated: true) {
                                self.delegate?.uploadFailed()
                            }
                        }
                    } else {
                        print("File uploaded successfully!")
                        DispatchQueue.main.async {
                            self.dismiss(animated: true) {
                                self.delegate?.wasTurnedIn()
                            }
                        }
                    }
                }
            } else if mediaType == kUTTypeMovie as String {
                // It's a video
                if let videoURL = info[.mediaURL] as? URL {

                    uploadingLbl.isHidden = false
                    uploadVideoToAPI(name: receivedActivity!, author: email, videoURL: videoURL) { error in
                        if let error = error {
                            print("Error uploading video: \(error)")
                            DispatchQueue.main.async {
                                self.dismiss(animated: true) {
                                    self.delegate?.uploadFailed()
                                }
                            }
                        } else {
                            print("Video uploaded successfully!")
                            DispatchQueue.main.async {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        
        do {
            let fileData = try Data(contentsOf: selectedFileURL)
            let mimeType = "application/octet-stream" // Modify this based on the type of file you're uploading
            let filename = selectedFileURL.lastPathComponent
            
            let defaults = UserDefaults.standard
            let email = defaults.string(forKey: "USERNAME")!
            
            uploadFileToAPI(name: receivedActivity!, author: email, fileData: fileData, filename: filename, mimeType: mimeType) { error in
                if let error = error {
                    print("Error uploading file: \(error)")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true) {
                            self.delegate?.uploadFailed()
                        }
                    }
                } else {
                    print("File uploaded successfully!")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true) {
                            self.delegate?.wasTurnedIn()
                        }
                    }
                }
            }
        } catch {
            print("Error reading file data: \(error)")
        }
    }

    
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
        let filename = "\(author)_\(name).png"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
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
    
    func uploadVideoToAPI(name: String, author: String, videoURL: URL, completion: @escaping (Error?) -> Void) {
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
        
        // Load video data
        let videoData: Data
        do {
            videoData = try Data(contentsOf: videoURL)
        } catch {
            print("Failed to load video data: \(error)")
            completion(error)
            return
        }
        
        // Add video data
        let filename = "\(author)_\(name).mov" // Adjust file extension as per your requirement
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: video/quicktime\r\n\r\n")
        body.append(videoData)
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
    
    func uploadFileToAPI(name: String, author: String, fileData: Data, filename: String, mimeType: String, completion: @escaping (Error?) -> Void) {
        // Prepare URL
        let apiUrl = URL(string: "http://20.127.122.6:8000/fileup/")!
        
        // Get the extension from the provided filename
            let fileExtension = (filename as NSString).pathExtension
            
            // Construct the new filename in the desired format
            let newFilename = "\(author)_\(name).\(fileExtension)"
        
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
        
        // Add file data
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(newFilename)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
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

