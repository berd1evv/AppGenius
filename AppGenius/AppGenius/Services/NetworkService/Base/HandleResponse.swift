//
//  HandleResponse.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import Foundation
import Moya

protocol HandleResponseProtocol{
    func handleResponse<T: Decodable>(result: Result<Response, MoyaError>, onSuccess: @escaping (T) -> Void, onError: @escaping (APIError) -> Void)
}

class HandleResponse: HandleResponseProtocol{
    func handleResponse<T: Decodable>(result: Result<Response, MoyaError>, onSuccess: @escaping (T) -> Void, onError: @escaping (APIError) -> Void) {
        switch result {
        case let .success(response):
            do {
                
                handleStatusCode(statusCode: response.statusCode) {(error) in
                    onError(error)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let decoded = try response.map(T.self, atKeyPath: nil, using: decoder, failsOnEmptyData: false)
                onSuccess(decoded)
            } catch {
                onError(.data)
            }
        case let .failure(error):
            switch error {
            case let .statusCode(response):
                handleStatusCode(statusCode: response.statusCode, onError: onError)
            default: onError(.network)
            }
        }
    }
    
    func handleStatusCode(statusCode: Int, onError: @escaping (APIError) -> Void) {
        switch statusCode {
        case 200..<300: break
        case 405: onError(.custom("The same data"))
        case 404: onError(.notFound)
        case 500..<600: onError(.server)
        case 401:onError(.unauthorized)
        default: onError(.network)
        }
    }
}

extension DateFormatter{
    static var currentddMMyyyy: DateFormatter{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }
    
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
    
    static let notificationDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
    
    static let notificationTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        //            .init(abbreviation: "GMT+0:00")
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
    
    static let queryDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
}
