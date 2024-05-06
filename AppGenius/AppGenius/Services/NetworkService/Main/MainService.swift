//
//  InboxService.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import Foundation
import UIKit
import Moya
import Alamofire

enum MainService{
    case getProjects
    case getSections(projectId: String)
    case getTasks(projectId: String?, sectionId: String?, filter: String?)
    case createTask(content: String, description: String?, projectId: String?)
}

extension MainService: TargetType{
    var baseURL: URL {
        return URL(string: EndPoints.shared.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getProjects: return "projects"
        case .getSections: return "sections"
        case .getTasks: return "tasks"
        case .createTask: return "tasks"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getProjects, .getSections, .getTasks: return .get
        case .createTask: return .post
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Moya.Task {
        switch self{
        case .getTasks(let projectId, let sectionId, let filter):
            var params = [String:Any]()
            if let projectId = projectId {
                params["project_id"] = projectId
            }
            if let sectionId = sectionId {
                params["section_id"] = sectionId
            }
            if let filter = filter {
                params["filter"] = filter
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getSections(let projectId):
            let params = ["project_id" : projectId]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .createTask(let content, let description, let projectId):
            var params: [String:Any] = [
                "content" : content
            ]
            if let description = description {
                params["description"] = description
            }
            if let projectId = projectId {
                params["project_id"] = projectId
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            if let token = Storage.shared.getUserToken(){
                return ["Authorization": "Bearer \(token)"]
            } else {
                return ["Content-type": "application/json"]
            }
        }
    }
}
