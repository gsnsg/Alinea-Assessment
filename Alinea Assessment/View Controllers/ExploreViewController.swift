import UIKit


class ExploreViewController: UIViewController {

    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()


    let viewControllers = [CategoryVC(), ThemesVC(), TrendingVC()]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupMenuBar()
        setupCollectionView()
        setupConstraints()
    }
    
    private let normalCellId = "cellNormal"
    private let themeCollectionViewId = "themeCollectionView"
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: normalCellId)
        collectionView.register(ThemesCollectionView.self, forCellWithReuseIdentifier: themeCollectionViewId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height)
        ])
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuBar.selectItem(row: 0)
        
        menuBar.menuItems[0].addTarget(self, action: #selector(self.menuItemTapped(_:)), for: .touchDown)
    }
    
    
    @IBAction func menuItemTapped(_ sender: UIButton) {
        print("Menu Item Tapped: \(sender.tag)")
    }
    
    private func setupMenuBar() {
        // Get the layout guide for current views safe area
        let margins = view.layoutMarginsGuide
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            menuBar.topAnchor.constraint(equalTo: margins.topAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        
    }

}


//MARK: - Navigation Bar Methods
extension ExploreViewController {
    func setupNavigationBar() {
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
    
    @objc func leftBarButtonItemTapped() {
        print("Left Bar Button Tapped")
    }
    
    @objc func rightBarButtonItemTapped() {
        print("Right Bar Button Tapped")
    }
}

//MARK: - Collection View Delegate Methods
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellId, for: indexPath)
        if indexPath.row == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: themeCollectionViewId, for: indexPath) as! ThemesCollectionView
        } else {
            cell.contentView.addSubview(viewControllers[indexPath.row].view)
        }
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var lastIndexPath = IndexPath()
        for cell in collectionView.visibleCells {
            if collectionView.indexPath(for: cell) != nil {
                lastIndexPath = collectionView.indexPath(for: cell)!
            }
        }
        menuBar.selectItem(row: lastIndexPath.row)
    }
}




