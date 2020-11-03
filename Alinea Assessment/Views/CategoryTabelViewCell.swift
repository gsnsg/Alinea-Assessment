import UIKit



class CategoryTableViewCell: UITableViewCell {
    
    // View which holds image and the text label
    let containerView: UIView = {
        let superView = UIView()
        return superView
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    func setupViews() {
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        ])
        
        containerView.layer.cornerRadius = 46
        containerView.addSubview(logoImageView)
        logoImageView.image = UIImage(systemName: "bitcoinsign.circle")
        logoImageView.tintColor = .white
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .white
        descriptionLabel.text = "Crytpo"
        descriptionLabel.font = UIFont(name: "EquitanSans-Bold", size: 22)!
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 15),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: frame.height / 2)
        ])
        
    }
    
    
    func configure(backgroundColor: UIColor, descriptionText: String, imageName: String, isSystemImage: Bool) {
        containerView.backgroundColor = backgroundColor
        descriptionLabel.text = descriptionText

        if !isSystemImage {
            logoImageView.image = UIImage(named: imageName)
            logoImageView.setImageColor(color: .white)
        } else {
            logoImageView.image = UIImage(systemName: imageName)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
