//
//  SignInViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class SignInViewModel: ViewModelProtocol {
    //MARK: Properties
    var pin: Int?
    
    //MARK: Public functions
    func go() -> Bool {
        if let pin,
           let savedPin = AuthManager.shared.getPIN(),
           pin == savedPin {
            SessionManager.shared.coordinator?.goToShowList()
        } else {
            return false
        }
        
        return true
    }
}
