//
//  HomeCard.swift
//  DeskBreak_Test
//
//  Created by admin33 on 01/11/24.
//

import UIKit

class HomeCard: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .main
        return label
    }()
    
    private let percentage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .main
        return label
    }()
    
    private let minNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .text
        return label
    }()
    
    
    
    private let minLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    private let detail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .main
        return imageView
    }()
    
    private let circularProgressView = CircularProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .card
        layer.cornerRadius = 12
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        let padding: CGFloat = 16
        let _: CGFloat = 200
        let contentView = UIView(frame: CGRect(x: padding, y: padding, width: frame.width - 2 * padding, height: frame.height - 2 * padding))
        contentView.backgroundColor = .clear
        addSubview(contentView)

        iconImageView.image = UIImage(systemName: "heart.text.square")?.withRenderingMode(.alwaysTemplate)
        contentView.addSubview(iconImageView)
        
        titleLabel.text = "Daily Progress"
        contentView.addSubview(titleLabel)
       
        minNumLabel.text = ""
        contentView.addSubview(minNumLabel)
        
        minLabel.text = "minutes"
        contentView.addSubview(minLabel)  
        
        detail.text = ""
        contentView.addSubview(detail) 
        
        percentage.text = ""
        contentView.addSubview(percentage)
        
        contentView.addSubview(circularProgressView)
        
        layoutSubviews(contentView: contentView)
    }

    
    private func layoutSubviews(contentView: UIView) {
        super.layoutSubviews()

        let iconSize: CGFloat = 24
        
        iconImageView.frame = CGRect(x: 0, y: 0, width: iconSize, height: iconSize)
        
        titleLabel.frame = CGRect(x: iconSize + 4, y: 0, width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        minNumLabel.frame = CGRect(x: 10, y: (contentView.bounds.height - 25), width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        minLabel.frame = CGRect(x: 55, y: (contentView.bounds.height - 23), width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        detail.frame = CGRect(x: (contentView.bounds.width - 50), y: 0, width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        let progressSize: CGFloat = 90
        circularProgressView.frame = CGRect(x: contentView.bounds.width - progressSize - 50, y: (contentView.bounds.height - progressSize + 10) / 2, width: progressSize, height: progressSize)

        percentage.frame = CGRect(x: contentView.bounds.width - progressSize - 30, y: (contentView.bounds.height - progressSize + 5) / 2, width: progressSize, height: progressSize)
        
        circularProgressView.setupLayers()
    }

    
    func setProgress(minutes: CGFloat, dailyTarget: CGFloat) {
        let progress = max(0, min(1, minutes / dailyTarget))
        circularProgressView.setProgress(progress: progress)

        let percentageValue = min(100, progress * 100)
        percentage.text = "\(Int(percentageValue))%"

        minNumLabel.text = String(format: "%.1f", minutes)
    }
}

class CircularProgressView: UIView {
    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()

    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    func setupLayers() {
        backgroundLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.systemTeal.withAlphaComponent(0.3).cgColor
        backgroundLayer.lineWidth = 14
        layer.addSublayer(backgroundLayer)

        progressLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.main.cgColor
        progressLayer.lineWidth = 14
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    override func draw(_ rect: CGRect) {
        progressLayer.strokeEnd = progress
    }

    func setProgress(progress: CGFloat) {
        self.progress = progress
        setNeedsDisplay()
    }
}
