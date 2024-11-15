//
//  SecondViewController.swift
//  Shortkathon_Project
//
//  Created by 김도원 on 11/16/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    var personList: [String] = []
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let addPersonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("인원 추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        return button
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "인원 입력"
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(addPersonButton)
        view.addSubview(completeButton)
        
        addPersonField()
        
        addPersonButton.addTarget(self, action: #selector(addPersonField), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(navigateToThird), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        addPersonButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPersonButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            addPersonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPersonButton.widthAnchor.constraint(equalToConstant: 120),
            addPersonButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completeButton.topAnchor.constraint(equalTo: addPersonButton.bottomAnchor, constant: 20),
            completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeButton.widthAnchor.constraint(equalToConstant: 120),
            completeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func addPersonField() {
        if let lastTextField = stackView.arrangedSubviews.last as? UITextField {
            if let text = lastTextField.text, !text.isEmpty {
                personList.append(text)
            } else {
                return
            }
        }
        
        let textField = UITextField()
        textField.placeholder = "인원 \(stackView.arrangedSubviews.count + 1):"
        textField.borderStyle = .roundedRect
        stackView.addArrangedSubview(textField)
    }
    
    @objc private func navigateToThird() {
        for name in personList {
            DataStruct.names.append(Name(name: name))
        }
        
        let thirdVC = ThirdViewController()
        thirdVC.modalPresentationStyle = .fullScreen
        present(thirdVC, animated: true, completion: nil)
    }
}
