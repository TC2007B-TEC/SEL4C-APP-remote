//
//  ActivitiesTVC.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import UIKit

class ActivitiesTVC: UITableViewController {
    
    struct Emoji {
        let symbol: String
        let name: String
        let description: String
        let usage: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // MARK: - Table view data source
    
    var emojis: [Emoji] = [
        Emoji(symbol: "✅", name: "Actividad 1", description: "Identificación", usage: "happiness"),
        Emoji(symbol: "✅", name: "Actividad 2", description: "Investigación", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "❌", name: "Actividad 3", description: "Ideación", usage: "love of something; attractive"),
        Emoji(symbol: "❌", name: "Actividad 4", description: "Socialización", usage: "apps, software, programming"),
        Emoji(symbol: "❌", name: "Entrega Final", description: "", usage: "something slow"),
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // You have one section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count // The number of rows is equal to the number of emojis in your array
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 110
        
        //Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! CustomTableViewCell

        //Step 2: Fetch model object to display
        let emoji = emojis[indexPath.row]


        cell.symbolLabel.text = emoji.symbol
        cell.nameLabel.text = emoji.name
        cell.descriptionLabel.text = emoji.description
        
        //Step 3: Configure cell
        //cell.update(with: emoji)
        cell.showsReorderControl = true

        //Step 4: Return cell
        return cell
    }
    
    
            
    




    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
