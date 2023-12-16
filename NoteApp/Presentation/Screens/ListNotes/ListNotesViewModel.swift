//
//  ListNotesViewModel.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import RxSwift
import RxRelay
import RxSwiftExt

protocol ListNotesViewModelInput {
    var loadListNotes: PublishSubject<Void> { get set }
    var searchListNotes: BehaviorRelay<String?> { get set }
}

class ListNotesViewModel: ViewModelType {
    
    var input: Input
    var output: Output
    
    
    var disposeBag: DisposeBag
    var listNoteUseCase: ListNoteUseCaseProtocol?
    
    struct Input: ListNotesViewModelInput {
        var loadListNotes: PublishSubject<Void>
        var searchListNotes: BehaviorRelay<String?>
    }
    
    struct Output {
        var listNotes: RxRelay.BehaviorRelay<[NoteModel]?>
    }
    
    var loadListNotes: PublishSubject<Void> = PublishSubject<Void>()
    var searchListNotes: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var listNotes: RxRelay.BehaviorRelay<[NoteModel]?> = BehaviorRelay<[NoteModel]?>(value: [])
    
    init(listNoteUseCase: ListNoteUseCaseProtocol) {
        self.listNoteUseCase = listNoteUseCase
        self.disposeBag = DisposeBag()
        
        self.input = Input(loadListNotes: loadListNotes, searchListNotes: searchListNotes)
        self.output = Output(listNotes: listNotes)
        
        self.getListNotes()
    }
    
    func getListNotes() {
        
        guard let listNoteUseCase else {
            return
        }
        let requestListNote = GetListNotesRequest(searchText: nil, sortByDate: nil)
        let getListNoteWithAction = Observable.combineLatest(
            input.loadListNotes ,
            input.searchListNotes,
            listNoteUseCase.getListNotes(requestModel: requestListNote))
        
        getListNoteWithAction
            .subscribe(onNext: {[weak self]  _, searchText , listNoteData in
                self?.output.listNotes.accept(listNoteData)
            })
            .disposed(by: disposeBag)
    }
    
    func onReceiveNewNote(noteModel: NoteModel?) {
        
        guard let noteModel else {
            return
        }
        
        var listNoteNow = self.output.listNotes.value
        listNoteNow?.insert(noteModel, at: 0)
        self.output.listNotes.accept(listNoteNow)
    }
    
}
