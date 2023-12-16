//
//  NoteDetailCoordinator.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/13/23.
//

import Foundation
import UIKit

protocol NoteDetailCoordinatorDelegate {
    func onDismissWithData(note: NoteModel?)
    func dealocateCoordinator(coordinator: NoteDetailCoordinator)
}

class NoteDetailCoordinator: BaseCoordinator {
    
    lazy var noteDetailViewModel: NoteDetailViewModel = {
        return NoteDetailViewModel(detailNoteUseCase: DiResolver.shared.resolve(DetailNoteUseCaseProtocol.self))
    }()
    
    var delegate: NoteDetailCoordinatorDelegate?
    
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    override func start() {
        self.rootViewController.delegate = self
        let noteDetailViewController: NoteDetailController = NoteDetailController(viewModel: noteDetailViewModel)
        noteDetailViewController.updateNoteCompleted
            .withUnretained(self)
            .subscribe { owner, noteData in
                owner.delegate?.onDismissWithData(note: noteData)
                owner.rootViewController.popViewController(animated: true)
            }
            .disposed(by: noteDetailViewModel.disposeBag)
        
        self.rootViewController.pushViewController(noteDetailViewController, animated: true)
    }
    
    override func finish() {
        
    }
    
    override func checkViewControllerDeinit(viewController: UIViewController) {
        if viewController is NoteDetailController {
            self.delegate?.dealocateCoordinator(coordinator: self)
        }
    }
    
}
