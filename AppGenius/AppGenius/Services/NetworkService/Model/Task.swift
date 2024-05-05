//
//  Task.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import Foundation

struct Task: Codable, Identifiable, Hashable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
    
    let taskID = UUID()
    let id: String
    let content: String
    let description: String
    let order: Int
    let priority: Int
    var isCompleted: Bool
    let sectionId: String?
    let parentId: String?
    let due: Due?
    
    
    enum CodingKeys: String, CodingKey{
        case id
        case content, description, order, priority
        case isCompleted = "is_completed"
        case sectionId = "section_id"
        case parentId = "parent_id"
        case due
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
        due = try values.decodeIfPresent(Due.self, forKey: .due)
    }
    
    init() {
        id = ""
        content = ""
        description = ""
        order = 1
        priority = 1
        isCompleted = false
        sectionId = nil
        parentId = nil
        due = nil
    }
}

struct Due: Codable, Hashable{
    let date: Date
    let string: String
    let lang: String
    var isRecurring: Bool
    
    
    enum CodingKeys: String, CodingKey{
        case date, string, lang
        case isRecurring = "is_recurring"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(Date.self, forKey: .date)
        string = try values.decode(String.self, forKey: .string)
        lang = try values.decode(String.self, forKey: .lang)
        isRecurring = try values.decode(Bool.self, forKey: .isRecurring)
    }
}
