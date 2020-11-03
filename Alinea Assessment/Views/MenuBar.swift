import UIKit


class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isUserInteractionEnabled = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let cellId = "celId"
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        self.addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.setupCell(for: indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected IndexPath: \(indexPath.row)")
    }
    
    
    func selectItem(row: Int) {
        collectionView.selectItem(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}




//MARK: - Custom UICollectionViewCell
class MenuCell: UICollectionViewCell {
    // Displays option
    let label: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    // Label used for highlighting text
    let emptyLabel: UILabel = {
        let label = UILabel()
        return label
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
    let cellNames = ["Category" , "Themes", "Trending"]
    
    func setupCell(for id: Int) {
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
        addSubview(label)
        addSubview(emptyLabel)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
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








//MARK: - Constraints
extension UIView {

    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
    }
    
    func addConstraintsFillEntireView(view: UIView) {
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
    }
}







//MARK: - UIColor custom colors

extension UIColor {
    
    
    static let customBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    static let customPurple = UIColor(red: 165 / 255, green: 164 / 255, blue: 253 / 255, alpha: 1)
    static let underlinePurple = UIColor(red: 78 / 255, green: 79 / 255, blue: 207 / 255, alpha: 1)
}




//MARK: - String Extensions
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

            return ceil(boundingBox.width)
        }
}
