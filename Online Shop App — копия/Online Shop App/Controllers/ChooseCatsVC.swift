

import UIKit

class ChooseCatsVC: UIViewController {
    
    var cats: [Cat] = []
    var tableView: UITableView!
    static var selectedCats:[Cat] = []
    let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
        setUpTableView()
        setUpRefresh()
        fetchCats()
    }
    
    
    //MARK: - cobfigure ViewController
    func setUpController(){
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Choose a Cat"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    
    //MARK: - configure TableView
    func setUpTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = refresh
        view.addSubview(tableView)
    }
    
    
    //MARK: - configure RefreshController
    func setUpRefresh(){
        view.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }
    
    @objc func refreshing(){
        fetchCats()
    }
    
    
    //MARK: - fetch the data
    func fetchCats() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10") else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Failed to fetch cats: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    return
                }
                
                do {
                    self.cats = try JSONDecoder().decode([Cat].self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refresh.endRefreshing()
                    }
                } catch {
                    print("Failed to decode cats: \(error)")
                }
            }
            task.resume()
        }
    
    
    
    //MARK: - create a alert
    func showAlert(){
        let alert = UIAlertController(title: "new cat", message: "you added a new cat", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }

}


//MARK: - DataSource and Delegate
extension ChooseCatsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CatTableViewCell
        let cat = cats[indexPath.row]
        cell.configure(with: cat.url, name: cat.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ChooseCatsVC.selectedCats.append(cats[indexPath.row])
        showAlert()
    }
}


