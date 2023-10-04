//
//  ActivityVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import UIKit


class   ActivityVC: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var activity: Activity
    private var dataSource: DataSource!


    init(activity: Activity) {
        self.activity = activity
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
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
            navigationItem.rightBarButtonItem = editButtonItem

            updateSnapshotForViewing()
        }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            if editing {
                updateSnapshotForEditing()
            } else {
                updateSnapshotForViewing()
            }
        }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
            let section = section(for: indexPath)
            switch (section, row) {
            case (.view, _):
                var contentConfiguration = cell.defaultContentConfiguration()
                contentConfiguration.text = text(for: row)
                contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
                contentConfiguration.image = row.image
                cell.contentConfiguration = contentConfiguration
                cell.tintColor = UIColor.systemBlue
            default:
                fatalError("Unexpected combination of section and row.")
            }
            cell.tintColor = UIColor.systemPurple
        }
    
    func text(for row: Row) -> String? {
           switch row {
           //case .date: return activity.dueDate.dayText
           case .date: return activity.notes
           case .notes: return activity.notes
           //case .time: return activity.dueDate.formatted(date: .omitted, time: .shortened)
           case .time: return activity.notes
           case .title: return activity.title
           }
       }
    
    private func updateSnapshotForEditing() {
            var snapshot = Snapshot()
            snapshot.appendSections([.title, .date, .notes])
            dataSource.apply(snapshot)
        }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
            let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
            guard let section = Section(rawValue: sectionNumber) else {
                fatalError("Unable to find matching section")
            }
            return section
        }
}
