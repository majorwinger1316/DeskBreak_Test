import UIKit

class MemberDetailsViewController: UIViewController {
    
    // Define UI components
    var scrollView: UIScrollView!
    var contentView: UIView!
    var progressView: UIView!
    var historyView: UIView!
    var awardsView: UIView!
    
    // Data properties
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.bg
        
        // Set up the navigation title to display the member's name
        title = member?.name ?? "Member Details"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.text
        ]

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        
        setupViews()
        setupConstraints() // Ensure this is called to apply constraints
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        // Initialize and configure scroll view and content view
        scrollView = UIScrollView()
        contentView = UIView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Create section labels outside of cards
        let progressLabel = createSectionTitleLabel(withText: "Progress")
        let historyLabel = createSectionTitleLabel(withText: "History")
        let awardsLabel = createSectionTitleLabel(withText: "Awards")
        
        // Configure individual sections
        setupProgressView()
        setupHistoryView()
        setupAwardsView()
        
        // Arrange labels and sections in a stack view for vertical alignment
        let stackView = UIStackView(arrangedSubviews: [
            progressLabel, progressView,
            historyLabel, historyView,
            awardsLabel, awardsView
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupProgressView() {
        progressView = createCardView()
        
        let activeDaysLabel = createIconDetailLabel(icon: "figure.walk", text: "Total Active Days", value: "20")
        let pointsLabel = createIconDetailLabel(icon: "camera", text: "Total Points Earned", value: "3050")
        let positionLabel = createIconDetailLabel(icon: "person.3", text: "Position", value: "345")
        
        let progressStack = UIStackView(arrangedSubviews: [activeDaysLabel, pointsLabel, positionLabel])
        progressStack.axis = .vertical
        progressStack.spacing = 16
        
        progressStack.translatesAutoresizingMaskIntoConstraints = false
        progressView.addSubview(progressStack)
        
        NSLayoutConstraint.activate([
            progressStack.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16),
            progressStack.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -16),
            progressStack.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 16),
            progressStack.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupHistoryView() {
        historyView = createCardView()
        
        let minutesLabel = UILabel()
        minutesLabel.text = "47"
        minutesLabel.font = UIFont.boldSystemFont(ofSize: 48)
        minutesLabel.textColor = .text
        minutesLabel.textAlignment = .center
        
        let minutesDescriptionLabel = UILabel()
        minutesDescriptionLabel.text = "Minutes"
        minutesDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        minutesDescriptionLabel.textColor = .lightGray
        minutesDescriptionLabel.textAlignment = .center
        
        let lastExerciseLabel = createIconDetailLabel(icon: "figure.wave", text: "Last Exercise", value: "Score: 60")
        let skyKickLabel = createIconDetailLabel(icon: "timer", text: "SkyKick Scorer", value: "Minutes: 10")
        
        let historyStack = UIStackView(arrangedSubviews: [minutesLabel, minutesDescriptionLabel, lastExerciseLabel, skyKickLabel])
        historyStack.axis = .vertical
        historyStack.spacing = 16
        historyStack.alignment = .center
        
        historyStack.translatesAutoresizingMaskIntoConstraints = false
        historyView.addSubview(historyStack)
        
        NSLayoutConstraint.activate([
            historyStack.leadingAnchor.constraint(equalTo: historyView.leadingAnchor, constant: 16),
            historyStack.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -16),
            historyStack.topAnchor.constraint(equalTo: historyView.topAnchor, constant: 16),
            historyStack.bottomAnchor.constraint(equalTo: historyView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupAwardsView() {
        awardsView = createCardView()
        
        let seeMoreButton = UIButton(type: .system)
        seeMoreButton.setTitle("See More", for: .normal)
        seeMoreButton.tintColor = .lightGray
        seeMoreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        seeMoreButton.addTarget(self, action: #selector(seeMoreTapped), for: .touchUpInside)

        
        awardsView.addSubview(seeMoreButton)
        
        // Create 3 image placeholders (60x60) with icons for the awards
        let awardImage1 = createAwardImage(imageName: "star.fill", title: "7 Day Streak")
        let awardImage2 = createAwardImage(imageName: "timer", title: "100 Minutes")
        let awardImage3 = createAwardImage(imageName: "trophy.fill", title: "First Stretch")
        
        // Stack the images and their titles vertically
        let imageStack = UIStackView(arrangedSubviews: [awardImage1, awardImage2, awardImage3])
        imageStack.axis = .horizontal
        imageStack.spacing = 24
        imageStack.alignment = .center
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        awardsView.addSubview(imageStack)
        
        // Add constraints for the "See More" button
        NSLayoutConstraint.activate([
            seeMoreButton.topAnchor.constraint(equalTo: awardsView.topAnchor, constant: 16),
            seeMoreButton.trailingAnchor.constraint(equalTo: awardsView.trailingAnchor, constant: -16),
            
            // Add constraints for the image stack
            imageStack.topAnchor.constraint(equalTo: seeMoreButton.bottomAnchor, constant: 16),
            imageStack.centerXAnchor.constraint(equalTo: awardsView.centerXAnchor),
            imageStack.leadingAnchor.constraint(equalTo: awardsView.leadingAnchor, constant: 16),
            imageStack.trailingAnchor.constraint(equalTo: awardsView.trailingAnchor, constant: -16),
            imageStack.bottomAnchor.constraint(equalTo: awardsView.bottomAnchor, constant: -16)
        ])
    }

    // Helper to create an image and title label for the awards
    private func createAwardImage(imageName: String, title: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.alignment = .center
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .main
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .text
        titleLabel.textAlignment = .center
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(titleLabel)
        
        return container
    }

    @objc func seeMoreTapped() {
        print("See More tapped")
    }

    // Helper to create section title label
    private func createSectionTitleLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .text
        return label
    }
    
    // Helper to create labels with icons
    private func createIconDetailLabel(icon: String, text: String, value: String) -> UIView {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 8
        
        let iconImageView = UIImageView(image: UIImage(systemName: icon))
        iconImageView.tintColor = .main
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.textColor = .lightGray
        textLabel.text = text
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textColor = .text
        valueLabel.text = value
        
        container.addArrangedSubview(iconImageView)
        container.addArrangedSubview(textLabel)
        container.addArrangedSubview(valueLabel)
        
        return container
    }
    
    private func createDetailLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .text
        label.textAlignment = .center
        return label
    }
    
    private func createCardView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.card
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

