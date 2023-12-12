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

class ListNotesViewModel: ViewModelType {
    
    var disposeBag: DisposeBag
    var listNoteUseCase: ListNoteUseCaseProtocol?
    
    struct Input {
        let loadListNotes: PublishSubject<Void>
        let searchListNotes: BehaviorRelay<String?>
    }
    
    struct Output {
        var listNotes: RxRelay.BehaviorRelay<[NoteModel]?>
    }
    
    init(listNoteUseCase: ListNoteUseCaseProtocol) {
        self.listNoteUseCase = listNoteUseCase
        self.disposeBag = DisposeBag()
    }
    
    func transform(input: Input) -> Output {
        
        let listNotes: BehaviorRelay<[NoteModel]?> = BehaviorRelay<[NoteModel]?>(value: [])
        let output = Output(listNotes: listNotes)
        
        let requestListNote = GetListNotesRequest(searchText: nil, sortByDate: nil)
        
        let getListNoteWithAction = Observable.combineLatest(
            input.loadListNotes ,
            input.searchListNotes,
            self.listNoteUseCase?.getListNotes(requestModel: requestListNote) ?? Observable.just([]))
        
        getListNoteWithAction
            .subscribe(onNext: { _, searchText , listNoteData in
                output.listNotes.accept(listNoteData)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
}
