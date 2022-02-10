//
//  EnterVC.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 9.02.2022.
//

import UIKit


class EnterVC: UIViewController {
    
    let button: UIButton = {
       let button = UIButton()
        button.setTitle("Oyuna Başla 🥳", for: .normal)
        button.layer.cornerRadius      = 10
        button.backgroundColor         = .systemBlue
        button.titleLabel?.textColor   = .white
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let label: UILabel  = {
       let label        = UILabel()
        label.font          = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.text          = "Wordle Türkçe"
        label.textColor     = UIColor.systemBlue
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var words : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        view.backgroundColor = .systemBackground
        configureWords()
        configureLayout()
    }
    
    @objc func startGame(){        
        let gameVC = ViewController()
        gameVC.words = words
        navigationController?.pushViewController(gameVC, animated: true)
    }
            
    func configureLayout(){
        view.addSubview(button)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 55),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
       
    }

}
