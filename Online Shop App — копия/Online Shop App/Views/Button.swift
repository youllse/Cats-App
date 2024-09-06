
import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, fontOfTitle: CGFloat, backgroundColor: UIColor, tint: UIColor){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontOfTitle, weight: .semibold)
        self.backgroundColor = backgroundColor
        self.setTitleColor(tint, for: .normal)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
