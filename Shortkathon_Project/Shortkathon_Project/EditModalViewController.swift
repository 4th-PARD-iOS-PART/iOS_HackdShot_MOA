//
//  ListEditModal.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class EditModalViewController: UIViewController {

//    var list  // 이걸로 list item 받아와서 수정한다.
    
    var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    var TextField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    var TextField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    var TextField3: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    var TextField4: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    var TextField5: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        submitButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        view.addSubview(submitButton)
        
//        view.addSubview(nameTextField)
//        view.addSubview(ageTextField)
//        view.addSubview(partTextField)
        
        setConstraint()
    }
    
    func setConstraint() {
        TextField1.translatesAutoresizingMaskIntoConstraints = false
        TextField2.translatesAutoresizingMaskIntoConstraints = false
        TextField3.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            TextField1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            TextField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            TextField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            TextField2.topAnchor.constraint(equalTo: TextField1.bottomAnchor, constant: 20),
            TextField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            TextField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
//            submitButton.topAnchor.constraint(equalTo: partTextField.bottomAnchor, constant: 500),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
                
    }
    
    // for adding data
//    @objc func pressButton() {
//        guard let name = nameTextField.text, let part = partTextField.text, let ageStr = ageTextField.text, let age = Int(ageStr)
//        else { return }
//          
//        let user = MemberData(name: name, part: part, age: age)
//
//        print("Generated Member Data: \(user)")
//        let APIService = APIService()
//        APIService.postRequest(body: user) { (result: Result<MemberData, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                    case .success:
//                        print("Success Adding")
//                        NotificationCenter.default.post(name: .memberNotice, object: nil)
//                        self.dismiss(animated: true)
//                    case .failure(let error):
//                        print("Failed to add member: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
}

extension Notification.Name {
    static let memberNotice = Notification.Name("change")
}
