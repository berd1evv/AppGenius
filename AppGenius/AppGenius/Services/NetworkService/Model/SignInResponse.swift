//
//  SignInResponse.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import Foundation

struct SignInResponse: Codable{
    var accessToken: String
    var tokenType: String
    
    enum CodingKeys: String, CodingKey{
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        tokenType = try values.decode(String.self, forKey: .tokenType)
    }
}
