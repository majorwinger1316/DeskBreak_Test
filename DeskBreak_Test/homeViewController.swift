//
//  homeViewController.swift
//  DeskBreak_Test
//
//  Created by admin33 on 03/10/24.
//

import UIKit
import FirebaseDatabaseInternal

protocol ProfileUpdateDelegate: AnyObject {
    func updateProfileImage(_ image: UIImage)
}

class homeViewController: UIViewController, ProfileUpdateDelegate {
    
    var profileUpdateDelegate: ProfileUpdateDelegate?
    var userId: String?
    
    @IBOutlet weak var homeCardView: HomeCard!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    private let gradientLayer = CAGradientLayer()
    private let initialBackgroundColor = UIColor.bg
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupNavigationBarWithProfileImage(image: UIImage(named: "defaultProfileImage"))
        updateProgressView()
        setupFirebaseListener()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressView), name: .progressUpdated, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .progressUpdated, object: nil)
    }
    
    func setupFirebaseListener() {
        guard let userId = self.userId else { return }
        
        let ref = Database.database().reference().child("users").child(userId)
        ref.observe(.value) { snapshot in
            if let userData = snapshot.value as? [String: Any],
               let totalMinutes = userData["totalMinutes"] as? Float,
               let totalPoints = userData["totalPoints"] as? Int {
                
                // Update progress view with the new data from Firebase
                DispatchQueue.main.async {
                    self.updateProgressView(totalMinutes: totalMinutes, totalPoints: totalPoints)
                }
            }
        }
    }
    
    func updateProgressView(totalMinutes: Float, totalPoints: Int) {
        print("Updated data from Firebase: totalMinutes: \(totalMinutes), totalPoints: \(totalPoints)")

        // Update the HomeCard view with current progress
        DispatchQueue.main.async {
            self.homeCardView.setProgress(minutes: CGFloat(totalMinutes), dailyTarget: CGFloat(totalPoints))
        }
    }
    
    func updateHomeCard(totalMinutes: Float, dailyTarget: Float) {
        print("Updating home card with totalMinutes: \(totalMinutes), dailyTarget: \(dailyTarget)")
        homeCardView.setProgress(minutes: CGFloat(totalMinutes), dailyTarget: CGFloat(dailyTarget))
    }
    
    func updateProfileImage(_ image: UIImage) {
        // Update the profile image in the bar button
        profileBarButton?.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProgressView()
        self.navigationController?.navigationBar.layoutIfNeeded() 
    }

    private func setupNavigationBarWithProfileImage(image: UIImage?) {
        let profileImageView = UIImageView(image: image)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 16 // Make sure it is circular if needed
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        
        // Set a fixed size using Auto Layout
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        // Wrap the UIImageView inside a UIBarButtonItem
        let profileBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
        // Add the UIBarButtonItem to the right side of the navigation bar
        self.navigationItem.rightBarButtonItem = profileBarButtonItem
    }

    @objc private func profileButtonTapped() {
        if let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            let navController = UINavigationController(rootViewController: profileVC)
            navController.modalPresentationStyle = .pageSheet
            present(navController, animated: true)
        }
    }
    
    private func setupGradientLayer() {
        let mainColor = UIColor.main
        
        gradientLayer.colors = [
            mainColor.withAlphaComponent(1.0).cgColor,
            mainColor.withAlphaComponent(0.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        view.layer.addSublayer(gradientLayer)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let maxFadeOffset: CGFloat = 100
        let opacity = max(0, 1 - offset / maxFadeOffset)
        gradientLayer.opacity = Float(opacity)
    }
    
    func loginUser() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        updateProgressView() // Ensure progress is updated after login
    }
    
    @objc func updateProgressView() {
        let defaults = UserDefaults.standard
        let totalMinutes = defaults.float(forKey: "totalMinutes")
        let dailyTarget = defaults.float(forKey: "dailyTarget")

        print("Total minutes from UserDefaults: \(totalMinutes), Daily Target: \(dailyTarget)")

        DispatchQueue.main.async {
            self.homeCardView.setProgress(minutes: CGFloat(totalMinutes), dailyTarget: CGFloat(dailyTarget))
        }
    }

    func logoutUser() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        updateProgressView() // Reset progress view
    }
}
