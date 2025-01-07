//
//  AuthManager.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation
import LocalAuthentication

class AuthManager: NSObject {
    //MARK: Properties
    static let shared = AuthManager()
        
    //MARK: Public functions
    func setPIN(_ value: Int) {
        UserDefaults.standard.set(value, forKey: Constants.String.pinKey)
    }
    
    func getPIN() -> Int? {
        return UserDefaults.standard.integer(forKey: Constants.String.pinKey)
    }
    
    func authorizeFaceId() {
        UserDefaults.standard.set(true, forKey: Constants.String.authFaceId)
    }
    
    func isFaceIdAuthorized() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.String.authFaceId)
    }

    func doFaceId(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentication is required"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                completion(success, error)
            }
        } else {
            completion(false, nil)
        }
    }
}
