//
//  ListNoteUseCase.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import RxSwift

final class ListNoteUseCase: ListNoteUseCaseProtocol {
    
    private let noteRepository: NoteRepositoryProtocol
    
    public init(noteRepository: NoteRepositoryProtocol) {
        self.noteRepository = noteRepository
    }
    
    func getListNotes(requestModel: GetListNotesRequest) -> RxSwift.Observable<[NoteModel]> {
        return self.noteRepository.getListNotes(requestListNote: requestModel)
    }
    
    func deleteListNotes(request: GetNoteRequest) -> RxSwift.Completable {
        return self.noteRepository.deleteNote(requestNote: request)
    }
    
}
