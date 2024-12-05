//
//  GameViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit

class GameViewController: UIViewController {
    var score = 0
//    var people: Person?
    
    @IBAction func yesTapped(_ sender: UIButton) {
        score += 20
        print("Score after YES tapped: \(score)")
        
    }
    
   
    @IBOutlet weak var DurationTextField: UITextField!
    @IBAction func overTapped(_ sender: UIButton) {
        guard let durationText = DurationTextField.text,
              let duration = Int(durationText) else {
            showAlert(title: "Invalid Input", message: "Please enter a valid workout duration.")
            return
        }
        
        let workoutScore = duration * 10
        score += workoutScore
        print("Score after OVER tapped: \(score)")
//        currentUser.points += score
//        print("\(currentUser.points)")
        print("Score before segue: \(score)")
        
        presentSuccessViewController(duration: duration, score: score)
        
    }
    
    func presentSuccessViewController(duration: Int, score: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let successVC = storyboard.instantiateViewController(withIdentifier: "GameSuccessViewController") as? GameSuccessViewController {
            successVC.finalScore = score
            successVC.totalDuration = duration
            
            print("Presenting GameSuccessViewController with score: \(score) and duration: \(duration)")
            successVC.modalPresentationStyle = .overFullScreen

            present(successVC, animated: true, completion: nil)
        }
    }
    @IBAction func NoTapped(_ sender: UIButton) {
        score -= 10
        print("Score after NO tapped: \(score)")
    }
    
    
    @IBAction func ExitTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(
            title: "Confirm Exit",
            message: "Are you sure you want to leave the game?",
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        present(alertController, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameViewController viewDidLoad called, Current instance: \(self)")
    }
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

}
