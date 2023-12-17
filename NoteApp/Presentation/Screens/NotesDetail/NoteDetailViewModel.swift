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
    var updateCurrentNote: PublishSubject<NoteModel?> { get set }
}

class NoteDetailViewModel: ViewModelType {
    var input: Input
    
    var output: Output
    
    var disposeBag: DisposeBag = DisposeBag()
    var detailNoteUseCase: DetailNoteUseCaseProtocol?
    var noteId: String?
    
    var updateCurrentNote: PublishSubject<NoteModel?> = PublishSubject<NoteModel?>()
    
    struct Input: InputNoteDetailViewModel {
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
        self.input = Input(updateCurrentNote: updateCurrentNote)
        self.output = Output(noteDetail: noteDetail, updateNoteCompleted: updateNoteCompleted)
        self.handleAddOrEditNote()
    }
    
    func getNoteDetai() {
        // get note detail data
        guard let noteId = noteId, noteId.isEmpty == false, let detailNoteUseCase else {
            return
        }
        let requestGetNote = GetNoteRequest(noteId: noteId)
        detailNoteUseCase.getDetailNote(request: requestGetNote)
        .subscribe(onNext: { [weak self] noteData in
            self?.output.noteDetail.accept(noteData)
        })
        .disposed(by: disposeBag)
        
    }
    
    func addOrUpdateNote(title: String?, content: String?) {
        
        let noteDetail = self.output.noteDetail.value
        
        let newNoteModel = noteModelGenerate(id: noteDetail?.id, createAt: noteDetail?.createAt, title: title, content: content)
        input.updateCurrentNote.onNext(newNoteModel)
    }
    
    func handleAddOrEditNote() {
        
        input.updateCurrentNote.subscribe(onNext: { [weak self] noteModel in
            
            guard let self = self else {
                return
            }
            
            guard let noteModel else {
                return
            }
            
            if noteModel.id == nil {
                // create new
                self.detailNoteUseCase?.createNote(request: noteModel).bind(to: self.output.updateNoteCompleted)
                    .disposed(by: self.disposeBag)
            } else {
                // update
                let requestGetNote = GetNoteRequest(noteId: noteModel.id)
                self.detailNoteUseCase?.editNote(request: requestGetNote, note: noteModel).bind(to: self.output.updateNoteCompleted)
                    .disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
    }
    
    public func noteModelGenerate(id: String?, createAt: Date?, title: String?, content: String?) -> NoteModel {
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
