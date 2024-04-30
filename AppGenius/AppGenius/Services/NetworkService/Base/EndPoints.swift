//
//  EndPoints.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import Foundation

class EndPoints{
    static let shared = EndPoints()
    
    var baseURL: String{
        "https://api.todoist.com/rest/v2/"
    }
    
    var authURL: String{
        "https://todoist.com/"
    }
}
