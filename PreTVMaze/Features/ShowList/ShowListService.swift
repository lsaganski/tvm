//
//  ShowListService.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import Foundation

class ShowListService {
    //MARK: Properties
    let service = Service()
    
    //MARK: Public functions
    func fetchShows(page: Int) async throws -> [Show] {
        let url = String(format: Constants.URL.showIndex, page)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
    
    func searchShows(text: String) async throws -> [ShowResponse] {
        let url = String(format: Constants.URL.search, text)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
}
