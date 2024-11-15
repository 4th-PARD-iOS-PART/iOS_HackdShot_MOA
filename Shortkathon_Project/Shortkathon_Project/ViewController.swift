import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var isSplashScreenVisible = true
    
    // 스플래시 화면 이미지
    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")  // "image1"이라는 스플래시 화면 이미지
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 메인 화면 구성 요소들
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "파드 숏커톤 이야기"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let sublabel = UILabel()
        sublabel.text = "프로젝트에 참여한 인원을 추가해주세요"
        sublabel.font = UIFont.boldSystemFont(ofSize: 20)
        sublabel.textAlignment = .left
        sublabel.translatesAutoresizingMaskIntoConstraints = false
        return sublabel
    }()
    
    private let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .systemGray4
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var tableData: [String] = []  // 데이터 배열
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star 10")  // 별 이미지 추가
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 스플래시 화면 추가
        view.addSubview(splashImageView)
        NSLayoutConstraint.activate([
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            splashImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        // 스플래시 화면을 숨기고 메인 화면을 보여주는 타이머 설정 (3초 후)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMainView()
        }
        
        // 메인 화면 구성
        setupMainView()
    }
    
    private func showMainView() {
        // 스플래시 화면 숨기기
        splashImageView.isHidden = true
        
        // 메인 화면을 보여줌
        titleLabel.isHidden = false
        subtitleLabel.isHidden = false
        tableView.isHidden = false
        myButton.isHidden = false
    }
    
    private func setupMainView() {
        // 메인 화면에 추가될 UI 요소들
        view.addSubview(titleLabel)
        view.addSubview(starImageView)
        view.addSubview(subtitleLabel)
        view.addSubview(tableView)
        
        // 테이블 뷰 데이터
        tableView.dataSource = self
        tableView.delegate = self
        
        // 버튼 클릭 이벤트 추가
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(myButton)
        
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Star image view constraints
            starImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -130),
            starImageView.widthAnchor.constraint(equalToConstant: 30),
            starImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Subtitle label constraints
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Table view constraints
            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Button constraints
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.widthAnchor.constraint(equalToConstant: 350),
            myButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // 테이블 뷰에 대한 셀 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 메인 화면 요소들 숨기기
        titleLabel.isHidden = true
        subtitleLabel.isHidden = true
        tableView.isHidden = true
        myButton.isHidden = true
    }
    
    @objc private func buttonTapped() {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    // 데이터 갱신
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableData = DataStruct.projects.map { $0.projectName }
        tableView.reloadData()
    }
}
