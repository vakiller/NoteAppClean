//
//  CoreDataError.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation

public enum CoreDataError: Error {
    case fetch
    case save
    
    public var errorDescription: String {
        switch self {
        case .fetch:
            return "Error get data from coredata"
        case .save:
            return "Error save data from coredata"
        }
    }
    
}
