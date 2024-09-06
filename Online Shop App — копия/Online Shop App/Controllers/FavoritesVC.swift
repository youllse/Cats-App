import UIKit

class FavoritesVC: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFavVC()
        setUpTableView()
    }
    
    
    func setUpFavVC() {
        view.backgroundColor = .systemBackground
        title = "Favorite cats"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    
    func setUpLabel() {
        let label = UILabel()
        label.text = "Choose at least one cat..."
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .lightGray
        label.tag = 999
        self.view.addSubview(label)
        
        // Настройка ограничений
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    
    func removeLabel() {
        if let label = self.view.viewWithTag(999) {
            label.removeFromSuperview()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ChooseCatsVC.selectedCats.isEmpty {
            setUpLabel()
        } else {
            removeLabel()
        }
    }
    
    
    // MARK: - Настройка TableView
    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Настройка ограничений
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: - DataSource и Delegate
extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChooseCatsVC.selectedCats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CatTableViewCell
        let oneCat = ChooseCatsVC.selectedCats[indexPath.row]
        cell?.configure(with: oneCat.url, name: oneCat.id)
        print(oneCat.id)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ChooseCatsVC.selectedCats.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
        if ChooseCatsVC.selectedCats.isEmpty {
            setUpLabel()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CatTableViewCell,
              let catImage = cell.getCatImage() else {
            return
        }
        navigationController?.pushViewController(DetailsVC(image: catImage), animated: true)
    }
}

