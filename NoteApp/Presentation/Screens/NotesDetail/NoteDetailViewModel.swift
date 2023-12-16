//
//  NoteDetailViewModel.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/13/23.
//

import Foundation
import RxSwift
import RxRelay

protocol InputNoteDetailViewModel {
    var getCurrentNote: PublishSubject<Void> { get set }
    var updateCurrentNote: PublishSubject<NoteModel?> { get set }
}

class NoteDetailViewModel: ViewModelType {
    var input: Input
    
    var output: Output
    
    var disposeBag: DisposeBag = DisposeBag()
    var detailNoteUseCase: DetailNoteUseCaseProtocol?
    var noteId: String?
    
    var getCurrentNote: PublishSubject<Void> = PublishSubject<Void>()
    var updateCurrentNote: PublishSubject<NoteModel?> = PublishSubject<NoteModel?>()
    
    struct Input: InputNoteDetailViewModel {
        var getCurrentNote: PublishSubject<Void>
        var updateCurrentNote: PublishSubject<NoteModel?>
    }
    
    let noteDetail: BehaviorRelay<NoteModel?> = BehaviorRelay<NoteModel?>(value: nil)
    let updateNoteCompleted: PublishSubject<NoteModel?> = PublishSubject<NoteModel?>()
    
    struct Output {
        var noteDetail: RxRelay.BehaviorRelay<NoteModel?>
        var updateNoteCompleted: PublishSubject<NoteModel?>
    }
    
    init(detailNoteUseCase: DetailNoteUseCaseProtocol) {
        self.detailNoteUseCase = detailNoteUseCase
        self.input = Input(getCurrentNote: getCurrentNote, updateCurrentNote: updateCurrentNote)
        self.output = Output(noteDetail: noteDetail, updateNoteCompleted: updateNoteCompleted)
        
        self.getNoteDetai()
        self.handleAddNewNote()
    }
    
    func getNoteDetai() {
        // get note detail data
        guard let noteId = noteId, noteId.isEmpty == false, let detailNoteUseCase else {
            return
        }
        let requestGetNote = GetNoteRequest(noteId: noteId)
        
        let getNoteFromCoreData = Observable.combineLatest(input.getCurrentNote,detailNoteUseCase.getDetailNote(request: requestGetNote))
        
        getNoteFromCoreData
        .subscribe(onNext: { [weak self] _, noteData in
            self?.output.noteDetail.accept(noteData)
        })
        .disposed(by: disposeBag)
        
    }
    
    func addNewNote(title: String?, content: String?) {
        let newNoteModel = noteModelGenerate(id: nil, createAt: nil, title: title, content: content)
        input.updateCurrentNote.onNext(newNoteModel)
    }
    
    func handleAddNewNote() {
        
        input.updateCurrentNote.subscribe(onNext: { [weak self] newNoteModel in
            
            guard let self = self else {
                return
            }
            
            guard let newNoteModel else {
                return
            }
            
            if newNoteModel.id == nil {
                self.detailNoteUseCase?.createNote(request: newNoteModel).bind(to: self.output.updateNoteCompleted)
                    .disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
    }
    
    public func noteModelGenerate(id: String?, createAt: Date? ,  title: String?, content: String?) -> NoteModel {
        return NoteModel(id: id,
                         createAt: createAt != nil ? createAt : Date.now,
                         lastUpdate: Date.now,
                         title: title,
                         content: content,
                         checkList: [])
    }
    
    private func onCreateNewNote(model: NoteModel?) {
        
        
    }
    
    
}
