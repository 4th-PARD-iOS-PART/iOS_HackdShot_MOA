//
//  EditTaskViewController.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class EditModalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tasks: [String] = [] // 수정할 Task 목록
    var onTasksUpdated: (([String]) -> Void)? // 수정 완료 콜백

    private var tableView: UITableView!
    private var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        setupSaveButton()
    }

    private func setupNavigationBar() {
        title = "Edit Tasks"
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditTaskCell.self, forCellReuseIdentifier: "EditTaskCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }

    private func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        saveButton.addTarget(self, action: #selector(saveTasks), for: .touchUpInside)
    }

    @objc private func saveTasks() {
        // Gather all updated task strings
        var updatedTasks: [String] = []

        for index in 0..<tasks.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? EditTaskCell {
                let updatedText = cell.taskTextField.text ?? ""
                updatedTasks.append(updatedText)
            }
        }

        onTasksUpdated?(updatedTasks) // Send updated tasks back
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTaskCell", for: indexPath) as? EditTaskCell else {
            return UITableViewCell()
        }

        cell.taskTextField.text = tasks[indexPath.row] // Pre-fill text field with current task
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
