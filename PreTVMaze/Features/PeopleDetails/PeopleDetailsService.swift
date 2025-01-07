//
//  PeopleDetailsService.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class PeopleDetailsService {
    //MARK: Properties
    let service = Service()
    
    //MARK: Public functions
    func fetchPeopleShowsList(personId: Int) async throws -> [PeopleShowResponse] {
        let url = String(format: Constants.URL.peopleShows, personId)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
}
