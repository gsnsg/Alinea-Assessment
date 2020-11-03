import UIKit


class ThemesCollectionView: UICollectionViewCell {
   
    let containerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isUserInteractionEnabled = true
        cv.isScrollEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let cellID = "selfself"
    private let themeCellId = "themeCellId"
    
    private let descriptions: [String] = [
        "Diversity & Inclusion",
        "Bold Biotech",
        "Crypto Central",
        "She runs it",
        "Clean & Green",
        "Cannabis-ness",
        "Power It",
        "Foodie Fun",
        "Art & Fashion",
        "Home is where the heart is"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        /// Setup Collection View
        setupViews()
        
        /// Setup constraints for collection view
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = .white
        containerView.backgroundColor = .white
        containerView.delegate = self
        containerView.dataSource = self
        containerView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        containerView.register(ThemesCollectionViewCell.self, forCellWithReuseIdentifier: themeCellId)
    }
    
    func setupConstraints() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ThemesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: themeCellId, for: indexPath) as! ThemesCollectionViewCell
        cell.configure(imageName: "\(indexPath.row + 1)", description: descriptions[indexPath.row])
        cell.backgroundColor = UIColor(red: 0.928, green: 0.937, blue: 0.976, alpha: 0.7)
        cell.layer.cornerRadius = 6
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.45, height: collectionView.frame.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    

}
