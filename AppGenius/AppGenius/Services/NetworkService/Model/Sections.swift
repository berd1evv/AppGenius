//
//  Section.swift
//  AppGenius
//
//  Created by Eldiiar on 1/5/24.
//

import Foundation

struct Sections: Codable, Identifiable, Hashable{
    let id: String
    let name: String
    let order: Int
    let projectId: String?
    
    
    enum CodingKeys: String, CodingKey{
        case id
        case name, order
        case projectId = "project_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        order = try values.decode(Int.self, forKey: .order)
        projectId = try values.decodeIfPresent(String.self, forKey: .projectId)
    }
}
