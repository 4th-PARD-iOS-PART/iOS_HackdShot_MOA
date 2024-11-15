//
//  ThirdViewController.swift
//  Shortkathon_Project
//
//  Created by 김도원 on 11/16/24.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var taskList: [String] = []
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("할 일 추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        return button
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "할 일 입력"
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(addTaskButton)
        view.addSubview(completeButton)
        
        addTaskField()
        
        addTaskButton.addTarget(self, action: #selector(addTaskField), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(showConfirmationAlert), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTaskButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            addTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskButton.widthAnchor.constraint(equalToConstant: 120),
            addTaskButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completeButton.topAnchor.constraint(equalTo: addTaskButton.bottomAnchor, constant: 20),
            completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeButton.widthAnchor.constraint(equalToConstant: 120),
            completeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func addTaskField() {
        // 현재 텍스트필드에 입력된 내용을 taskList에 추가
        if let lastTextField = stackView.arrangedSubviews.last as? UITextField {
            if let text = lastTextField.text, !text.isEmpty {
                taskList.append(text)
            }
        }

        // 새로운 텍스트필드 추가
        let textField = UITextField()
        textField.placeholder = "할 일 \(stackView.arrangedSubviews.count + 1):"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0.2, alpha: 1)
        textField.textColor = .white
        stackView.addArrangedSubview(textField)
    }

    @objc private func showConfirmationAlert() {
        // 할 일을 추가한 후 확인 알림 표시
        let alert = UIAlertController(title: "확인", message: "할 일 입력을 완료하셨습니까?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "예", style: .default) { _ in
            // 마지막 할 일이 비어있지 않다면 추가
            if let lastTextField = self.stackView.arrangedSubviews.last as? UITextField,
               let text = lastTextField.text, !text.isEmpty {
                self.taskList.append(text)
            }
            
            self.saveTasksToDataStruct()
            
            if let navigationController = self.navigationController {
                if let viewController = navigationController.viewControllers.first(where: { $0 is ViewController }) {
                    navigationController.popToViewController(viewController, animated: true)
                }
            }
        }
        
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    private func saveTasksToDataStruct() {
        for task in taskList {
            if !task.isEmpty {
                DataStruct.tasks.append(Task(taskName: task))
            }
        }
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
