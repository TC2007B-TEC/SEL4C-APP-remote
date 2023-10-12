//
//  ActivityVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//


//THIS IS A ActivityCVC (UI collection view controller)
// lIST VIEW CONTROLLER?

import UIKit

class ActivityLVC: UICollectionViewController {
    var dataSource: DataSource!
    var activities: [Activity] = Activity.sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Activity.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        
        collectionView.dataSource = dataSource
        
        setupNavBar()
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        
        
        updateSnapshot()
    }
    
    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let id = activities[indexPath.item].id
        pushDetailViewForActivity(withId: id)
        return false
    }


//    func pushDetailViewForActivity(withId id: Activity.ID) {
//        let activity = activity(withId: id)
//        
//        let viewController = ActivityVC(activity: activity)
//        navigationController?.pushViewController(viewController, animated: true)
//
//    }
    
    func pushDetailViewForActivity(withId id: Activity.ID) {
        let activity = activity(withId: id)
        let title = activity.title
        
        if title == "" {
            
        } else if title == "Actividad 1"  {
            let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad1")
            navigationController?.pushViewController(viewController, animated: true)
        } else if title == "Actividad 2"  {
            wasTurnedIn(actName: "A1_3") { success in
                if success {
                    let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2")
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alerta, animated: true)
                }
            }
        } else if title == "Actividad 3"  {
            wasTurnedIn(actName: "A2_3") { success in
                if success {
                    let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad3")
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alerta, animated: true)
                }
            }
        } else if title == "Actividad 4"  {
            wasTurnedIn(actName: "A3_2") { success in
                if success {
                    let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad4")
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alerta, animated: true)
                }
            }
        } else if title == "Actividad Final"  {
            wasTurnedIn(actName: "A4") { success in
                if success {
                    let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "ActividadFinal")
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alerta, animated: true)
                }
            }

            
        } else if title == "Perfil Final"  {
            wasTurnedIn(actName: "A5") { success in
                if success {
                    
                    let defaults = UserDefaults.standard
                    let email = defaults.string(forKey: "USERNAME")!
                    let test1Completado = self.verificarTest(testType: "F2", usuario: email)
                    self.group.wait()
                    
                    if !test1Completado{
                        let viewController = UIStoryboard(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "testID")
                        viewController.hidesBottomBarWhenPushed =  true
                        
                        // Use presentViewController to present the view controller modally
                        self.navigationController?.pushViewController(viewController, animated: true)
                    } else {
                            let alerta = UIAlertController(title: "Ya se ha resuleto", message: "Para consultar resultados acceder al perfil", preferredStyle: .alert)
                            alerta.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alerta, animated: true)
                        }
                        
                } else {
                    let alerta = UIAlertController(title: "No tienes accesso", message: "Primero tienes que terminar las actividades anteriores", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alerta, animated: true)
                }
                
                
                
                
                    
                }
            }

//        } else  {
//            let viewController = ActivityVC(activity: activity)
//            navigationController?.pushViewController(viewController, animated: true)
//        }
    }
    
    func wasTurnedIn(actName: String, completion: @escaping (Bool) -> Void) {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "USERNAME")!

        ActivityDoneAPI.shared.getAPI(email: email, name: actName) { [weak self] success in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }

    
    private func listLayout() -> UICollectionViewCompositionalLayout {
//        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = true
        //listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    
    func setupNavBar() {
        navigationItem.title = "Actividades"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(51) / 255.0, blue: CGFloat(160) / 255.0, alpha: 1.0)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
    }
    

    
    var group = DispatchGroup()
    func verificarTest(testType: String, usuario: String) -> Bool {
        var respuesta = false
        // Construye la URL con los parámetros
        let baseUrl = "http://20.127.122.6:8000/getpreguntas/?"
        let parameters = "test_type=\(testType)&usuario=\(usuario)"
        if let url = URL(string: baseUrl + parameters) {
            // Crea la sesión de URLSession
            group.enter()
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error al realizar la solicitud: \(error)")
                    return
                }
                
                if let data = data {
                    // Procesa los datos de la respuesta
                    if let result = String(data: data, encoding: .utf8) {
                        print("Respuesta: \(result)")
                        if result != "{\"message\":\"No se encontraron preguntas\"}" {
                            respuesta = true
                        }
                    } else {
                        print("No se pudo decodificar la respuesta")
                    }
                }
                self.group.leave()
            }
            // Inicia la tarea
            task.resume()
            group.wait()
            return respuesta
        } else {
            print("URL no válida")
        }
        return respuesta
    }
    
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


