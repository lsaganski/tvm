//
//  ShowEpisodeModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

struct Episode: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let season: Int?
    let number: Int?
    let runtime: Int?
    let rating: Rating?
    let image: Image?
    let summary: String?
}
