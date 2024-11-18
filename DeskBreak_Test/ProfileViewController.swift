//
//  ProfileViewController.swift
//  DeskBreak_Test
//
//  Created by admin@33 on 08/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.image = UIImage(named: "maxwell")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        // Do any additional setup after loading the view.
        nameLabel.text = "Maxwell Pula"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
