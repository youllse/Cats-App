
import UIKit

class DetailsVC: UIViewController {

    var detailImage = UIImage()
    
    init(image:UIImage){
        super.init(nibName: nil, bundle: nil)
        self.detailImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailViewController()
        setUpDetailImageView()
    }
    
    func setUpDetailViewController(){
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "1 from 1"
    }
    
    func setUpDetailImageView(){
        let imageViewDetail = UIImageView(image: detailImage)
        self.view.addSubview(imageViewDetail)
        imageViewDetail.translatesAutoresizingMaskIntoConstraints = false
        imageViewDetail.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageViewDetail.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageViewDetail.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageViewDetail.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageViewDetail.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
