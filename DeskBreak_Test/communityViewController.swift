//
//  communityViewController.swift
//  DeskBreak_Test
//
//  Created by admin33 on 03/10/24.
//

import UIKit

class communityViewController: UIViewController {
    
    @IBOutlet weak var communityTable: UITableView!
    
//    public var communities: [Community] = [
//        Community(
//            name: "Fitness Enthusiasts",
//            icon: "person.3.fill",
//            code: "1234",
//            members: [
//                sampleUsers[0], // Akshat
//                sampleUsers[1]  // Vansh
//            ]
//        ),
//        Community(
//            name: "Yoga Lovers",
//            icon: "person.3.fill",
//            code: "5678",
//            members: [
//                sampleUsers[2],
//                sampleUsers[0]
//            ]
//        ),
//        Community(
//            name: "Adventure Seekers",
//            icon: "mountain.2.fill",
//            code: "9101",
//            members: [
//                sampleUsers[1], // Vansh
//                sampleUsers[2]  // Swati
//            ]
//        ),
//        Community(
//            name: "Tech Innovators",
//            icon: "laptopcomputer",
//            code: "1122",
//            members: [
//                sampleUsers[0], // Akshat
//                sampleUsers[1]
//            ]
//        ),
//        Community(
//            name: "Creative Minds",
//            icon: "paintbrush.fill",
//            code: "3344",
//            members: [
//                sampleUsers[2],
//                sampleUsers[1]
//            ]
//        )
//    ]
    
//    var currentUser = Person(
//        name: "Akshat Dutt Kaushik",
//        age: 21,
//        gender: "Male",
//        dailyGoal: 500,
//        achievedGoals: 120,
//        totalActiveDays: 180,
//        position: 7,
//        awards: ["Active Streak Holder", "Workout Warrior"],
//        height: 5.9,
//        weight: 75.0,
//        wheelchair: false,
//        image: "person.fill",
//        points: 3020,
//        communityCodes: ["1234", "5678", "9101"],
//        weeklyPoints: [500, 550, 600, 700],
//        loginData: LoginData(
//            email: "akshatduttk@gmail.com",
//            Password: "1234567890",
//            progress: 25,
//            dob: "13-01-2003",
//            contact: "9455276501",
//            profilePic: "person.fill"
//        )
//    )
    
    @IBAction func unwindToCommunity(segue : UIStoryboardSegue){
        
    }
    
//       var filteredCommunities: [Community] {
//           return communities.filter { community in
//               currentUser.communityCodes.contains(community.code)
//           }
//       }

    
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
//                       let newCommunity = Community(
//                           name: textFieldInput,
//                           icon: "person.3.fill",
//                           code: String(randomCode),
//                           members: []
//                       )
                       
                       // Add new community to the list
//                       self.communities.append(newCommunity)
                       
                       // Add new community code to currentUser
//                       self.currentUser.communityCodes.append(String(randomCode))
                       
                       // Reload the table view to reflect the new community
                       self.communityTable.reloadData()
                       
                       self.showAlert(title: "Community Created", message: "Your community code is \(randomCode)")
                       
                   } else {
                       // Handle joining a community by matching code
//                       if let matchingCommunityIndex = self.communities.firstIndex(where: { $0.code == textFieldInput }) {
                           
                           // Add currentUser to the matching community
//                           self.communities[matchingCommunityIndex].members.append(self.currentUser)
//                           
//                           // Update currentUser's communityCodes if joining
//                           self.currentUser.communityCodes.append(textFieldInput)
//                           
//                           // Reload the table view to reflect the updated communities
//                           self.communityTable.reloadData()
//                           
//                           self.showAlert(title: "Joined Community", message: "You have joined \(self.communities[matchingCommunityIndex].name)")
//                           
//                       } else {
//                           // Show alert if code does not match any community
//                           self.showAlert(title: "Error", message: "Community code not found")
//                       }
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
//               communityTable.delegate = self
//               communityTable.dataSource = self
               communityTable.backgroundColor = .bg
           }
       }

//       extension communityViewController: UITableViewDataSource, UITableViewDelegate {
//           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//               return 60
//           }
           
           func numberOfSections(in tableView: UITableView) -> Int {
               return 1
           }
           
//           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//               return filteredCommunities.count
//           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell", for: indexPath)
//               let communityItem = filteredCommunities[indexPath.row]
               
               // Configure the cell
//               cell.textLabel?.text = communityItem.name
//               cell.textLabel?.textColor = .main
//               cell.imageView?.image = UIImage(systemName: communityItem.icon)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
               cell.contentView.layer.masksToBounds = true
               cell.contentView.backgroundColor = .clear
               cell.backgroundColor = .card
               
               // Chevron accessory
               let chevronImage = UIImageView(image: UIImage(systemName: "chevron.right"))
               chevronImage.tintColor = .systemGray
               cell.accessoryView = chevronImage
               
               let selectedBackgroundView = UIView()
               selectedBackgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
               cell.selectedBackgroundView = selectedBackgroundView
               
               return cell
           }
           
           func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//               performSegue(withIdentifier: "showCommunityDetail", sender: indexPath)
           }
           
//           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//               if let destination = segue.destination as? CommunityDetailsViewController,
//                  let indexPath = communityTable.indexPathForSelectedRow {
//                   let selectedCommunity = filteredCommunities[indexPath.row]
//                   destination.community = selectedCommunity
//               }
//           }
//       }

