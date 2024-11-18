import UIKit

class dailyLeaderboardTableViewCell: UITableViewCell {
    
    let descriptionLabel = UILabel()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let pointsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Description Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .text
        addSubview(descriptionLabel)
        
        //MARK: - Profile Image View
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        addSubview(profileImageView)

        //MARK: - Name Label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textColor = .text
        addSubview(nameLabel)

        //MARK: - Points Label
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        pointsLabel.textColor = .text
        pointsLabel.textAlignment = .right
        addSubview(pointsLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            // Description label constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Profile image constraints
            profileImageView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Name label constraints
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Points label constraints (aligns to the right)
            pointsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            pointsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with person: People) {
        descriptionLabel.text = person.description
        nameLabel.text = person.name
        pointsLabel.text = person.points
        profileImageView.image = UIImage(named: person.picture)
    }
}
