//
//  GameViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit

class GameViewController: UIViewController {
    var score = 0
    var people: Person?
    
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
        
        // Calculate the score based on the duration
        let workoutScore = duration * 10
        score += workoutScore
        print("Score after OVER tapped: \(score)")
        // Update the member's points
        people?.points += score
        print("Score before segue: \(score)")
        
        presentSuccessViewController()
        
//        self.performSegue(withIdentifier: "showSuccessMessage", sender: self)
        
    }
        
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           // Ensure segue identifier matches the one in the storyboard
//           if segue.identifier == "showSuccessMessage" {
//               // Log to check when the segue is called
//               print("Preparing for segue to GameSuccessViewController")
//               
//               // Correct the cast here: Ensure the destination is the GameSuccessViewController
//               if let destinationVC = segue.destination as? GameSuccessViewController {
//                   // Log the score before passing it
//                   print("Passing score to GameSuccessViewController: \(score)")
//                   destinationVC.finalScore = score // Pass the score to the next view controller
//               } else {
//                   print("Failed to cast destinationVC to GameSuccessViewController")
//               }
//           }
//       }
    
    // Programmatically presenting the GameSuccessViewController modally
        func presentSuccessViewController() {
            // Create an instance of GameSuccessViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Ensure "Main" is the correct storyboard name
            if let successVC = storyboard.instantiateViewController(withIdentifier: "GameSuccessViewController") as? GameSuccessViewController {
                // Pass the score to the success view controller
                successVC.finalScore = score
                print("Presenting GameSuccessViewController with score: \(score)")
                
                // Set up modal presentation style
                successVC.modalPresentationStyle = .overFullScreen // Use .overFullScreen or another style if needed
                
                // Present modally
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
        // Do any additional setup after loading the view.
    }
    
    private func saveToBackend(member: Member, exerciseScore: Int) {
        // Simulating saving data to backend
        print("Saving \(member.name)'s score: \(exerciseScore) to backend")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
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
