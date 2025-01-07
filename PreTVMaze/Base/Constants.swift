//
//  ServiceConstants.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

struct Constants {
    struct URL {
        static let baseUrl = "https://api.tvmaze.com"
        static let showIndex = "/shows?page=%d"
        static let search = "/search/shows?q=%@"
        static let showDetails = "/shows/%d"
        static let showEpisodes = "/shows/%d/episodes"
        static let episodeDetails = "/shows/1"
        static let peopleIndex = "/people?page=%d"
        static let peopleSearch = "/search/people?q=%@"
        static let peopleDetails = "/people/%d"
        static let peopleShows = "/people/%d/castcredits"
    }
    
    struct String {
        static let scheduleDay = "%1$@ (%2$d min)"
        static let scheduleDayTime = "%1$@ at %2$@ (%3$d min)"
        static let ended = "Ended"
        static let running = "Running"
        static let episodes = "Episodes"
        static let shows = "Shows"
        static let season = "Season %d"
        static let pinKey = "TMZPINKEY"
        static let authFaceId = "AuthFaceId"
    }
}
