//
//  HomeCardSecond.swift
//  DeskBreak_Test
//
//  Created by admin33 on 01/11/24.
//

import UIKit

class HomeCardSecond: UIView {
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
    private let handIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
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
        let contentView = UIView(frame: CGRect(x: padding, y: padding, width: frame.width - 2 * padding, height: frame.height - 2 * padding))
        contentView.backgroundColor = .clear
        addSubview(contentView)

        iconImageView.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        contentView.addSubview(iconImageView)
        
        handIconImageView.image = UIImage(systemName: "hand.raised.fingers.spread")
        contentView.addSubview(handIconImageView)
        
        titleLabel.text = "Trending Game"
        contentView.addSubview(titleLabel)
       
        minNumLabel.text = "1069"
        contentView.addSubview(minNumLabel)
        
        minLabel.text = "Players this week"
        contentView.addSubview(minLabel)
        
        detail.text = "Play"
        contentView.addSubview(detail)
        
        percentage.text = "50%"
        contentView.addSubview(percentage)
        
        layoutSubviews(contentView: contentView)
    }

    
    private func layoutSubviews(contentView: UIView) {
        super.layoutSubviews()

        let iconSize: CGFloat = 24
        
        iconImageView.frame = CGRect(x: 0, y: 0, width: iconSize, height: iconSize)
        
        titleLabel.frame = CGRect(x: iconSize + 4, y: 0, width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        minNumLabel.frame = CGRect(x: contentView.bounds.width - iconSize - 100, y: (contentView.bounds.height - iconSize) / 2, width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        minLabel.frame = CGRect(x: contentView.bounds.width - iconSize - 140, y: (contentView.bounds.height - iconSize + 55) / 2, width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        detail.frame = CGRect(x: (contentView.bounds.width - 40), y: 0, width: contentView.bounds.width - iconSize - 8 - 50, height: iconSize)
        
        let imageSize: CGFloat = 70
        handIconImageView.frame = CGRect(x: 30, y: (contentView.bounds.height - 85), width: imageSize, height: imageSize)
    }

}
