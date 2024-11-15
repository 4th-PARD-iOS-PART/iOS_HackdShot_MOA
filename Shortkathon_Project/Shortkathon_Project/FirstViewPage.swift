import UIKit

class FirstViewPage: UIView {

    let headerButton1: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        // Add the button to the view
        addSubview(headerButton1)

        // Activate the constraints
        NSLayoutConstraint.activate([
            // Set the button's position
            headerButton1.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            headerButton1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23)
        ])
    }
}
