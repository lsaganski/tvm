//
//  LaunchViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class LaunchViewController: ViewController<LaunchView> {
    override func viewDidLoad() {
        guard let viewModel = viewModel as? LaunchViewModel else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()+2) { 
            viewModel.proceed()
        }
    }
}
