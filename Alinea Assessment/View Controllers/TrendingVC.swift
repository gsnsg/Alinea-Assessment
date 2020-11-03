import UIKit

class TrendingVC: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    let companies = ["Medifast", "Pinterest", "Slack Technologies", "Evoqua Water"]
    let sectionNames = ["Top Gainers", "Top Sellers"]
    let sections: [Int : [Int]] = [0 : [0, 1, 2, 3], 1 : [2, 3]]
    let topGainers = [0, 1, 2, 3]
    let topSellers = [2, 3]
    let shortNames: [String] = ["MEDI","PINS","WORK", "AQUA"]
    let changes: [String] = ["+50.78" , "-4.77%", "-5.99%" , "+5.99%"]
    let imagesDict: [String] = ["medi","pinterest", "slack", "evoqua"]
    
    private let trendingCellId = "trendingCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /// Setup Table View
        self.setupTableView()
        
        /// Add subviews
        self.addSubViews()
        
        /// Setup Table View Constraints
        self.setupConstraints()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        self.tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: trendingCellId)
    }
    
    func addSubViews() {
        view.addSubview(tableView)
        
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



//MARK: - Table View Delegate Methods
extension TrendingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trendingCellId, for: indexPath) as! TrendingTableViewCell
        let companyIndex = sections[indexPath.section]![indexPath.row]
        cell.configure(imageName: imagesDict[companyIndex], companyName: companies[companyIndex], shortName: shortNames[companyIndex], change: changes[companyIndex])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
        
        return sectionNames[section]
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 1 {
            let footerView = UIView()
            footerView.backgroundColor = UIColor(red: 0.98, green: 0.984, blue: 0.989, alpha: 1.0)
            return footerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if section != 1 {
            return 2
        }
        return 0
    }
}
