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
    case getTasks(projectId: String?, sectionId: String?)
}

extension MainService: TargetType{
    var baseURL: URL {
        return URL(string: EndPoints.shared.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getProjects: return "projects"
        case .getTasks: return "tasks"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getProjects, .getTasks: return .get
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Moya.Task {
        switch self{
        case .getTasks(let projectId, let sectionId):
            var params = [String:Any]()
            if let projectId = projectId {
                params["project_id"] = projectId
            }
            if let sectionId = sectionId {
                params["section_id"] = sectionId
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
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
