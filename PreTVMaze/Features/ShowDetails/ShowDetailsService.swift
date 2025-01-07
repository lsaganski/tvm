//
//  ShowDetailsService.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import Foundation

class ShowDetailsService {
    //MARK: Properties
    let service = Service()
    
    //MARK: Public functions
    func fetchShowDetails(showId: Int) async throws -> Show {
        let url = String(format: Constants.URL.showDetails, showId)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
    
    func fetchShowEpisodeList(showId: Int) async throws -> [Episode] {
        let url = String(format: Constants.URL.showEpisodes, showId)
        do {
            return try await service.get(strUrl: url)
        } catch(let error) {
            throw error
        }
    }
}
