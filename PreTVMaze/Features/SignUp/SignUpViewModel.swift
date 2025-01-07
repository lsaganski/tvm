//
//  SignUpViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class SignUpViewModel: ViewModelProtocol {
    //MARK: Properties
    var pin: Int?
    
    //MARK: Public functions
    func go() {
        if let pin {
            AuthManager.shared.setPIN(pin)
            SessionManager.shared.coordinator?.goToShowList()
        }
    }
}
