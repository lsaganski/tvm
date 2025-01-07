//
//  ShowDetailsViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import Foundation

class ShowDetailsViewModel: ViewModelProtocol {
    //MARK: Properties
    let service = ShowDetailsService()
    var showDetails: Show?
    var showEpisodeList: [Episode] = []
    var seasons: [Int] = []

    //MARK: Public functions
    func setShowDetails(show: Show) {
        self.showDetails = show
    }
    
    func fetchEpisodeList() async throws {
        guard let showId = self.showDetails?.id else { return }
        do {
            let response: [Episode] = try await service.fetchShowEpisodeList(showId: showId)
            seasons = Array(Set(response.compactMap { $0.season })).sorted()
            showEpisodeList = response
            return
        } catch(let error) {
            throw error
        }
    }
}
