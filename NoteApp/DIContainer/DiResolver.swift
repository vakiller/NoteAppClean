//
//  DiResolver.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation

class DiResolver {
    static let shared = DiResolver()
    
    private var diContainer = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        diContainer.resolve(T.self)!
    }
    
}
