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
            let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad2")
            navigationController?.pushViewController(viewController, animated: true)
        } else if title == "Actividad 3"  {
           let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad3")
           navigationController?.pushViewController(viewController, animated: true)
        } else if title == "Actividad 4"  {
           let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "Actividad4")
           navigationController?.pushViewController(viewController, animated: true)
        } else if title == "Actividad Final"  {
           let viewController = UIStoryboard(name: "Activity", bundle: nil).instantiateViewController(withIdentifier: "ActividadFinal")
           navigationController?.pushViewController(viewController, animated: true)}
//        } else  {
//            let viewController = ActivityVC(activity: activity)
//            navigationController?.pushViewController(viewController, animated: true)
//        }
    }
    


    private func listLayout() -> UICollectionViewCompositionalLayout {
//        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = true
        //listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    
    func setupNavBar() {
        navigationItem.title = "Actividades Test"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(51) / 255.0, blue: CGFloat(160) / 255.0, alpha: 1.0)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
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
