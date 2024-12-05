//
//  signUp1ViewController.swift
//  DeskBreak_Test
//
//  Created by admin@33 on 02/12/24.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class signUp1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var userDateOfBirth: UITextField!
    
    var registrationData = UserRegistrationData()
    
    // Date Picker
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date()) // User must be 18+
        picker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        picker.preferredDatePickerStyle = .wheels // For a compact style, use .inline or .compact
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()

        // Do any additional setup after loading the view.
    }
    
    private func setupDatePicker() {
        // Set the input view of the dateOfBirth text field to the date picker
        userDateOfBirth.inputView = datePicker
        
        // Create a toolbar with a 'Done' button to close the date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDatePicker))
        toolbar.setItems([doneButton], animated: true)
        userDateOfBirth.inputAccessoryView = toolbar
    }

    @objc private func doneDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium // Customize the format as needed
        dateFormatter.dateFormat = "dd MMMM yyyy"
        userDateOfBirth.text = dateFormatter.string(from: datePicker.date)

        // Close the date picker
        userDateOfBirth.resignFirstResponder()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let username = userNameText.text, !username.isEmpty,
              let dateOfBirth = userDateOfBirth.text, !dateOfBirth.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        registrationData.username = username
        registrationData.dateOfBirth = dateOfBirth
        
        // Navigate to the next screen with registration data
        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController2") as? signUp2ViewController {
            nextVC.registrationData = registrationData
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func selectProfilePicButtonPressed(_ sender: Any)        {let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    imagePickerController.allowsEditing = true
    present(imagePickerController, animated: true, completion: nil)
}

// Image picker delegate methods
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let selectedImage = info[.editedImage] as? UIImage {
        userProfileImageView.image = selectedImage
        registrationData.profilePicture = selectedImage
    } else if let originalImage = info[.originalImage] as? UIImage {
        userProfileImageView.image = originalImage
        registrationData.profilePicture = originalImage
    }
    
    userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
    userProfileImageView.clipsToBounds = true
    picker.dismiss(animated: true, completion: nil)
}


    // Handle cancellation of image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
