//
//  communityViewController.swift
//  DeskBreak_Test
//
//  Created by admin33 on 03/10/24.
//

import UIKit

class communityViewController: UIViewController {
    
    @IBOutlet weak var communityTable: UITableView!
    
    public var communities = [
        Community(
            name: "Family",
            icon: "person.3",
            code: "5668",
            members: [
                Member(id: 1, name: "Alice", details: "Loves cooking and reading.", profilePic: "a"),
                Member(id: 2, name: "Bob", details: "Enjoys hiking and photography.", profilePic: "b")
            ]
        ),
        Community(
            name: "Friends",
            icon: "person.3.fill",
            code: "3346",
            members: [
                Member(id: 3, name: "Charlie", details: "Musician and artist.", profilePic: "c"),
                Member(id: 4, name: "Daisy", details: "Sports enthusiast and gamer.", profilePic: "d")
            ]
        ),
        Community(
            name: "Apple",
            icon: "applelogo",
            code: "4456",
            members: [
                Member(id: 5, name: "Eve", details: "Tech enthusiast and developer.", profilePic: "e"),
                Member(id: 6, name: "Frank", details: "iOS developer and designer.", profilePic: "f")
            ]
        )
    ]
    
    @IBAction func unwindToCommunity(segue : UIStoryboardSegue){
        
    }
    
    @IBAction func addCommunityButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // Segmented Control
        let segmentedControl = UISegmentedControl(items: ["Create", "Join"])
        segmentedControl.selectedSegmentIndex = 0
        alertController.view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 15),
            segmentedControl.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Text Field
        alertController.addTextField { textField in
            textField.placeholder = "Enter community name"
            textField.clearButtonMode = .whileEditing
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.keyboardType = .default
        }
        
        // Done Action
        let doneAction = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            guard let self = self, let textFieldInput = alertController.textFields?.first?.text, !textFieldInput.isEmpty else { return }
            
            if segmentedControl.selectedSegmentIndex == 0 {
                // Handle creating a community
                let randomCode = Int.random(in: 1000...9999)
                let newCommunity = Community(
                    name: textFieldInput,
                    icon: "person.3.fill",
                    code: String(randomCode),
                    members: []
                )
                self.communities.append(newCommunity)
                self.communityTable.reloadData()
                self.showAlert(title: "Community Created", message: "Your community code is \(randomCode)")
                
            } else {
                // Handle joining a community by matching code
                if let matchingCommunityIndex = self.communities.firstIndex(where: { $0.code == textFieldInput }) {
                    let newMember = Member(id: self.communities[matchingCommunityIndex].members.count + 1, name: "New Member", details: "Joined recently", profilePic: "h")
                    
                    // Add new member to the matching community
                    self.communities[matchingCommunityIndex].members.append(newMember)
                    self.communityTable.reloadData()
                    self.showAlert(title: "Joined Community", message: "You have joined \(self.communities[matchingCommunityIndex].name)")
                    
                } else {
                    // Show alert if code does not match any community
                    self.showAlert(title: "Error", message: "Community code not found")
                }
            }
        }
        
        // Cancel Action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(doneAction)
        alertController.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        present(alertController, animated: true, completion: nil)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let alertController = presentedViewController as? UIAlertController else { return }
        alertController.textFields?.first?.placeholder = sender.selectedSegmentIndex == 0 ? "Enter community name" : "Enter community code"
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityTable.delegate = self
        communityTable.dataSource = self
        communityTable.backgroundColor = .bg
       
    }
    
    
}

extension communityViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell", for: indexPath)

        let communityItem = communities[indexPath.row]

        // Configure the cell
        cell.textLabel?.text = communityItem.name
        cell.textLabel?.textColor = .systemBlue
        cell.imageView?.image = UIImage(systemName: communityItem.icon)
        cell.imageView?.image = UIImage(systemName: communityItem.icon)?.withTintColor(.gray, renderingMode: .alwaysOriginal)

        cell.contentView.layer.masksToBounds = true
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .card

        // Chevron accessory
        let chevronImage = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronImage.tintColor = .systemGray
        cell.accessoryView = chevronImage

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.1)
        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "showCommunityDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .bg
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommunityDetailsViewController,
           let indexPath = communityTable.indexPathForSelectedRow {
           destination.community = communities[indexPath.row]
        }
    }

}
