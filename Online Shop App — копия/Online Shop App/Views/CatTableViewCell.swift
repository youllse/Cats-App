import UIKit

class CatTableViewCell: UITableViewCell {
    
    var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var catName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        name.textColor = .systemBackground
        return name
    }()
    
    let someView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(catImageView)
        addSubview(someView)
        someView.addSubview(catName)
        
        // Настройка ограничений
        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            catImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            catImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            catImageView.heightAnchor.constraint(equalToConstant: 200),
            
            someView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            someView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            someView.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 10),
            someView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            catName.centerXAnchor.constraint(equalTo: someView.centerXAnchor),
            catName.centerYAnchor.constraint(equalTo: someView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageURL: String, name: String) {
        if let url = URL(string: imageURL) {
            self.catImageView.backgroundColor = .gray
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if let imageOfcat = UIImage(data: data) {
                            self.catImageView.image = imageOfcat
                            self.catName.text = name
                            self.catImageView.backgroundColor = .systemBackground
                            self.someView.backgroundColor = .systemMint
                        }
                    }
                }
            }
        }
    }
    
    func getCatImage() -> UIImage? {
        return catImageView.image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


