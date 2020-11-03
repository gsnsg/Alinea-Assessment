import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let customTabBarView: UIView = {
        
        //  Declare customTabBar as a view
        let view = UIView(frame: .zero)
        
        // to make the cornerRadius of customTabBarView
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        // To show the shadow of tab bar
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -3.0)
        view.layer.shadowOpacity = 0.10
        view.layer.shadowRadius = 5.0
        
        return view
    }()

    
    private var backgroundViews: [UIView] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        addCustomTabBarView()
        hideTabBarBorder()
        setupViewControllers()

    }
    


    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
         customTabBarView.frame = tabBar.frame
      }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        // Bring the tab bar to front inorder to show tab bar items
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    func hideTabBarBorder()  {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage.imageWithColor(.clear, size: tabBar.frame.size)
        tabBar.clipsToBounds = true

    }
    
    
    func setupViewControllers() {
        
        let firstVC = ViewController()
        firstVC.tabBarItem = getTabBarItem(imageName: "home", tag: 0)
       
        
        let secondVC = UINavigationController(rootViewController: ExploreViewController())
        secondVC.tabBarItem = getTabBarItem(imageName: "search", tag: 1)
        
        let thirdVC = ViewController()
        thirdVC.tabBarItem = getTabBarItem(imageName: "stocks", tag: 2)
        
        
        let fourthVC = ViewController()
        fourthVC.tabBarItem = getTabBarItem(imageName: "people", tag: 3)
        
        let fifthVC = ViewController()
        fifthVC.tabBarItem = getTabBarItem(imageName: "bulb", tag: 4)
        
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        
        self.addBackgroundViews()
    }
    
    func addBackgroundViews() {
        
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        
        for index in 0 ..< 5 {
            let bgView = UIView(frame: CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: tabBar.frame.height + 25))
            bgView.backgroundColor = index == 0 ? UIColor(red: 0.307, green: 0.311, blue: 0.809, alpha: 1.0) : .white
            bgView.layer.cornerRadius = 8
            
            if index == 0 {
                bgView.layer.maskedCorners = [.layerMinXMinYCorner]
            } else if index == 4 {
                bgView.layer.maskedCorners = [.layerMaxXMinYCorner]
            } else {
                bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            bgView.clipsToBounds = true

            tabBar.insertSubview(bgView, at: index)
            backgroundViews.append(bgView)
        }
       
    }
    
    
    
    func getTabBarItem(imageName: String, tag: Int, isSystemImage: Bool = false) -> UITabBarItem {
        
        let image = UIImage(named: imageName)
        let selectedImage =  UIImage(named: imageName + "-selected")
       
        let tabBarItem: UITabBarItem = UITabBarItem(title: nil, image: image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        tabBarItem.tag = tag
        tabBarItem.title = nil
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)
        return tabBarItem
    }
    
}




//MARK: - Tab Bar Delegate Methods

extension TabBarController {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        for (index, bgView) in backgroundViews.enumerated() {
            if index == viewController.tabBarItem.tag {
                bgView.backgroundColor = UIColor(red: 0.307, green: 0.311, blue: 0.809, alpha: 1.0)
            } else {
                bgView.backgroundColor = .white
            }
        }
    }

}

