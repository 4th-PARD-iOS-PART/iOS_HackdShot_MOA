import UIKit

class listViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 프로젝트를 받는 변수
    var project: Project?
    
    private var tasks: [String] = []
    private var tableView: UITableView!
    private var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black  // 배경 색을 검은색으로 설정
        
        setupNavigationBar()
        setupTableView()
        setupEditButton()
        
        loadTasksForProject()
    }
    
    private func setupNavigationBar() {
        title = project?.projectName ?? "Task List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close))
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        // 테이블 뷰의 배경 색을 검은색으로 설정
        tableView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    
    private func setupEditButton() {
        editButton = UIButton(type: .system)
        editButton.setTitle("회의 종료하기", for: .normal)
        editButton.backgroundColor = UIColor(red: 185/255, green: 255/255, blue: 50/255, alpha: 1)
        editButton.setTitleColor(.black, for: .normal)
        editButton.layer.cornerRadius = 10
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 150),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        editButton.addTarget(self, action: #selector(openEditTasksView), for: .touchUpInside)
    }
    
    private func loadTasksForProject() {
        // project가 nil인지 확인
        guard let projectName = project?.projectName else {
            print("Error: project is nil")
            return
        }
        
        // 디버깅을 위한 출력
        print("Project Name: \(projectName)")
        print("DataStruct Tasks: \(DataStruct.tasks.map { $0.taskName ?? "nil" })")
        
        // DataStruct.tasks에서 필터링 없이 모든 할 일을 그대로 tasks 배열에 할당
        tasks = DataStruct.tasks.map { $0.taskName ?? "" } // taskName이 nil인 경우 빈 문자열로 처리
        
        // 테이블을 업데이트
        tableView.reloadData()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func openEditTasksView() {
        let editTasksVC = EditModalViewController()
        editTasksVC.modalPresentationStyle = .formSheet
        
        // 모달창 배경 색을 검은색으로 설정
        editTasksVC.view.backgroundColor = .black
        
        editTasksVC.tasks = tasks
        
        // 수정 완료 콜백 설정
        editTasksVC.onTasksUpdated = { [weak self] updatedTasks in
            self?.tasks = updatedTasks
            self?.tableView.reloadData()
        }
        
        present(editTasksVC, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(tasks.count)")
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") ?? UITableViewCell(style: .default, reuseIdentifier: "taskCell")
        
        cell.backgroundColor = .gray
        
        cell.textLabel?.textColor = .white
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        print("\(tasks[indexPath.row])")
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // DataStruct.names에서 랜덤으로 name을 가져옵니다.
        let randomIndex = Int(arc4random_uniform(UInt32(DataStruct.names.count)))
        let randomName = DataStruct.names[randomIndex].name // 랜덤으로 선택된 name
        
        // 선택된 랜덤 name을 alert에 메시지로 표시
        let alert = UIAlertController(title: "회의 정리", message: "이번 안건의 정리자는 \(randomName) 님 입니다.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "온전히 이해함", style: .destructive) { [weak self] _ in
            self?.deleteTask(at: indexPath.row)
        }
        let cancelAction = UIAlertAction(title: "이해하지 못함", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteTask(at index: Int) {
        tasks.remove(at: index)
        tableView.reloadData()
    }
}
