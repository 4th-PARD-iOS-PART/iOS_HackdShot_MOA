//
//  EditTaskCell.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class EditTaskCell: UITableViewCell {

    let taskTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        contentView.addSubview(taskTextField)

        NSLayoutConstraint.activate([
            taskTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            taskTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            taskTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            taskTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
