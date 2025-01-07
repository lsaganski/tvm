//
//  SignUpView.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class SignUpView: UIView {
    // MARK: Properties
    let logoImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "tvm-logo")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    let nameLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.text = "Hello!!!\nWelcome to the TVM Show app!\nType a 3 digits PIN to SignUp."
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let pinTextField: PlaceholderTextField = {
        $0.placeholder = "type your PIN"
        $0.font = .systemFont(ofSize: 20)
        $0.isSecureTextEntry = true
        $0.textAlignment = .center
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.keyboardType = .numberPad
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(PlaceholderTextField())

    let goButton: UIButton = {
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("GO", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .clear
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 3
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    //MARK: Lifecycle
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Private Methods
    private func setupUI() {
        backgroundColor = .background
        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(pinTextField)
        addSubview(goButton)

        setupConstraints()
        
        pinTextField.addTarget(self, action: #selector(onEditing), for: .editingChanged)
        pinTextField.becomeFirstResponder()
    }
    
    @objc
    private func onEditing() {
        let typed = pinTextField.text ?? ""
        let maxLength = 3
        pinTextField.text = typed.prefix(maxLength).lowercased()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -40),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 135),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -135),

            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            pinTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            pinTextField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            pinTextField.widthAnchor.constraint(equalToConstant: 150),
            pinTextField.heightAnchor.constraint(equalToConstant: 50),

            goButton.topAnchor.constraint(greaterThanOrEqualTo: pinTextField.bottomAnchor, constant: 10),
            goButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            goButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            goButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
