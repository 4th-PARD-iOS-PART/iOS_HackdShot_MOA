//
//  SecondViewController.swift
//  Shortkathon_Project
//
//  Created by 김도원 on 11/16/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    var personList: [String] = []
    var projectName: String? // 프로젝트 이름 받는 칸
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isHidden = true // 초기에는 숨김 처리
        return stackView
    }()
    
    let projectTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "프로젝트 이름을 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let saveProjectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로젝트 저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        return button
    }()
    
    let addPersonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("인원 추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.isEnabled = false // 초기에는 비활성화
        return button
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        button.isEnabled = false // 초기에는 비활성화
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "프로젝트 및 인원 입력"
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(projectTextField)
        view.addSubview(saveProjectButton)
        view.addSubview(stackView)
        view.addSubview(addPersonButton)
        view.addSubview(completeButton)
        
        saveProjectButton.addTarget(self, action: #selector(saveProjectName), for: .touchUpInside)
        addPersonButton.addTarget(self, action: #selector(addPersonField), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(navigateToThird), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        projectTextField.translatesAutoresizingMaskIntoConstraints = false
        saveProjectButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addPersonButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            projectTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            projectTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            projectTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveProjectButton.topAnchor.constraint(equalTo: projectTextField.bottomAnchor, constant: 16),
            saveProjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveProjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveProjectButton.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: saveProjectButton.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addPersonButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            addPersonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPersonButton.widthAnchor.constraint(equalToConstant: 120),
            addPersonButton.heightAnchor.constraint(equalToConstant: 40),
            
            completeButton.topAnchor.constraint(equalTo: addPersonButton.bottomAnchor, constant: 20),
            completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeButton.widthAnchor.constraint(equalToConstant: 120),
            completeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func saveProjectName() {
        if let projectNameText = projectTextField.text, !projectNameText.isEmpty {
            projectName = projectNameText
            let alert = UIAlertController(title: "저장 완료", message: "프로젝트 이름이 저장되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            
            // 인원 추가 버튼과 스택 뷰 활성화
            addPersonButton.isEnabled = true
            completeButton.isEnabled = true
            stackView.isHidden = false
        } else {
            let alert = UIAlertController(title: "오류", message: "프로젝트 이름을 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc private func addPersonField() {
        if let lastTextField = stackView.arrangedSubviews.last as? UITextField,
           let text = lastTextField.text,
           !text.isEmpty {
            personList.append(text)
        }
        
        let textField = UITextField()
        textField.placeholder = "인원 \(stackView.arrangedSubviews.count + 1):"
        textField.borderStyle = .roundedRect
        stackView.addArrangedSubview(textField)
    }
    
    @objc private func navigateToThird() {
        guard let projectName = projectName else {
            let alert = UIAlertController(title: "오류", message: "프로젝트 이름을 먼저 저장해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        for name in personList {
            DataStruct.names.append(Name(name: name))
        }
        
        DataStruct.projects.append(Project(projectName: projectName))
        
        let thirdVC = ThirdViewController()
        thirdVC.modalPresentationStyle = .fullScreen
        present(thirdVC, animated: true, completion: nil)
    }
}
