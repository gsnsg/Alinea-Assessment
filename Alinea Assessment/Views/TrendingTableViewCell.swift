import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    let containerView: UIView = {
        let cv = UIView(frame: .zero)
        return cv
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let shortNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let changeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        shortNameLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        ])
        
        // Logo Image View Constraints
        containerView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        
            
        containerView.addSubview(changeLabel)
        NSLayoutConstraint.activate([
            changeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            changeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            changeLabel.widthAnchor.constraint(equalToConstant: 80),
            changeLabel.heightAnchor.constraint(equalToConstant: 22)
            
        ])
        changeLabel.layer.cornerRadius = 10
        changeLabel.layer.masksToBounds = true
       
        
        // Change Logo constraints
        logoImageView.contentMode = .scaleAspectFit
        containerView.addSubview(companyLabel)
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            companyLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
     
        
        
        containerView.addSubview(shortNameLabel)
        NSLayoutConstraint.activate([
            shortNameLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 30),
            shortNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            shortNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        
    
    }
    
    func configure(imageName: String, companyName: String, shortName: String, change: String) {
        logoImageView.image = UIImage(named: imageName)
        
        companyLabel.text = companyName
        companyLabel.font = UIFont(name: "EquitanSans-Bold", size: 22)!
        companyLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        shortNameLabel.text = shortName
        shortNameLabel.font = UIFont(name: "EquitanSans-Bold", size: 20)!
        shortNameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        
        changeLabel.text = change
        changeLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        changeLabel.textColor = .white
        changeLabel.textAlignment = .center
        if change.first == "+" {
            changeLabel.backgroundColor = UIColor(red: 0.244, green: 0.857, blue: 0.706, alpha: 1.0)
        } else {
            changeLabel.backgroundColor = UIColor(red: 0.991, green: 0.416, blue: 0.421, alpha: 1.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
