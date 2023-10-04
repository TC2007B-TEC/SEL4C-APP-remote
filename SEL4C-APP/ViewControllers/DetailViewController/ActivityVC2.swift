//
//  ActivityVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import UIKit


class   ActivityVC2: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>
    
    var activity: Activity
    private var dataSource: DataSource!


//    init(activity: Activity) {
//        self.activity = activity
//        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        listConfiguration.showsSeparators = false
//        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
//        super.init(collectionViewLayout: listLayout)
//    }
    
    init(activity: Activity) {
        self.activity = activity
        let storyboard = UIStoryboard(name: "Activity", bundle: nil) // "Main" is the name of the storyboard, change it if needed
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped)))
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ActivityTest") as? ActivityVC2 else {
            fatalError("Could not instantiate view controller from storyboard")
        }
        
        self.title = vc.title
        self.dataSource = vc.dataSource
    }


    required init?(coder: NSCoder) {
        fatalError("Always initialize ActivityViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
            dataSource = DataSource(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration, for: indexPath, item: itemIdentifier)
            }

            if #available(iOS 16, *) {
                navigationItem.style = .navigator
            }
            navigationItem.title = NSLocalizedString("Activity", comment: "Activity view controller title")

            updateSnapshot()
        }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = UIColor.systemPurple
    }
    
    func text(for row: Row) -> String? {
           switch row {
           //case .date: return activity.dueDate.dayText
           case .date: return activity.title
           case .notes: return activity.title
           //case .time: return activity.dueDate.formatted(date: .omitted, time: .shortened)
           case .time: return activity.title
           case .title: return activity.title
           }
       }
    
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
        dataSource.apply(snapshot)
    }
}