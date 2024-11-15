//
//  ViewController.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MOA"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var tableData: [Project] = []  // Project 객체의 배열로 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(myButton)
        
        NSLayoutConstraint.activate([
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.widthAnchor.constraint(equalToConstant: 120),
            myButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 로컬 데이터를 불러와 테이블 뷰에 표시
        tableData = DataStruct.projects
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // DataStruct.projects 배열의 projectName을 가져와 tableData에 할당
        tableData = DataStruct.projects
        
        // 테이블 뷰 갱신
        tableView.reloadData()
    }
    
    @objc private func buttonTapped() {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row].projectName
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택한 프로젝트를 listViewController에 전달
        let selectedProject = tableData[indexPath.row]
        let listVC = listViewController()
        listVC.project = selectedProject
        
        // navigationController가 있는지 확인하고, 없으면 새로 생성하여 푸시
        if let navigationController = navigationController {
            navigationController.pushViewController(listVC, animated: true)
        } else {
            // UINavigationController로 감싼 후 화면을 표시
            let navController = UINavigationController(rootViewController: listVC)
            present(navController, animated: true, completion: nil)
        }
    }
}
