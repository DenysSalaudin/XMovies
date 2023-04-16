//
//  Errors.swift
//  XMoviesProject
//
//  Created by Denis on 4/3/23.
//

import Foundation

enum MovieError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
    case unownedUrl
   
}

extension MovieError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a movie missing a valid code.", comment: "")
        case .networkError:
            return NSLocalizedString("Error fetching Movie data over the network.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        case .unownedUrl:
            return NSLocalizedString("Cannot find url",comment: "")
        }
    }
}
