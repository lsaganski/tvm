//
//  ShowModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import Foundation

struct ShowResponse: Codable {
    let score: Double
    let show: Show
}

struct Show: Codable {
    let id: Int
    let name: String
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let schedule: Schedule?
    let rating: Rating?
    let network: Network?
    let webChannel: WebChannel?
    let image: Image?
    let summary: String?
    
    func getFormattedSchedule() -> String {
        var stringDays = ""
        guard let schedule, let days = schedule.days else { return stringDays }
        
        guard status == Constants.String.running else {
            return Constants.String.ended
        }

        for (index, day) in days.enumerated() {
            stringDays.append(day)
            if index < days.count-1 {
                stringDays.append(", ")
            }
        }
        
        if let time = schedule.time, !time.isEmpty {
            stringDays = String(format: Constants.String.scheduleDayTime, stringDays, time, runtime ?? 0)
        } else {
            stringDays = String(format: Constants.String.scheduleDay, stringDays, runtime ?? 0)
        }
        return stringDays
    }
    
    func getFormattedGenres() -> String {
        var result = ""
        guard let genres else { return result }
        
        for (index, genre) in genres.enumerated() {
            result.append(genre)
            if index < genres.count-1 {
                result.append(", ")
            }
        }
        return result
    }
}

struct Schedule: Codable {
    let time: String?
    let days: [String]?
}

struct Rating: Codable {
    let average: Double?
}

struct Network: Codable {
    let name: String?
}

struct WebChannel: Codable {
    let id: Int
    let name: String
}

struct Image: Codable {
    let medium: String?
    let original: String?
}
