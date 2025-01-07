//
//  SignInViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class SignInViewController: ViewController<SignInView> {
    override func viewDidLoad() {
        setupActions()
        verifyFaceIdAllowed()
    }
    
    func setupActions() {
        customView.goButton.addTarget(self, action: #selector(go), for: .touchUpInside)
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        customView.addGestureRecognizer(viewTap)
    }
    
    @objc
    func go() {
        guard let viewModel = viewModel as? SignInViewModel,
            let pin = Int(customView.pinTextField.text ?? "") else { return }
        viewModel.pin = pin
        if !viewModel.go() {
            showErrorMessage(message: "Invalid PIN. Try again.")
        }
    }
    
    func verifyFaceIdAllowed() {
        AuthManager.shared.doFaceId() { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    SessionManager.shared.coordinator?.goToShowList()
                } else {
                    self?.showErrorMessage(message: "Unauthorized.")
                }
            }
        }
    }
}
