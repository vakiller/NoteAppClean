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
    var sortByDate: BehaviorRelay<SortValue> { get set }
    var searchListNotes: BehaviorRelay<String?> { get set }
}

final class ListNotesViewModel: ViewModelType {
    
    var input: Input
    var output: Output
    
    var disposeBag: DisposeBag
    
    var searchListNotes: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var sortByDate: BehaviorRelay<SortValue> = BehaviorRelay<SortValue>(value: .des)
    var loadMore: PublishSubject<Void> = PublishSubject<Void>()
    var deleteNoteSuccess: PublishSubject<NoteModel> = PublishSubject<NoteModel>()
    
    struct Input: ListNotesViewModelInput {
        var sortByDate: BehaviorRelay<SortValue>
        var searchListNotes: BehaviorRelay<String?>
        var loadMore: PublishSubject<Void>
    }
    
    var listNotes: RxRelay.BehaviorRelay<[NoteModel]?> = BehaviorRelay<[NoteModel]?>(value: [])
    var isHasLoadMore: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    
    struct Output {
        var listNotes: RxRelay.BehaviorRelay<[NoteModel]?>
        var isHasLoadMore: BehaviorRelay<Bool>
        var deleteNoteSuccess: PublishSubject<NoteModel>
    }
    
    var listNoteUseCase: ListNoteUseCaseProtocol?
    var getListNotesRequest = GetListNotesRequest(searchText: nil, sortByDate: .des, fromDate: nil, limit: 10)
    
    init(listNoteUseCase: ListNoteUseCaseProtocol) {
        self.listNoteUseCase = listNoteUseCase
        self.disposeBag = DisposeBag()
        
        self.input = Input(sortByDate: sortByDate, searchListNotes: searchListNotes, loadMore: loadMore)
        self.output = Output(listNotes: listNotes, isHasLoadMore: isHasLoadMore, deleteNoteSuccess: deleteNoteSuccess)
        
        self.getListNotesActions()
    }
    
    func getListNotesActions() {
        
        guard listNoteUseCase != nil else {
            return
        }
        let getListNoteWithFilters = Observable.combineLatest(
            input.sortByDate,
            input.searchListNotes.skip(1))
        
        getListNoteWithFilters
            .subscribe( onNext: { [weak self] sortByDate, searchText in
                self?.output.isHasLoadMore.accept(true)
                self?.getListNotesRequest.fromDate = nil
                self?.getListNotesRequest.searchText = searchText
                self?.getListNotesRequest.sortByDate = sortByDate
                self?.startRequestGetListNotes()
            })
            .disposed(by: disposeBag)
        
        input.loadMore
            .subscribe(onNext: { [weak self] in
                self?.getListNotesRequest.fromDate = self?.output.listNotes.value?.last?.createAt
                self?.startRequestGetListNotes()
            })
            .disposed(by: disposeBag)
    }
    
    func startRequestGetListNotes() {
        listNoteUseCase?.getListNotes(requestModel: getListNotesRequest)
            .subscribe(onNext: {[weak self] listNoteFromCoreData in
                
                if listNoteFromCoreData.count < (self?.getListNotesRequest.limit ?? 0) {
                    self?.output.isHasLoadMore.accept(false)
                }
                
                if self?.getListNotesRequest.fromDate != nil {
                    var listNotesNow: [NoteModel] = self?.output.listNotes.value ?? []
                    listNotesNow.append(contentsOf: listNoteFromCoreData)
                    self?.output.listNotes.accept(listNotesNow)
                } else {
                    self?.output.listNotes.accept(listNoteFromCoreData)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func onReceiveNewNote(noteModel: NoteModel?) {
        
        guard let noteModel else {
            return
        }
        if checkNoteIsExist(noteId: noteModel.id ?? "") {
            editNoteInListNote(noteModel: noteModel)
        } else {
            self.addNewNoteToListNote(noteModel: noteModel)
        }
    }
    
    private func addNewNoteToListNote(noteModel: NoteModel) {
        var listNoteNow = self.output.listNotes.value
        if getListNotesRequest.sortByDate == .des {
            listNoteNow?.insert(noteModel, at: 0)
        } else {
            self.output.isHasLoadMore.accept(true)
        }
        self.output.listNotes.accept(listNoteNow)
    }
    
    private func editNoteInListNote(noteModel: NoteModel?) {
        
        guard let noteModel else {
            return
        }
        
        var listNoteNow = self.output.listNotes.value
        if let indexNoteInList = listNoteNow?.firstIndex(where: { $0.id == noteModel.id }) {
            listNoteNow?[indexNoteInList] = noteModel
            self.output.listNotes.accept(listNoteNow)
        }
    }
    
    func deleteNoteInListNote(noteModel: NoteModel?) {
        guard let noteModel else {
            return
        }
        
        let noteRequest = GetNoteRequest(noteId: noteModel.id ?? "")
        self.listNoteUseCase?.deleteListNotes(request: noteRequest)
            .subscribe(onCompleted: { [weak self] in
                
                guard let self else {
                    return
                }
                
                var listNoteNow = self.output.listNotes.value
                if let indexNoteInList = listNoteNow?.firstIndex(where: { $0.id == noteModel.id }) {
                    listNoteNow?.remove(at: indexNoteInList)
                    self.output.listNotes.accept(listNoteNow)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func checkNoteIsExist(noteId: String) -> Bool {
        guard (self.output.listNotes.value?.firstIndex(where: { $0.id == noteId })) != nil else {
            return false
        }
        
        return true
    }
    
}
