//
//  DescriptionViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var exerciseImage: UIImageView!
    
    @IBOutlet weak var exerciseDescription: UITextView!
    
    var game = Game(name: "High V", description: "High-V is a gamified AR desk-break workout—perfect for when you're feeling lazy or tired. Stretch, dodge, and hit targets to rejuvenate and boost your energy right at your desk!", points: "10", photo: "game1", time: "10")
    
    override func viewDidLoad() {
        super.viewDidLoad()
                    self.title = game.name
        exerciseDescription.text = game.description
        exerciseImage.image = UIImage(named: game.photo)
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
    }
    
    
}
