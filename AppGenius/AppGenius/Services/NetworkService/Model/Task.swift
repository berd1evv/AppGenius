//
//  Task.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import Foundation

struct Task: Codable, Identifiable{
    let taskID = UUID()
    let id: String
    let content: String
    let description: String
    let order: Int
    let priority: Int
    let isCompleted: Bool
    let sectionId: String?
    let parentId: String?
    
    
    enum CodingKeys: String, CodingKey{
        case id
        case content, description, order, priority
        case isCompleted = "is_completed"
        case sectionId = "section_id"
        case parentId = "parent_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        content = try values.decode(String.self, forKey: .content)
        description = try values.decode(String.self, forKey: .description)
        order = try values.decode(Int.self, forKey: .order)
        priority = try values.decode(Int.self, forKey: .priority)
        isCompleted = try values.decode(Bool.self, forKey: .isCompleted)
        sectionId = try values.decodeIfPresent(String.self, forKey: .sectionId)
        parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
    }
}
