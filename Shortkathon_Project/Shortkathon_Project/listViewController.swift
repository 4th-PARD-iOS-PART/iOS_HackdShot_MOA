//
//  listViewController.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class listViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Task 데이터 소스
    private var tasks: [String] = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"]
    
    private var tableView: UITableView!
    private var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
        setupEditButton()
    }
    
    private func setupNavigationBar() {
        title = "Task List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close))
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    
    private func setupEditButton() {
        editButton = UIButton(type: .system)
        editButton.setTitle("Edit Tasks", for: .normal)
        editButton.backgroundColor = .systemBlue
        editButton.setTitleColor(.white, for: .normal)
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
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func openEditTasksView() {
        let editTasksVC = EditModalViewController()
        editTasksVC.modalPresentationStyle = .formSheet
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") ?? UITableViewCell(style: .default, reuseIdentifier: "taskCell")
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete \(tasks[indexPath.row])?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteTask(at: indexPath.row)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteTask(at index: Int) {
        tasks.remove(at: index)
        tableView.reloadData()
    }
}