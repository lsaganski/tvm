//
//  ViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 04/01/25.
//

import UIKit

class ViewController<T: UIView>: UIViewController {
    // MARK: Properties
    var customView: T {
        view as! T
    }
    
    var viewModel: ViewModelProtocol
    var rightButtonAction: (() -> ())?
    
    // MARK: Lifecycle
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = T()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
        
    // MARK: Navigation SetUp
    func showBarBackButton() {
        let image = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(performLeftButtonAction))
    }
    
    @objc
    private func performLeftButtonAction() {
        SessionManager.shared.coordinator?.back()
    }

    @objc
    private func performRightButtonAction() {
        guard let rightButtonAction else { return }
        rightButtonAction()
    }

    func setUpSearchBarButton() {
        let image = UIImage(systemName: "magnifyingglass.circle.fill")?.withRenderingMode(.alwaysTemplate)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(performRightButtonAction))
    }
    
    func hideLeftButton() {
        navigationItem.leftBarButtonItem = nil
    }
    
    func hideRightButton() {
        navigationItem.rightBarButtonItem = nil
    }
    
    //MARK: Public functions
    func handleError(_ error: Error) {
        guard let error = error as? ServiceError else {
            print(error.localizedDescription)
            return
        }
        print(error.getMessage())
    }
    
    @objc
    func onViewTap() {
        dismissKeyboard()
    }

    func dismissKeyboard() {
        customView.endEditing(true)
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
