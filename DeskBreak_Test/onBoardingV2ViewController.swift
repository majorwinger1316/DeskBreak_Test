//
//  onBoardingV2ViewController.swift
//  DeskBreak_Test
//
//  Created by admin@33 on 06/11/24.
//

import UIKit

class onBoardingV2ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.delegate = self
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
        // Step 2: Dismiss the current onboarding modal
        self.dismiss(animated: true) {
            // Step 3: Transition to the TabBarController after dismissal
            if let window = UIApplication.shared.windows.first {
                // Instantiate the TabBarController from the storyboard
                let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                
                // Set the TabBarController as the root view controller
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
            }
        }
    }

}
