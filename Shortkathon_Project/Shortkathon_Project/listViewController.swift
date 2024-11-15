//
//  listViewController.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class listViewController: UIViewController {

//    var task: InfoData?
    
    let projectLabel = UILabel()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
//        editButton.addTarget(self, action: #selector(pressEditButton), for: .touchUpInside)
//        deleteButton.addTarget(self, action: #selector(pressDeleteButton), for: .touchUpInside)
//        
//        if let item = member {
//            nameLabel.text = "\(item.name)"
//            nameLabel.font = .systemFont(ofSize: 40)
//        }
        
        view.addSubview(projectLabel)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
    }
    
    func setConstraint() {
        projectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            projectLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            projectLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ])
    }

//    // For updating data
//    @objc func pressEditButton() {
//        guard var member = member else { return }
//        // temperature for test
//        // if you want to input data for editing, use input text and assign these values to member
//        member.name = "TEST"
//        member.age = 30
//        member.part = "TEST"
//
//        let APIService = APIService()
//        APIService.patchRequest(id: member.id, body: member) { (result: Result<MemberData, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                    case .success:
//                        print("Success PATCH")
//                        NotificationCenter.default.post(name: .memberNotice, object: nil)
//                        self.dismiss(animated: true)
//                    case .failure(let error):
//                        print("Failed Edit: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    // For deleting data
//    @objc func pressDeleteButton() {
//        guard let member = member else { return }
//        APIService().deleteRequest(id: member.id) { (result: Result<MemberData?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                    case .success(let response):
//                        print("success")
//                        NotificationCenter.default.post(name: .memberNotice, object: nil)
//                        self.dismiss(animated: true)
//                    case .failure(let error):
//                        print("Failed to delete member: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//

}
