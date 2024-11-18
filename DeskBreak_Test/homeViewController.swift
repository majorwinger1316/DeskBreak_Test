//
//  homeViewController.swift
//  DeskBreak_Test
//
//  Created by admin33 on 03/10/24.
//

import UIKit

class homeViewController: UIViewController {
    
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
        
        homeCardView.setProgress(minutes: 30)
        
        setupGradientLayer()
        
//        if let profileImage = UIImage(named: "maxwell") {
//            let profileImageView = UIImageView(image: profileImage)
//            profileImageView.contentMode = .scaleAspectFill
//            profileImageView.layer.cornerRadius = 15 // Adjust radius for your desired circle size
//            profileImageView.clipsToBounds = true
//            profileImageView.layer.masksToBounds = true
///*            profileImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)*/ // Set the desired size
//
//            // Set profileImageView as the custom view for the UIBarButtonItem
//            profileBarButton.customView = profileImageView
//        }
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
}
