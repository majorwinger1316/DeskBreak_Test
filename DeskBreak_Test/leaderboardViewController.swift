// leaderboardViewController.swift
import UIKit

class leaderboardViewController: UIViewController {

    @IBOutlet weak var LeaderTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var leaderBoardSegment: UISegmentedControl!
    @IBOutlet weak var positionLabel: UILabel!
    
    var peoples: [People] = [
        People(name: "Akshat Dutt Kaushik", description: "1", points: "3020", picture: "akshat"),
        People(name: "Swati Swapna", description: "2", points: "2080", picture: "maxwell"),
        People(name: "Vansh Bhatia", description: "3", points: "2680", picture: "b"),
        People(name: "Ravi Kumar", description: "4", points: "2500", picture: "c"),
        People(name: "Neha Sharma", description: "5", points: "2200", picture: "d"),
        People(name: "Priya Rajan", description: "6", points: "2000", picture: "e"),
        People(name: "Ankit Mehta", description: "7", points: "1500", picture: "f"),
    ]
    
    var weeklyPeoples: [WeeklyPeople] = [
        WeeklyPeople(name : "Akshat Dutt Kaushik", position: "1", points: "3020", picture: "akshat"),
        WeeklyPeople(name : "Manvitha Pula", position: "2", points: "3000", picture: "b"),
        WeeklyPeople(name : "Bhumika Sharma", position: "3", points: "3000", picture: "c"),
        WeeklyPeople(name : "Anwin Sharon", position: "4", points: "2900", picture: "d"),
        WeeklyPeople(name : "Vansh Bhatia", position: "5", points: "2500", picture: "e"),
        WeeklyPeople(name : "Dhruv Dhariwal", position: "6", points: "2490", picture: "f"),
        WeeklyPeople(name : "Anish Agrawal", position: "7", points: "2450", picture: "g"),
        WeeklyPeople(name : "Pawan", position: "8", points: "2420", picture: "h"),
        WeeklyPeople(name : "Arnav Agrawal", position: "9", points: "2400", picture: "i"),
        WeeklyPeople(name : "Swati Swapna", position: "10", points: "2000", picture: "maxwell"),

    ]
    
    var isWeeklySelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        LeaderTableView.dataSource = self
        LeaderTableView.delegate = self
        LeaderTableView.register(dailyLeaderboardTableViewCell.self, forCellReuseIdentifier: "leaderboardCell")
        
        profileImage.image = UIImage(named: "akshat")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
//        positionLabel.text =
        if isWeeklySelected {
            positionLabel.text = "1"
        } else {
            positionLabel.text = "1"
        }
        
        let whiteTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.text
        ]
        
        leaderBoardSegment.setTitleTextAttributes(whiteTextAttributes, for: .normal)
        leaderBoardSegment.setTitleTextAttributes(whiteTextAttributes, for: .selected)
    }

    
    
    @IBAction func leaderboardSegmentChanged(_ sender: UISegmentedControl) {
        isWeeklySelected = sender.selectedSegmentIndex == 1
         LeaderTableView.reloadData()
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
        return isWeeklySelected ? weeklyPeoples.count : peoples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as? dailyLeaderboardTableViewCell else {
            return UITableViewCell()
        }
        
        if isWeeklySelected {
            let weeklyPerson = weeklyPeoples[indexPath.row]
            cell.descriptionLabel.text = weeklyPerson.position
            cell.nameLabel.text = weeklyPerson.name
            cell.pointsLabel.text = weeklyPerson.points
            cell.profileImageView.image = UIImage(named: weeklyPerson.picture)
        } else {
            let person = peoples[indexPath.row]
            cell.descriptionLabel.text = person.description
            cell.nameLabel.text = person.name
            cell.pointsLabel.text = person.points
            cell.profileImageView.image = UIImage(named: person.picture)
        }
 
        let highlightName = isWeeklySelected ? weeklyPeoples[indexPath.row].name : peoples[indexPath.row].name
        if highlightName == "Akshat Dutt Kaushik" {
            cell.backgroundColor = .main
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        } else {
            cell.backgroundColor = .bg
        }

        cell.isUserInteractionEnabled = false
        return cell
    }



}
