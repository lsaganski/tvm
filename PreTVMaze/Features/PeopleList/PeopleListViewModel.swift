//
//  PeopleListViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class PeopleListViewModel: ViewModelProtocol {
    //MARK: Properties
    let service = PeopleListService()
    var peopleList: [Person] = []
    var peopleListPage: Int = 0

    //MARK: Public functions
    func fetchPeople() async throws {
        do {
            let response: [Person] = try await service.fetchPeople(page: self.peopleListPage)
            
            if peopleListPage == 0 {
                peopleList = response
            } else {
                peopleList.append(contentsOf: response)
            }
        } catch(let error) {
            throw error
        }
    }
    
    func fetchMorePeople() async throws {
        do {
            peopleListPage += 1
            try await fetchPeople()
        } catch(let error) {
            throw error
        }
    }
    
    func searchPeople(_ text: String) async throws {
        do {
            let response: [PeopleResponse] = try await service.searchPeople(text: text)
            
            peopleListPage = 0
            peopleList = response.map { $0.person }
        } catch(let error) {
            throw error
        }
    }
}
