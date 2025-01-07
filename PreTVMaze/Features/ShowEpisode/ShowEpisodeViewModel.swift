//
//  ShowEpisodeViewModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

class ShowEpisodeViewModel: ViewModelProtocol {
    //MARK: Properties
    var episodeDetails: Episode?

    //MARK: Public functions
    func setEpisodeDetails(episode: Episode) {
        self.episodeDetails = episode
    }
}
