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

        updateSnapshot()
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let id = activities[indexPath.item].id
        pushDetailViewForActivity(withId: id)
        return false
    }


    func pushDetailViewForActivity(withId id: Activity.ID) {
        let activity = activity(withId: id)
        let viewController = ActivityVC(activity: activity)
        navigationController?.pushViewController(viewController, animated: true)
    }
    


    private func listLayout() -> UICollectionViewCompositionalLayout {
//        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = true
        //listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
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
