//
//  CommunityDetailsViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit

class CommunityDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var codeLabel: UILabel!
    
    
    
    
    var community: Community?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return community?.members.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        
        if let member = community?.members[indexPath.row] {
        cell.textLabel?.text = member.name
        }
        
        cell.backgroundColor = .clear
       
        cell.layer.masksToBounds = true
        
        cell.accessoryType = .detailButton
        
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // Adjust as needed for your design
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        if let community = community {
                   titleLabel.text = community.name
                   codeLabel.text = "Community Code: \(community.code)"
                   memberLabel.text = "Members: \(community.members.count)"
               }
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "memberCell")
        tableView.separatorColor = UIColor.lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    var selectedMember : Member?
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            guard let selectedMember = community?.members[indexPath.row] else {
                print("Error: Member is nil.")
                return
            }
            showMemberDetail(member: selectedMember)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMemberDetail",
           let destinationVC = segue.destination as? MemberDetailsViewController,
           let selectedMember = sender as? Member {
            destinationVC.member = selectedMember // Pass the Member directly
        }
    }
        
    func showMemberDetail(member: Member) {
        let memberDetailsVC = MemberDetailsViewController()
        memberDetailsVC.member = member  
        let navController = UINavigationController(rootViewController: memberDetailsVC)
        present(navController, animated: true, completion: nil)
    }

}
