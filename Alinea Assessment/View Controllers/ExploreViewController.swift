import UIKit


class ExploreViewController: UIViewController {
    
    let categoryCellId = "categoryCell"
    let trendingCellId = "trendingCell"
    let themesCellId = "themesCell"
    
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    // First Page Data
    let categoryColors = [
        UIColor(red: 165/255, green: 163/255, blue: 253/255, alpha: 1),
        UIColor(red: 78/255, green: 79/255, blue: 207/255, alpha: 1),
        UIColor(red: 253/255, green: 215/255, blue: 62/255, alpha: 1)
    ]
    let categoryDescriptions = ["Stocks", "ETFs", "Crypto"]
    let categoryImageName = ["chart.bar.xaxis", "chart.pie.fill", "bitcoin"]
    
    // Third Page Data
    let companies = ["Medifast", "Pinterest", "Slack Technologies", "Evoqua Water"]
    let sectionNames = ["Top Gainers", "Top Sellers"]
    let sections: [Int : [Int]] = [0 : [0, 1, 2, 3], 1 : [2, 3]]
    let topGainers = [0, 1, 2, 3]
    let topSellers = [2, 3]
    let shortNames: [String] = ["MEDI","PINS","WORK", "AQUA"]
    let changes: [String] = ["+50.78" , "-4.77%", "-5.99%" , "+5.99%"]
    let imagesDict: [String] = ["medi","pinterest", "slack", "evoqua"]
    
    
    // Second Page Data
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupMenuBar()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)

        setupTableView()
        setupCollectionView()
        
    }
    
    var currPage = 0
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            if currPage > 0 {
                currPage -= 1
            }
        } else {
            if currPage < 2  {
                currPage += 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.menuBar.selectItem(row: self.currPage)
            if self.currPage == 2 {
                self.collectionView.layer.opacity = 0
                self.tableView.layer.opacity = 1
                self.collectionView.isScrollEnabled = false
                self.collectionView.isUserInteractionEnabled = false
                self.tableView.backgroundColor = UIColor(red: 0.98, green: 0.984, blue: 0.989, alpha: 1.0)
            } else {
                if self.currPage == 1 {
                    self.collectionView.layer.opacity = 1
                    self.tableView.layer.opacity = 0
                    self.collectionView.isScrollEnabled = true
                    self.collectionView.isUserInteractionEnabled = true
                } else {
                    self.collectionView.layer.opacity = 0
                    self.tableView.layer.opacity = 1
                    self.collectionView.isScrollEnabled = false
                    self.collectionView.isUserInteractionEnabled = false
                    self.tableView.backgroundColor = .white
                }
                
            }
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuBar.selectItem(row: 0)
    }
    
    
    func setupNavBar() {
        navigationItem.title = "Explore"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 0, blue: 0, alpha: 0.8),
            NSAttributedString.Key.font: UIFont(name: "EquitanSans-Bold", size: 24)!
        ]
        hideNavigationBarBorder()
        setupNavigationBarButtons()
    }
    
    func hideNavigationBarBorder() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupNavigationBarButtons() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "text.alignleft"), style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
    }
    
   
    
    private func setupMenuBar() {
        // Get the layout guide for current views safe area
        let margins = view.layoutMarginsGuide
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            menuBar.topAnchor.constraint(equalTo: margins.topAnchor)
        ])
       
        
        
    }

}

// Table View methods
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: categoryCellId)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: trendingCellId)
        // Hides empty cells of table view
        tableView.tableFooterView = UIView()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height)
        ])
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currPage == 2 {
            return sections[section]!.count
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currPage == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: trendingCellId, for: indexPath) as! TrendingTableViewCell
            let companyIndex = sections[indexPath.section]![indexPath.row]
            cell.configure(imageName: imagesDict[companyIndex], companyName: companies[companyIndex], shortName: shortNames[companyIndex], change: changes[companyIndex])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryTableViewCell
        cell.configure(backgroundColor: categoryColors[indexPath.row], descriptionText: categoryDescriptions[indexPath.row], imageName: categoryImageName[indexPath.row], isSystemImage: indexPath.row != 2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return currPage == 0 ? 130 : 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currPage == 2 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if currPage != 2 {
            return UIView()
        }
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont(name: "EquitanSans-Bold", size: 23)!
        myLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        let headerView = UIView()
        headerView.addSubview(myLabel)
        headerView.backgroundColor = .white
        return headerView
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if currPage == 2 {
            return sectionNames[section]
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return currPage == 2 ? 30 : 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if currPage == 2 && section != 1 {
            let footerView = UIView()
            footerView.backgroundColor = UIColor(red: 0.98, green: 0.984, blue: 0.989, alpha: 1.0)
            return footerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if currPage == 2 && section != 1 {
            return 2
        }
        return 0
    }
}


// Collection View Methods

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.layer.opacity = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.isScrollEnabled = false
        self.collectionView.isUserInteractionEnabled = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: trendingCellId)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellId, for: indexPath) as! CustomCollectionViewCell
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

//MARK: - Collection View Cell for Themes Page
class CustomCollectionViewCell: UICollectionViewCell {
    
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

//MARK: - Navigation Bar Button Item Methods
extension ExploreViewController {
    @objc func leftBarButtonItemTapped() {
        print("Left Bar Button Tapped")
    }
    
    @objc func rightBarButtonItemTapped() {
        print("Right Bar Button Tapped")
    }
}


//MARK: - UIImage Extension
extension UIImageView {
   func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
    
}
