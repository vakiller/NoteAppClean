//
//  AppCoordinator.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/11/23.
//

import Foundation
import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    let disposeBag = DisposeBag()
    
    lazy var rootViewController: UINavigationController = {
       return UINavigationController(rootViewController: UIViewController())
    }()
    
    lazy var listNotesViewModel: ListNotesViewModel = {
        ListNotesViewModel(listNoteUseCase: DiResolver.shared.resolve(ListNoteUseCaseProtocol.self))
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let viewController: ListNotesViewController = ListNotesViewController(viewModel: listNotesViewModel)
        rootViewController.setViewControllers([viewController], animated: false)
        viewController.goToNoteDetail
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.goToDetailNote()
            })
            .disposed(by: listNotesViewModel.disposeBag)
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    private func goToDetailNote() {
        let detailNoteCoordinator = NoteDetailCoordinator(rootViewController: self.rootViewController)
        detailNoteCoordinator.start()
        self.addChildCoordinator(detailNoteCoordinator)
        detailNoteCoordinator.delegate = self
    }
}

extension AppCoordinator: NoteDetailCoordinatorDelegate {
    func dealocateCoordinator(coordinator: NoteDetailCoordinator) {
        self.removeChildCoordinator(coordinator)
    }
    
    func onDismissWithData(note: NoteModel?) {
        listNotesViewModel.onReceiveNewNote(noteModel: note)
    }
    
}
