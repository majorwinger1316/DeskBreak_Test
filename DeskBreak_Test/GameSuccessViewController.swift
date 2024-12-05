//
//  GameSuccessViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit

class GameSuccessViewController: UIViewController {
    
    var finalScore : Int = 0
    var totalDuration : Int = 0
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var dailyRankLabel: UILabel!
    
    @IBOutlet weak var weeklyRankLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "\(finalScore)"
        minutesLabel.text = "\(totalDuration)"
        profileImage.image = UIImage(named: "defaultProfileImage") // Placeholder image
        // Optionally fetch the user's profile picture and rank info from Firebase
        displayConfetti()
    }
    
    private func displayConfetti() {
        let confettiEmitter = CAEmitterLayer()
        confettiEmitter.emitterPosition = CGPoint(x: view.bounds.midX, y: 0)
        confettiEmitter.emitterShape = .line
        confettiEmitter.emitterSize = CGSize(width: view.bounds.size.width, height: 1)

        let confettiCell = CAEmitterCell()
        confettiCell.birthRate = 50
        confettiCell.lifetime = 10
        confettiCell.lifetimeRange = 3
        confettiCell.velocity = 150
        confettiCell.velocityRange = 50
        confettiCell.emissionLongitude = .pi
        confettiCell.emissionRange = .pi / 4
        confettiCell.spin = 4
        confettiCell.spinRange = 2
        confettiCell.scale = 0.1
        confettiCell.scaleRange = 0.2

        confettiCell.contents = UIImage(named: "confetti")?.cgImage
        
        confettiEmitter.emitterCells = [confettiCell]
        view.layer.addSublayer(confettiEmitter)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            confettiEmitter.birthRate = 0
        }
    }

    private func generateCongratsMessage() -> String {
        switch finalScore {
        case 0..<50:
            return "Good effort! Keep trying!"
        case 50..<100:
            return "Well done! You're getting better!"
        case 100...:
            return "Amazing work! You're a star!"
        default:
            return "Keep it up!"
        }
    }
}
