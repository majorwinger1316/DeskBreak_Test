//
//  CommunityDetailsViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit
import FirebaseFirestore

class CommunityDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    var community: Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "memberCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray

        // Update UI with community details
        if let community = community {
            titleLabel.text = community.communityName
            codeLabel.text = "Community Code: \(community.communityId.prefix(4))"
            fetchMembers()
        }
    }
    
    func fetchMembers() {
        guard let community = community else { return }

        let db = Firestore.firestore()

        db.collection("communities")  // assuming the top-level collection is "communities"
            .document(community.communityId)  // fetching the community document
            .collection("members")  // accessing the "members" subcollection
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching members: \(error.localizedDescription)")
                    return
                }

                // Step 2: Extract the userIds from the "members" subcollection
                let userIds = querySnapshot?.documents.compactMap { document in
                    return document.data()["userId"] as? String
                } ?? []

                print("Fetched userIds: \(userIds)")

                // Step 3: Fetch user details for each userId
                self.fetchUsers(userIds: userIds) { users in
                    DispatchQueue.main.async {
                        community.members = users
                        self.memberLabel.text = "Members: \(users.count)"
                        self.tableView.reloadData()
                    }
                }
            }
    }

    func fetchUsers(userIds: [String], completion: @escaping ([User]) -> Void) {
        let db = Firestore.firestore()
        var users: [User] = []

        let group = DispatchGroup()

        for userId in userIds {
            group.enter()
            db.collection("users").document(userId).getDocument { documentSnapshot, error in
                if let error = error {
                    print("Error fetching user data for userId \(userId): \(error.localizedDescription)")
                } else if let document = documentSnapshot, document.exists,
                          let data = document.data() {
                    print("Fetched data for userId \(userId): \(data)")  // Add detailed log
                    
                    if let user = User(data: data) {
                        users.append(user)
                    } else {
                        print("Failed to parse user data for userId \(userId)")  // Data doesn't match expected structure
                    }
                } else {
                    print("Document does not exist or error occurred for userId \(userId)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(users)
        }
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return community?.members.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        
        if let member = community?.members[indexPath.row] {
            cell.textLabel?.text = member.username
        }
        
        cell.backgroundColor = .clear
        cell.layer.masksToBounds = true
        cell.accessoryType = .detailButton

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }

}
