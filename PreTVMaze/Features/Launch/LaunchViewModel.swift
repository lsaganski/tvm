//
//  LaunchViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class LaunchViewModel: ViewModelProtocol {
    //MARK: Properties
//    var episodeDetails: Episode?

    //MARK: Public functions
    func proceed() {
        if let pin = AuthManager.shared.getPIN(), pin > 0 {
            SessionManager.shared.coordinator?.goToSignIn()
        } else {
            SessionManager.shared.coordinator?.goToSignUp()
        }
    }
}
