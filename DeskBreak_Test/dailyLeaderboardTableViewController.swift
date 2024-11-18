//
//  dailyLeaderboardTableViewController.swift
//  DeskBreak_Test
//
//  Created by admin33 on 03/10/24.
//

import UIKit

class dailyLeaderboardTableViewController: UITableViewController {
    
    var peoples: [People] = [
        People(name: "Akshat Dutt Kaushik", description: "1", points: "3020", picture: "7"),
        People(name: "Swati Swapna", description: "2", points: "2080", picture: "7"),
        People(name: "Vansh Bhatia", description: "3", points: "2680", picture: "7"),
        People(name: "Ravi Kumar", description: "4", points: "2500", picture: "7"),
        People(name: "Neha Sharma", description: "5", points: "2200", picture: "7"),
        People(name: "Priya Rajan", description: "6", points: "2000", picture: "7"),
        People(name: "Ankit Mehta", description: "7", points: "1500", picture: "7"),
    ]
    
    override func loadView() {
        // Make sure the view is set to a UITableView
        self.view = UITableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peoples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath)

//        print(indexPath)
        let people = peoples[indexPath.row]
        
//        cell.textLabel?.text = "\(food.name)"
//        cell.detailTextLabel?.text = "\(food.description)"
        
        var content = cell.defaultContentConfiguration()
        
        content.text = people.name
        content.secondaryText = people.description
//        content.image = UIImage(named: "Cauliflower-Shawarma_8-500x500")
        
        cell.contentConfiguration = content
        cell.showsReorderControl = true
        
        cell.accessoryType = .detailButton

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
