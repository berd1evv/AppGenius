//
//  Storage.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import SwiftUI

struct UserDefaultsStorage{
    static let currentCity = "currentCity"
    static let userToken = "userToken"
    static let expiryDate = "expiryDate"
    static let refreshToken = "refreshToken"
    static let userID = "userID"
    static let active = "active"
    static let isAlreadyLeft = "isAlreadyLeft"
    static let registrationId = "registrationId"
}

protocol StorageProtocol{
    func getUserToken() -> String?
    func setUserToken(_ token: String)
    func deleteUserToken()
    
    func getUserID() -> Int?
    func setUserID(_ id: Int)
    func deleteUserID()
    func deleteEverything()
    
    func setActive(_ active: Bool)
    func getActive() -> Bool
    
    func setIsAlreadyLeft(_ active: Bool)
    func getIsAlreadyLeft() -> Bool
}

class Storage: StorageProtocol{
    static let shared = Storage()
    
    @AppStorage(UserDefaultsStorage.userToken) private var userToken = ""
    @AppStorage(UserDefaultsStorage.userID) private var userID = 0
    @AppStorage(UserDefaultsStorage.active) private var active = false
    @AppStorage(UserDefaultsStorage.isAlreadyLeft) private var isAlreadyLeft = false
    @AppStorage(UserDefaultsStorage.registrationId) private var registrationId = ""
    
    func getUserToken() -> String?{
        if !userToken.isEmpty{
            return userToken
        }
        return nil
    }
    
    func setUserToken(_ token: String){
        self.userToken = token
    }
    
    func setRegistrationId(_ token: String) {
        self.registrationId = token
    }
    
    func getRegistrationId() -> String {
        return registrationId
    }
    
    func deleteUserToken(){
        self.userToken = ""
    }
    
    func getUserID() -> Int?{
        if userID != 0{
            return userID
        }
        return nil
    }
    
    func setUserID(_ id: Int){
        self.userID = id
    }
    
    func deleteUserID(){
        self.userID = 0
    }
    
    func deleteEverything(){
        deleteUserID()
        deleteUserToken()
    }
    
    func setActive(_ active: Bool){
        self.active = active
    }
    
    func getActive() -> Bool{
        return active
    }
    
    func setIsAlreadyLeft(_ isAlreadyLeft: Bool){
        self.isAlreadyLeft = isAlreadyLeft
    }
    
    func getIsAlreadyLeft() -> Bool{
        return self.isAlreadyLeft
    }
}
