//
//  ListNotesUseCaseMock.swift
//  NoteAppTests
//
//  Created by Le Mai Viet Anh on 12/18/23.
//

import Foundation
import RxSwift
@testable import NoteApp

final class ListNotesUseCaseMock: ListNoteUseCaseProtocol {
    
    let mockNoteRepository = MockNoteRepository()
    let requestNote = NoteApp.GetNoteRequest(noteId: "1")
    
    func getListNotes(requestModel: NoteApp.GetListNotesRequest) -> RxSwift.Observable<[NoteApp.NoteModel]> {
        return mockNoteRepository.getListNotes()
    }
    
    func deleteListNotes(request: NoteApp.GetNoteRequest) -> RxSwift.Completable {
        return mockNoteRepository.deleteNote(requestNote: requestNote)
    }
    
    
}
