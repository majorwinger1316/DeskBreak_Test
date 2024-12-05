// leaderboardViewController.swift
import UIKit
import FirebaseFirestore
import FirebaseAuth

class leaderboardViewController: UIViewController {

    @IBOutlet weak var LeaderTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    
    var peoples: [(username: String, userId: String, totalPoints: Int32)] = []
    var currentUser: User?

    // Firestore reference
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        LeaderTableView.dataSource = self
        LeaderTableView.delegate = self
        LeaderTableView.register(dailyLeaderboardTableViewCell.self, forCellReuseIdentifier: "leaderboardCell")
        
        profileImage.image = UIImage(named: "defaultProfileImage")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        // Fetch current user and leaderboard data
        fetchCurrentUser()
        fetchLeaderboardData()
    }

    func fetchCurrentUser() {
        // Fetch current user from UserDefaults instead of Firestore
        let defaults = UserDefaults.standard
        guard let username = defaults.string(forKey: "userName"),
              let userId = defaults.string(forKey: "userId") else {
            print("No current user found in UserDefaults.")
            return
        }

        // Initialize the currentUser with both userId and username from UserDefaults
        self.currentUser = User(username: username, userId: userId)

        // Update position label after the current user is set
        updatePositionLabel()
    }

    func fetchLeaderboardData() {
        db.collection("users").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching leaderboard data: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found in the snapshot.")
                return
            }

            // Map the documents to an array of tuples with username, userId, and totalPoints
            self?.peoples = documents.compactMap { document in
                let data = document.data()

                guard let username = data["username"] as? String,
                      let userId = data["userId"] as? String, // Ensure userId is included
                      let totalPoints = data["totalPoints"] as? Int32 else {
                    return nil
                }

                // Create a tuple with the necessary data
                return (username, userId, totalPoints)
            }

            // Debug: Log the fetched leaderboard data
            print("Fetched leaderboard data: \(self?.peoples ?? [])")

            // Sort leaderboard in descending order (highest points first)
            self?.peoples.sort { $0.totalPoints > $1.totalPoints }

            // Reload the table view on the main thread
            DispatchQueue.main.async {
                self?.LeaderTableView.reloadData()
            }

            // Update position label after leaderboard data is fetched
            self?.updatePositionLabel()
        }
    }

    func updatePositionLabel() {
        guard let currentUser = currentUser else { return }

        // Sort users by totalPoints in descending order (highest points first)
        let sortedUsers = peoples.sorted { $0.totalPoints > $1.totalPoints }

        // Find the position of the current user using userId to ensure unique identification
        if let index = sortedUsers.firstIndex(where: { $0.userId == currentUser.userId }) {
            positionLabel.text = "Position: \(index + 1)"
        } else {
            positionLabel.text = "Position: N/A" // If the user is not found in the list
        }
    }
}

extension leaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as? dailyLeaderboardTableViewCell else {
            return UITableViewCell()
        }

        // Fetch username and totalPoints from the tuple
        let person = peoples[indexPath.row]
        
        cell.descriptionLabel.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = person.username
        cell.pointsLabel.text = "\(person.totalPoints)"

        // Highlight the current user
        if person.userId == currentUser?.userId {
            cell.backgroundColor = UIColor.card
            cell.nameLabel.textColor = UIColor.main
            cell.descriptionLabel.textColor = UIColor.main
            cell.pointsLabel.textColor = UIColor.main
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        } else {
            cell.backgroundColor = .bg
        }

        cell.isUserInteractionEnabled = false
        return cell
    }
}
