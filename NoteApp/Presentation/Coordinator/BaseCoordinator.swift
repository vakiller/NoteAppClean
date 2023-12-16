//
//  BaseCoordinator.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/11/23.
//

import Foundation
import UIKit

public class BaseCoordinator: NSObject {
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
    
    public func checkViewControllerDeinit(viewController: UIViewController) {
        
    }
    
}

extension BaseCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(viewController) else {
                    return
                }
        self.checkViewControllerDeinit(viewController: viewController)
    }
}
