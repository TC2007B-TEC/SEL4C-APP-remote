//
//  ActivityLVC+DataSource.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import UIKit


//This isn't working yet
class CustomCollectionViewCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.alpha = 1.0
            } else {
                contentView.alpha = 0.5
            }
        }
    }
}

extension ActivityLVC {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Activity.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Activity.ID>
    
    var reminderCompletedValue: String {
            NSLocalizedString("Completed", comment: "Reminder completed value")
        }
        var reminderNotCompletedValue: String {
            NSLocalizedString("Not completed", comment: "Reminder not completed value")
        }

    func updateSnapshot(reloading ids: [Activity.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(activities.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }

    func cellRegistrationHandler(
        cell:
            UICollectionViewListCell, indexPath: IndexPath, id: Activity.ID
    ) {
        //guard let customCell = cell as? CustomCollectionViewCell else { return }
        let activity = activity(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = activity.title
        contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)
        
        contentConfiguration.secondaryText = activity.notes
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .title3)
        
        cell.contentConfiguration = contentConfiguration

        var doneButtonConfiguration = doneButtonConfiguration(for: activity)
        doneButtonConfiguration.tintColor = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(51) / 255.0, blue: CGFloat(160) / 255.0, alpha: 1.0)
        
        
        
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        
//       var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
//        backgroundConfiguration.backgroundColor = UIColor.lightGray
//        cell.backgroundConfiguration = backgroundConfiguration
        
    }
    
    func activity(withId id: Activity.ID) -> Activity {
        let index = activities.indexOfActivity(withId: id)
        return activities[index]
    }
    
    func updateActivity(_ activity: Activity) {
            let index = activities.indexOfActivity(withId: activity.id)
            activities[index] = activity
        }
    
    func completeActivity(withId id: Activity.ID) {
        var activity = activity(withId: id)
        activity.isComplete.toggle()
        updateActivity(activity)
        updateSnapshot()
    }
    
    private func doneButtonConfiguration(for activity: Activity)
    -> UICellAccessory.CustomViewConfiguration
    {
        let symbolName = activity.isComplete ? "circle.fill" : "circle"
        // Define a custom font size (change the value as needed)
        let fontSize: CGFloat = 35
        
        // Create a symbol configuration with the custom font size
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .regular)
        
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }

    
}
