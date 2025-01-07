//
//  ShowListViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 04/01/25.
//

import Foundation

class ShowListViewModel: ViewModelProtocol {
    //MARK: Properties
    let service = ShowListService()
    var showList: [Show] = []
    var showListPage: Int = 0

    //MARK: Public functions
    func fetchShows() async throws {
        do {
            let response: [Show] = try await service.fetchShows(page: self.showListPage)
            
            if showListPage == 0 {
                showList = response
            } else {
                showList.append(contentsOf: response)
            }
        } catch(let error) {
            throw error
        }
    }
    
    func fetchMoreShows() async throws {
        do {
            showListPage += 1
            try await fetchShows()
        } catch(let error) {
            throw error
        }
    }
    
    func searchShows(_ text: String) async throws {
        do {
            let response: [ShowResponse] = try await service.searchShows(text: text)
            
            showListPage = 0
            showList = response.map { $0.show }
        } catch(let error) {
            throw error
        }
    }
}
