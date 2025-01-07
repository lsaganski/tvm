//
//  SignUpViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class SignUpViewController: ViewController<SignUpView> {
    override func viewDidLoad() {
        setupActions()
    }
    
    func setupActions() {
        customView.goButton.addTarget(self, action: #selector(go), for: .touchUpInside)
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        customView.addGestureRecognizer(viewTap)
    }
    
    @objc
    func go() {
        guard let viewModel = viewModel as? SignUpViewModel,
            let pin = Int(customView.pinTextField.text ?? "") else { return }
        viewModel.pin = pin
        viewModel.go()
    }
}
