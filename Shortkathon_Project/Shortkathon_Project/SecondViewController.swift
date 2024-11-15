import UIKit

class SecondViewController: UIViewController {
    
    var personList: [String] = []
    var projectName: String?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isHidden = true
        return stackView
    }()
    
    let headLabel: UILabel = {
        let label = UILabel()
        label.text = "파드 숏커톤 회의"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star 10")  // 별 이미지 설정
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let subHeadLabel: UILabel = {
        let label = UILabel()
        label.text = "프로젝트에 참여하는 인원을 등록해 주세요."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    let projectTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "프로젝트 이름을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0.2, alpha: 1)
        textField.textColor = .white
        return textField
    }()
    
    let saveProjectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로젝트 저장", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        return button
    }()
    
    let addPersonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("인원 추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        button.isEnabled = false
        return button
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 185/255, green: 255/255, blue: 50/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
        addDoneButtonToKeyboard()  // Add Done button to keyboard
    }
    
    private func setupViews() {
        view.addSubview(headLabel)
        view.addSubview(starImageView)  // 별 이미지 뷰 추가
        view.addSubview(subHeadLabel)
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
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        subHeadLabel.translatesAutoresizingMaskIntoConstraints = false
        projectTextField.translatesAutoresizingMaskIntoConstraints = false
        saveProjectButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addPersonButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 별 이미지 뷰의 위치와 크기 설정
            starImageView.centerYAnchor.constraint(equalTo: headLabel.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: headLabel.trailingAnchor, constant: 10),
            starImageView.widthAnchor.constraint(equalToConstant: 30),
            starImageView.heightAnchor.constraint(equalToConstant: 30),
            
            subHeadLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 8),
            subHeadLabel.leadingAnchor.constraint(equalTo: headLabel.leadingAnchor),
            
            projectTextField.topAnchor.constraint(equalTo: subHeadLabel.bottomAnchor, constant: 20),
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
            addPersonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPersonButton.widthAnchor.constraint(equalToConstant: 120),
            addPersonButton.heightAnchor.constraint(equalToConstant: 40),
            
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeButton.leadingAnchor.constraint(equalTo: saveProjectButton.leadingAnchor), // "프로젝트 저장" 버튼의 너비와 동일하게 설정
            completeButton.trailingAnchor.constraint(equalTo: saveProjectButton.trailingAnchor),
            completeButton.heightAnchor.constraint(equalTo: saveProjectButton.heightAnchor)
        ])
    }
    
    @objc private func saveProjectName() {
        if let projectNameText = projectTextField.text, !projectNameText.isEmpty {
            projectName = projectNameText
            let alert = UIAlertController(title: "저장 완료", message: "프로젝트 이름이 저장되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            
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
        textField.backgroundColor = UIColor(white: 0.2, alpha: 1)
        textField.textColor = .white
        stackView.addArrangedSubview(textField)
        
        // Add the Done button to the new text field
        addDoneButtonToKeyboardForTextField(textField)
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
    
    // Add Done button to keyboard
    private func addDoneButtonToKeyboard() {
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        doneToolbar.items = [doneButton]
        
        projectTextField.inputAccessoryView = doneToolbar
    }
    
    // Add Done button to dynamically added text fields
    private func addDoneButtonToKeyboardForTextField(_ textField: UITextField) {
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        doneToolbar.items = [doneButton]
        
        textField.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
}
