//
//  ViewController.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/14/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 제목 UILabel 생성
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MOA"  // 제목 텍스트
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 버튼 생성
    private let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 테이블뷰 생성
    private var tableView: UITableView?
    
    // 데이터 소스
    private var tableData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 색상 설정
        view.backgroundColor = .white
        
        // 제목 UILabel 추가
        view.addSubview(titleLabel)
        
        // 제목 제약 조건 설정
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // 버튼 추가
        view.addSubview(myButton)
        
        // 버튼 제약 조건 설정
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myButton.widthAnchor.constraint(equalToConstant: 100),
            myButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 버튼 클릭 시 액션 설정
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // 버튼 클릭 액션 메서드
    @objc private func buttonTapped() {
        if tableView == nil {
            // 테이블뷰 생성
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.dataSource = self
            tableView.delegate = self
            
            // 테이블뷰 추가
            view.addSubview(tableView)
            
            // 테이블뷰 제약 조건 설정
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
            
            self.tableView = tableView
        }
        
        // 데이터 추가 및 테이블뷰 갱신
//        tableData.append("Item \(tableData.count + 1)")
//        tableView?.reloadData()
        
        // add 하면 second로 넘어가서 페이지 만들어야 한다. 그리고 그것을 받아와서 프로젝트 화면을 뜨게 한다.
        
    }
    
    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
}
