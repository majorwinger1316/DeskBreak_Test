//
//  signInViewController.swift
//  DeskBreak_Test
//
//  Created by admin@33 on 06/11/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class signInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func saveUserSession(user: User) {
        let defaults = UserDefaults.standard

        defaults.set(user.userId.uuidString, forKey: "userId")
        defaults.set(user.username, forKey: "userName")
        defaults.set(user.email, forKey: "userEmail")
        defaults.set(user.passwordHash, forKey: "passwordHash")
        defaults.set(user.profilePicture, forKey: "profilePicture")
        defaults.set(user.dailyTarget, forKey: "dailyTarget")
        defaults.set(user.totalMinutes, forKey: "totalMinutes")
        defaults.set(user.totalPoints, forKey: "totalPoints")
        defaults.set(user.createdAt.timeIntervalSince1970, forKey: "createdAt")
        defaults.set(user.dateOfBirth.timeIntervalSince1970, forKey: "dateOfBirth")
        defaults.set(user.contactNumber, forKey: "contactNumber")

        // Set the login status
        defaults.set(true, forKey: "isLoggedIn")
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter email and password.")
            return
        }

        // Firebase Authentication Sign-In
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Login failed: \(error.localizedDescription)")
                return
            }

            // Retrieve userId and fetch user data from Firestore
            guard let userId = authResult?.user.uid else {
                self.showAlert(message: "Error retrieving user information.")
                return
            }

            self.fetchUserData(userId: userId)
        }
    }
    
    
    private func fetchUserData(userId: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        // Fetch user document from Firestore
        userRef.getDocument(source: .default, completion: { (documentSnapshot: DocumentSnapshot?, error: Error?) in
            if let error = error {
                self.showAlert(message: "Error fetching user data: \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot, document.exists, let userData = document.data() else {
                self.showAlert(message: "User data not found.")
                return
            }

            // Parsing user data
            let username = userData["username"] as? String ?? "Unknown"
            let email = userData["email"] as? String ?? ""
            let profilePictureURLString = userData["profilePicture"] as? String
            let dailyTarget = userData["dailyTarget"] as? Int16 ?? 0
            let totalMinutes = userData["totalMinutes"] as? Int32 ?? 0
            let totalPoints = userData["totalPoints"] as? Int32 ?? 0
            let createdAtTimestamp = userData["createdAt"] as? TimeInterval ?? 0
            let dateOfBirthTimestamp = userData["dateOfBirth"] as? TimeInterval ?? 0
            let contactNumber = userData["contactNumber"] as? String ?? ""

            // Save user data to UserDefaults
            let defaults = UserDefaults.standard
            defaults.set(userId, forKey: "userId")
            defaults.set(username, forKey: "userName")
            defaults.set(email, forKey: "userEmail")
            defaults.set(dailyTarget, forKey: "dailyTarget")
            defaults.set(totalMinutes, forKey: "totalMinutes")
            defaults.set(totalPoints, forKey: "totalPoints")
            defaults.set(createdAtTimestamp, forKey: "createdAt")
            defaults.set(dateOfBirthTimestamp, forKey: "dateOfBirth")
            defaults.set(contactNumber, forKey: "contactNumber")

            // Set the login status
            defaults.set(true, forKey: "isLoggedIn")

            // Fetch the profile picture URL if available
            if let profilePictureURLString = profilePictureURLString, let profilePictureURL = URL(string: profilePictureURLString) {
                self.downloadProfileImage(from: profilePictureURL)
            }

            // Navigate to the TabBarController
            self.navigateToTabBarController()
        })
    }
    
    @IBAction func signUpViewButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController1") as? signUp1ViewController {
            // Create a navigation controller with signUpVC as its root
            let navigationController = UINavigationController(rootViewController: signUpVC)
            navigationController.modalPresentationStyle = .fullScreen // Optional: If you want full-screen presentation
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    private func downloadProfileImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error downloading profile picture: \(error.localizedDescription)")
                return
            }

            if let data = data {
                // Convert image data to Base64 and store in UserDefaults
                let base64String = data.base64EncodedString()
                UserDefaults.standard.set(base64String, forKey: "userProfilePic")
            }

            DispatchQueue.main.async {
                self.navigateToTabBarController()
            }
        }.resume()
    }

    
    private func navigateToTabBarController() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController

                if let homeVC = tabBarController.viewControllers?.first(where: { $0 is homeViewController }) as? homeViewController {
                    // Pass the user data to the home view controller
                    homeVC.profileUpdateDelegate = self  // Set the delegate
                    
                    // Retrieve user data from UserDefaults
                    let defaults = UserDefaults.standard
                    let totalMinutes = defaults.float(forKey: "totalMinutes")
                    let dailyTarget = defaults.float(forKey: "dailyTarget")
                    
                    // Pass the data to the HomeCard via homeVC
                    homeVC.updateHomeCard(totalMinutes: totalMinutes, dailyTarget: dailyTarget)
                }

                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
            }
        }
    }

    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ProfileUpdateDelegate Implementation
extension signInViewController: ProfileUpdateDelegate {
    func updateProfileImage(_ image: UIImage) {
        print("Profile image updated successfully.")

        // Optionally, store the image in UserDefaults or update UI here
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "userProfilePic")
        }
    }
}
