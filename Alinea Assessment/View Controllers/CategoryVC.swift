import UIKit

class CategoryVC: UIViewController {

    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    let categoryColors = [
        UIColor(red: 165/255, green: 163/255, blue: 253/255, alpha: 1),
        UIColor(red: 78/255, green: 79/255, blue: 207/255, alpha: 1),
        UIColor(red: 253/255, green: 215/255, blue: 62/255, alpha: 1)
    ]
    let categoryDescriptions = ["Stocks", "ETFs", "Crypto"]
    let categoryImageName = ["chart.bar.xaxis", "chart.pie.fill", "bitcoin"]
    
    private let categoryCellId = "categoryCellId"
    
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
        self.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: categoryCellId)
        self.tableView.tableFooterView = UIView()
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
extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryTableViewCell
        cell.configure(backgroundColor: categoryColors[indexPath.row], descriptionText: categoryDescriptions[indexPath.row], imageName: categoryImageName[indexPath.row], isSystemImage: indexPath.row != 2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
