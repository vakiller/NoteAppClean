//
//  NoteRepository.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

class NoteRepository: NoteRepositoryProtocol {
    
    private let noteDataSource: NoteDataSourceProtocol
    
    init(noteDataSource: NoteDataSourceProtocol) {
        self.noteDataSource = noteDataSource
    }
    
    func getListNotes(requestListNote: GetListNotesRequest) -> Observable<[NoteModel]> {
       return self.noteDataSource.getListNotes()
    }
    
    func getDetailNote(requestNote: GetNoteRequest) -> Observable<NoteModel> {
        return self.noteDataSource.getNoteDetail(idNote: requestNote.noteId ?? "")
    }
    
    func deleteNote(requestNote: GetNoteRequest) -> Completable {
        return self.noteDataSource.deleteNote(idNote: requestNote.noteId ?? "")
    }
    
    func editNote(requestNote: GetNoteRequest, note: NoteModel) -> Completable {
        return self.noteDataSource.createNote(noteModel: note)
    }
    
    func createNote(noteModel: NoteModel) -> Completable {
        return self.noteDataSource.createNote(noteModel: noteModel)
    }
}
