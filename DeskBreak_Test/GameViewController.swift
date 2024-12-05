//
//  GameViewController.swift
//  DeskBreak_Test
//
//  Created by admin44 on 17/11/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabaseInternal

extension Notification.Name {
    static let progressUpdated = Notification.Name("progressUpdated")
}

class GameViewController: UIViewController {
    var userId: String? // Make sure you have the current user's ID
    var dailyDuration: Int = 0
    var dailyScore: Int = 0
    
    @IBAction func yesTapped(_ sender: UIButton) {
        let yesScore = 20
        dailyScore += yesScore
        dailyDuration += 0 // Assume no duration for YES button
        print("Score after YES tapped: \(dailyScore)")
        
        // You can update the Firebase with the new score if needed
        // updateUserProgress(duration: 0, score: yesScore)
    }
    
   
    @IBOutlet weak var DurationTextField: UITextField!
    @IBAction func overTapped(_ sender: UIButton) {
        guard let durationText = DurationTextField.text,
              let duration = Int(durationText) else {
            showAlert(title: "Invalid Input", message: "Please enter a valid workout duration.")
            return
        }

        // Calculate the score and update the total points
        let workoutScore = duration * 10
        dailyScore += workoutScore
        dailyDuration += duration
        
        print("Score after OVER tapped: \(dailyScore)")
        
        // Update Firebase with the new values
        updateUserProgressInFirebase(duration: dailyDuration, score: dailyScore)
        
        presentSuccessViewController(duration: dailyDuration, score: dailyScore)
    }
    
    func updateUserProgressInFirebase(duration: Int, score: Int) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User ID is missing or the user is not logged in.")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                var totalMinutes = document.get("totalMinutes") as? Int ?? 0
                var totalPoints = document.get("totalPoints") as? Int ?? 0
                var dailyMinutes = document.get("dailyMinutes") as? Int ?? 0
                var dailyPoints = document.get("dailyPoints") as? Int ?? 0
                let lastUpdateDate = document.get("lastUpdateDate") as? Timestamp ?? Timestamp(date: Date())

                let currentDate = Date()
                if !self.isSameDay(currentDate, lastUpdateDate.dateValue()) {
                    dailyMinutes = 0
                    dailyPoints = 0
                }

                // Update daily and total values
                dailyMinutes += duration
                dailyPoints += score
                totalMinutes += duration
                totalPoints += score

                // Log the data we're updating
                print("Updating user data: \(totalMinutes) minutes, \(totalPoints) points")

                // Update Firestore with new values
                userRef.updateData([
                    "totalMinutes": totalMinutes,
                    "totalPoints": totalPoints,
                    "dailyMinutes": dailyMinutes,
                    "dailyPoints": dailyPoints,
                    "lastUpdateDate": Timestamp(date: currentDate)
                ]) { error in
                    if let error = error {
                        print("Error updating Firestore: \(error.localizedDescription)")
                    } else {
                        print("User progress updated successfully in Firestore.")
                        NotificationCenter.default.post(name: .progressUpdated, object: nil)
                    }
                }
            } else {
                print("Document does not exist or failed to fetch data.")
            }
        }
    }
    
    @IBAction func NoTapped(_ sender: UIButton) {
        let noScore = -10
        dailyScore += noScore
        dailyDuration += 0 // Assume no duration for NO button
        print("Score after NO tapped: \(dailyScore)")
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
    
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }

    func updateUserProgress(duration: Int, score: Int) {
        // Get current user's UID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        let db = Firestore.firestore()

        // Fetch current data from Firebase (totalMinutes, totalPoints, dailyMinutes, dailyPoints)
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var totalMinutes = document.get("totalMinutes") as? Int ?? 0
                var totalPoints = document.get("totalPoints") as? Int ?? 0
                var dailyMinutes = document.get("dailyMinutes") as? Int ?? 0
                var dailyPoints = document.get("dailyPoints") as? Int ?? 0
                let lastUpdateDate = document.get("lastUpdateDate") as? Timestamp ?? Timestamp(date: Date())

                // Check if the day has changed
                let currentDate = Date()
                if !self.isSameDay(currentDate, lastUpdateDate.dateValue()) {
                    // If the date is different, reset dailyMinutes and dailyPoints to 0
                    dailyMinutes = 0
                    dailyPoints = 0
                }

                // Update daily points and minutes
                dailyMinutes += duration
                dailyPoints += score

                // Update total points and total minutes
                totalMinutes += duration
                totalPoints += score

                // Save updated values to Firebase
                userRef.updateData([
                    "totalMinutes": totalMinutes,
                    "totalPoints": totalPoints,
                    "dailyMinutes": dailyMinutes,
                    "dailyPoints": dailyPoints,
                    "lastUpdateDate": Timestamp(date: currentDate) // Update the last update date to today
                ]) { error in
                    if let error = error {
                        print("Error updating user progress: \(error)")
                    } else {
                        print("User progress updated successfully")
                        
                        // Post a notification to update the progress on the home page
                        NotificationCenter.default.post(name: .progressUpdated, object: nil)
                    }
                }
            } else {
                print("User document does not exist")
            }
        }
    }
    
    func presentSuccessViewController(duration: Int, score: Int) {
        let successVC = storyboard?.instantiateViewController(withIdentifier: "GameSuccessViewController") as! GameSuccessViewController
        successVC.totalDuration = duration
        successVC.finalScore = score
        present(successVC, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
