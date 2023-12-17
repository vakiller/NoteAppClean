//
//  DetailNoteUseCase.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/14/23.
//

import Foundation
import RxSwift

class DetailNoteUseCase: DetailNoteUseCaseProtocol {
    
    private let noteRepository: NoteRepositoryProtocol
    
    func getDetailNote(request: GetNoteRequest) -> RxSwift.Observable<NoteModel> {
        return self.noteRepository.getDetailNote(requestNote: request)
    }
    
    public init(noteRepository: NoteRepositoryProtocol) {
        self.noteRepository = noteRepository
    }
    
    func editNote(request: GetNoteRequest, note: NoteModel) -> Completable {
        return self.noteRepository.editNote(requestNote: request, note: note)
    }
    
    func editNote(request: GetNoteRequest, note: NoteModel) -> Observable<NoteModel> {
        return self.noteRepository.editNote(requestNote: request, note: note)
    }
    
    func createNote(request: NoteModel) -> Observable<NoteModel> {
        return self.noteRepository.createNoteReturnValue(noteModel: request)
        
    }
    
}
