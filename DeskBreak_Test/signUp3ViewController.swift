//
//  signUp3ViewController.swift
//  DeskBreak_Test
//
//  Created by admin@33 on 02/12/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class signUp3ViewController: UIViewController {
    
    @IBOutlet weak var dailyTargetButton: UIButton!
    
    
    var registrationData: UserRegistrationData!
    var pickerView: UIPickerView!
    var pickerData: [Int] = Array(1...30)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dailyTargetButtonTapped(_ sender: UIButton) {
        presentPickerView()
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        guard let dailyTargetText = dailyTargetButton.title(for: .normal),
              let dailyTarget = Int16(dailyTargetText) else {
            showAlert(message: "Please select a daily target.")
            return
        }
        
        registrationData.dailyTarget = dailyTarget

        // Register user in Firebase Authentication
        Auth.auth().createUser(withEmail: registrationData.email, password: registrationData.password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Registration failed: \(error.localizedDescription)")
                return
            }
            
            if let userId = authResult?.user.uid {
                self.saveUserData(userId: userId)
            }
        }
    }

    private func imageToBase64(_ image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        return imageData.base64EncodedString()
    }
    
    // Save user data to Firestore
    private func saveUserData(userId: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        var userData: [String: Any] = [
            "userId": userId,
            "username": registrationData.username,
            "email": registrationData.email,
            "dailyTarget": registrationData.dailyTarget,
            "totalMinutes": 0,
            "totalPoints": 0,
            "dailyMinutes": 0,  // Initialize daily minutes to 0
            "dailyPoints": 0,    // Initialize daily points to 0
            "dateOfBirth": registrationData.dateOfBirth,
            "contactNumber": registrationData.contactNumber,
            "createdAt": Timestamp(date: Date()),
            "lastActivityDate": Timestamp(date: Date()) // Store the current date for activity tracking
        ]

        if let profileImage = registrationData.profilePicture,
           let base64String = imageToBase64(profileImage) {
            userData["profilePicture"] = base64String
        }

        userRef.setData(userData) { error in
            if let error = error {
                self.showAlert(message: "Failed to save user data: \(error.localizedDescription)")
            } else {
                self.navigateToLoginScreen()
            }
        }
    }

       private func navigateToLoginScreen() {
           if let loginVC = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? signInViewController {
               self.navigationController?.setViewControllers([loginVC], animated: true)
           }
       }

       private func showAlert(message: String) {
           let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
}

extension signUp3ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func presentPickerView() {
        // Create a UIViewController for the modal
        let pickerViewController = UIViewController()
        pickerViewController.modalPresentationStyle = .pageSheet
        pickerViewController.sheetPresentationController?.detents = [.medium()] // Half-modal presentation
        
        // Create and configure the UIPickerView
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        pickerViewController.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: pickerViewController.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: pickerViewController.view.centerYAnchor),
            pickerView.widthAnchor.constraint(equalTo: pickerViewController.view.widthAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        present(pickerViewController, animated: true, completion: nil)
    }
    
    // UIPickerView Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row]) minutes"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = pickerData[row]
        dailyTargetButton.setTitle("\(selectedValue)", for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
