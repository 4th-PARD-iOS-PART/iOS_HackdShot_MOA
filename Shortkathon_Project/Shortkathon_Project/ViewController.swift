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
    
    private var tableData: [String] = ["Project 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 화면에 추가할 요소들
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        // 테이블뷰 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 제약 조건 설정
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
        
        // 테이블 뷰 셀 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // ADD 버튼 액션 설정
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // ADD 버튼 클릭 시 호출되는 메서드
    @objc private func buttonTapped() {
        // 새로운 프로젝트 항목을 추가
        tableData.append("Project \(tableData.count + 1)")
        
        // 테이블뷰 갱신
        tableView.reloadData()
        
        // 테이블 뷰의 마지막 셀(ADD 버튼)이 자동으로 보이도록 스크롤
        let indexPath = IndexPath(row: tableData.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    // UITableViewDataSource 메서드 구현
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count + 1  // 하나 더 추가하여 ADD 버튼 포함
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if indexPath.row == tableData.count {
            // ADD 버튼은 마지막 셀에서 처리
            cell.contentView.addSubview(myButton)
            
            // 버튼의 제약 조건 설정
            NSLayoutConstraint.activate([
                myButton.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
                myButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                myButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                myButton.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
            ])
        } else {
            // Project 항목을 표시
            cell.textLabel?.text = tableData[indexPath.row]
        }
        
        return cell
    }
    
    // UITableViewDelegate 메서드 구현 (셀의 높이 설정)
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ADD 버튼이 있는 셀의 높이를 다르게 설정
        if indexPath.row == tableData.count {
            return 60  // ADD 버튼이 있는 셀의 높이
        } else {
            return 44  // Project 항목의 기본 셀 높이
        }
    }
}
