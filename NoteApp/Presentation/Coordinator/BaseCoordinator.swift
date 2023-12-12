//
//  BaseCoordinator.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/11/23.
//

import Foundation


public class BaseCoordinator {
    private var childCoordinators: [BaseCoordinator] = []
    
    public func start() {
        
    }
    
    public func finish() {
        
    }
    
    public func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
        NSLog("Coordinator: Added Child Coordinator \(coordinator.self)")
    }
    
    public func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
            NSLog("Coordinator: Removed Child Coordinator \(coordinator.self)")
        }
    }
    
}

extension BaseCoordinator: Equatable {
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
