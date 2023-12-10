//
//  CreateNoteUseCases.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

final public class CreateNoteUseCase: CreateNoteUseCaseProtocol {
    
    private let noteRepository: NoteRepositoryProtocol
    
    public init(noteRepository: NoteRepositoryProtocol) {
        self.noteRepository = noteRepository
    }
    
    public func createNewTextNote(noteModel: NoteModel) -> Completable {
        return self.noteRepository.createNote(noteModel: noteModel)
    }
    
    public func createNewCheckListNote(noteModel: NoteModel) -> Completable {
        return self.noteRepository.createNote(noteModel: noteModel)
    }
    
    public func getDetailNote(noteRequest: GetNoteRequest) -> Observable<NoteModel> {
        return self.noteRepository.getDetailNote(requestNote: noteRequest)
    }
    
}
