import UIKit



class MenuCell: UICollectionViewCell {
    // Displays option
    let label: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    // Label used for highlighting text
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // Clear button
    let button: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let rightBorder: UIView = {
        let view = UIView()
        return view
    }()
    
    let leftBorder: UIView = {
        let view = UIView()
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isSelected ? .customPurple : .customBlack
            emptyLabel.backgroundColor = isSelected ? .underlinePurple : .white
        }
    }
    
    // Highlight selected cell
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .customPurple : .customBlack
            emptyLabel.backgroundColor = isSelected ? .underlinePurple : .white
    
        }
    }
    
    var id = 0
    private let cellNames = ["Category" , "Themes", "Trending"]
    
    func configure(withId id: Int) {
        self.id = id
        let cellTitle = cellNames[id]
        label.text = cellTitle
        label.font =  UIFont(name: "EquitanSans-Bold", size: 19)!
        label.textColor = .customBlack
        setupViews()
        if id == 1 {
            setupBorderView()
        }
    
    }
    
    func setupBorderView() {
        rightBorder.translatesAutoresizingMaskIntoConstraints = false
        leftBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftBorder)
        addSubview(rightBorder)

        leftBorder.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        rightBorder.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        NSLayoutConstraint.activate([
            leftBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftBorder.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5),
            leftBorder.heightAnchor.constraint(equalToConstant: frame.height * 0.45),
            leftBorder.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            rightBorder.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightBorder.centerYAnchor.constraint(equalTo: centerYAnchor, constant:  -5),
            rightBorder.heightAnchor.constraint(equalToConstant: frame.height * 0.45),
            rightBorder.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    func setupViews() {
        addSubview(button)
        addSubview(label)
        addSubview(emptyLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Button Constraints
        button.tag = id
        button.backgroundColor = .clear
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        // Common constraints for both labels
        label.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        emptyLabel.heightAnchor.constraint(equalToConstant: 4).isActive = true
        emptyLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 1).isActive = true
        emptyLabel.widthAnchor.constraint(equalToConstant: cellNames[id].width(withConstrainedHeight: 19, font: UIFont(name: "EquitanSans-Bold", size: 19)!)).isActive = true
        
        if id == 0 {
            addConstraint(label.leadingAnchor.constraint(equalTo: leadingAnchor))
            NSLayoutConstraint.activate([emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor)])
        } else if(id == 1) {
            addConstraint(label.centerXAnchor.constraint(equalTo: centerXAnchor))
            NSLayoutConstraint.activate([emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
        } else {
            addConstraint(label.trailingAnchor.constraint(equalTo: trailingAnchor))
            NSLayoutConstraint.activate([emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
        }
        
        
        emptyLabel.text = String(repeating: " ", count: label.text!.count)
        emptyLabel.textColor = .white
        emptyLabel.font = UIFont(name: "EquitanSans-Bold", size: 19)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}











