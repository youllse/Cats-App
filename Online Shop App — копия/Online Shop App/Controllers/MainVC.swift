//
//  MainVC.swift
//  Online Shop App
//
//  Created by Айбек Актанов on 30.06.2024.
//

import UIKit

class MainVC: UIViewController {

    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        setUpMainText()
        setUpButton()
        setUpMLButton()
        setUpFavButton()
    }
    
    
    //MARK: - configure main text
    private func setUpMainText(){
        let mainLabel = UILabel()
        mainLabel.text = "choose cats to melt it in another page"
        mainLabel.numberOfLines = 0 // Позволяет тексту занимать несколько строк
        mainLabel.lineBreakMode = .byWordWrapping
        mainLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        mainLabel.textColor = .label
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainLabel)
        
        // Configure constraints
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -130),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
    }
    
    
    //MARK: - configure Button
    private func setUpButton(){
        button = Button(title: "Let's go", fontOfTitle: 25, backgroundColor: .systemMint, tint: .systemBackground)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(touch), for: .touchUpInside)
        

        // Configure constraints
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    
    //MARK: - configure second button
    private func setUpFavButton(){
        let favButton = Button(title: "Favorite Cats", fontOfTitle: 18, backgroundColor: .systemBackground, tint: .systemMint)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.tintColor = .systemMint
        self.view.addSubview(favButton)
        favButton.addTarget(self, action: #selector(toFavCats), for: .touchUpInside)
        
        // Configure constraints
        NSLayoutConstraint.activate([
            favButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            favButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            favButton.widthAnchor.constraint(equalToConstant: 200),
            favButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    //MARK: - to the FavotieVC
    @objc func toFavCats(){
        let favVC = FavoritesVC()
        self.navigationController?.pushViewController(favVC, animated: true)
    }
    
    
    //MARK: - to the ChooseCatsVC
    @objc func touch(){
        let choose = ChooseCatsVC()
        self.navigationController?.pushViewController(choose, animated: true)
    }
}
