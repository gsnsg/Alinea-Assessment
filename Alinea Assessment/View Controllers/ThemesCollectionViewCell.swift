import UIKit

class ThemesCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(label)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: frame.height * 0.65),
            imageView.widthAnchor.constraint(equalToConstant: frame.width * 0.65),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.widthAnchor.constraint(equalToConstant: frame.size.width * 0.8)
        ])
        label.text = "Demo Demo Demo"
        label.textAlignment = .center
        
        
        
    }
    
    func configure(imageName: String, description: String) {
        imageView.image = UIImage(named: imageName)
        label.text =  description
        label.font = UIFont(name: "EquitanSans-Bold", size: 22)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

