//
//  PeopleModel.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation

struct PeopleResponse: Codable {
    let score: Double
    let person: Person
}

struct Person: Codable {
    let id: Int?
    let name: String?
    let image: Image?
}

struct PeopleShowResponse: Codable {
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct Links: Codable {
    let show: PeopleShow?
}

struct PeopleShow: Codable {
    var id: Int?
    let href: String?
    let name: String?
}
