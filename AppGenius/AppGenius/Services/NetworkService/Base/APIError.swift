//
//  APIError.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import Foundation

enum APIError: Error {
    case data
    case unauthorized
    case notFound
    case server
    case network
    case numberNotActive
    case emailAndPassword
    case otpCode
    case fillTheField
    case biometricAuthFailed
    case fillAllRequiredFields
    case fillInNewEmail
    case custom(String)
    case privacyPolicyAndUserAgreement
    case pinCodesDoesntMatch
    case salariesSumNotLessThanSalaryCup
}

extension APIError: Equatable{}

