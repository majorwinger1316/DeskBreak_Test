//
//  DescriptionViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = game {
                    self.title = game.name
                    exerciseDesc.text = game.description
                    exerciseImage.image = UIImage(named: game.photo)
                }
        
    }
    
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseDesc: UITextView!
    @IBAction func playButtonTapped(_ sender: Any) {
    }
    
    
}
