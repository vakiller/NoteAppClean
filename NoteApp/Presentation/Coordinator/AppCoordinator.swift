//
//  AppCoordinator.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/11/23.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    let viewController: ListNotesViewController
    
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        let listNotesViewModel = ListNotesViewModel(listNoteUseCase: DiResolver.shared.resolve(ListNoteUseCaseProtocol.self))
        viewController = ListNotesViewController(viewModel: listNotesViewModel)
        rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    override func start() {
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    
    
}
