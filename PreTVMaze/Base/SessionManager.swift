//
//  SessionManager.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

class SessionManager {
    //MARK: Properties
    static let shared = SessionManager()
    
    var coordinator: Coordinator?
     
    //MARK: Lifecycle
    private init() {}
}
