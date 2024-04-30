//
//  Project.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import Foundation

struct Project: Codable{
    let id: String
    let name: String
    let order: Int
    let isInbox: Bool
    let isFavorite: Bool
    let parentId: String?
    
    
    enum CodingKeys: String, CodingKey{
        case id
        case name, order
        case isInbox = "is_inbox_project"
        case isFavorite = "is_favorite"
        case parentId = "parent_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        order = try values.decode(Int.self, forKey: .order)
        isInbox = try values.decode(Bool.self, forKey: .isInbox)
        isFavorite = try values.decode(Bool.self, forKey: .isFavorite)
        parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
    }
}
