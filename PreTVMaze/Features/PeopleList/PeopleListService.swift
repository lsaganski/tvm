//
//  PeopleListService.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class PeopleListService {
    //MARK: Properties
    let service = Service()
    
    //MARK: Public functions
    func fetchPeople(page: Int) async throws -> [Person] {
        let url = String(format: Constants.URL.peopleIndex, page)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
    
    func searchPeople(text: String) async throws -> [PeopleResponse] {
        let url = String(format: Constants.URL.peopleSearch, text)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
}
