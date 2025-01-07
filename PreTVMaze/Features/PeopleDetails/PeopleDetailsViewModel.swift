//
//  PeopleDetailsViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class PeopleDetailsViewModel: ViewModelProtocol {
    //MARK: Properties
    let service = PeopleDetailsService()
    var personDetails: Person?
    var showsList: [Show] = []

    //MARK: Public functions
    func setPersonDetails(person: Person) {
        self.personDetails = person
    }
    
    func fetchShowsList() async throws {
        guard let personId = self.personDetails?.id else { return }
        do {
            let response: [PeopleShowResponse] = try await service.fetchPeopleShowsList(personId: personId)
            showsList = response.compactMap {
                let strId = $0.links?.show?.href
                let array = strId?.split(separator: "/")
                let id = Int(array?.last ?? "") ?? 0
                
                return Show(id: id, name: $0.links?.show?.name ?? "", genres: nil, status: nil, runtime: nil, schedule: nil, rating: nil, network: nil, webChannel: nil, image: nil, summary: nil)
            }
            return
        } catch(let error) {
            throw error
        }
    }
}
