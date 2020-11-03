import UIKit

class ThemesVC: UIViewController {

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    
    let descriptions: [String] = [
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
    
    private let themesCellId = "themesCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Setup Collection View
        self.setupCollectionView()
        
        /// Add CollectionView to view
        self.addSubView()
    
        /// Setup Collection View Constraints
        self.setupConstraints()
        
    }
    
    
    func setupCollectionView() {
        collectionView.register(ThemesCollectionViewCell.self, forCellWithReuseIdentifier: themesCellId)
    }

    func addSubView() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

//MARK: - CollectionView Delegate Methods
extension ThemesVC: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: themesCellId, for: indexPath) as! ThemesCollectionViewCell
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
