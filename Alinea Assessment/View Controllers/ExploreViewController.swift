import UIKit


class ExploreViewController: UIViewController {

    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()


    let viewControllers = [CategoryVC(), ThemesVC(), TrendingVC()]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMenuBar()
        setupScrollView()
        setupNotification()
    }
    
    private let normalCellId = "cellNormal"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuBar.selectItem(row: 0)
    }
    
    lazy var categoryChildViewController: CategoryVC = {
        return CategoryVC()
    }()
    
    lazy var themesChildViewController: ThemesVC = {
        return ThemesVC()
    }()
    
    lazy var trendingChildViewController: TrendingVC = {
        return TrendingVC()
    }()
}


//MARK: - Scroll View Methods

extension ExploreViewController: UIScrollViewDelegate {
    func setupScrollView() {
        scrollView.delegate = self
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height)
        ])
    
        
        let viewsArray = [categoryChildViewController.view, themesChildViewController.view, trendingChildViewController.view]
        var previousAnchor = scrollView.leadingAnchor
        scrollView.backgroundColor = .white
        
        for (index, childView) in  viewsArray.enumerated() {
            let childView = childView!
            
            if index == 1 {
                collectionView.backgroundColor = .white
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                collectionView.register(ThemesCollectionViewCell.self, forCellWithReuseIdentifier: normalCellId)
                scrollView.addSubview(collectionView)
                
                NSLayoutConstraint.activate([
                    collectionView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 20),
                    collectionView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
                    collectionView.trailingAnchor.constraint(equalTo: previousAnchor, constant: UIScreen.main.bounds.width),
                    collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height)
                ])
                previousAnchor = collectionView.trailingAnchor
            } else {
                childView.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(childView)
                
                NSLayoutConstraint.activate([
                    childView.leadingAnchor.constraint(equalTo: previousAnchor),
                    childView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
                    childView.trailingAnchor.constraint(equalTo: previousAnchor, constant: UIScreen.main.bounds.width),
                    childView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height)
                ])
                
                previousAnchor = childView.trailingAnchor
            }
            
           
            
            
        }
        previousAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        menuBar.selectItem(row: Int(pageNumber))
    }
    
    func scrollToPage(pageNumber: Int) {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.contentOffset.x = UIScreen.main.bounds.width * CGFloat(pageNumber)
        })
    }
}

//MARK: - Menu bar Methods
extension ExploreViewController {
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
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellId, for: indexPath) as! ThemesCollectionViewCell
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
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20)
    }
}


//MARK: - Page Handling Methods
extension ExploreViewController {
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changePage(notification:)), name: .changePageNotification, object: nil)
    }
    
    @objc func changePage(notification: NSNotification) {
        if let pageNumber = notification.userInfo?["displayPage"] as? Int {
            scrollToPage(pageNumber: pageNumber)
        }
    }
}


