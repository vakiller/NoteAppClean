//
//  NoteRepositoryProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

public protocol NoteRepositoryProtocol {
    func getListNotes(requestListNote: GetListNotesRequest) -> Observable<[NoteModel]>
    func getDetailNote(requestNote: GetNoteRequest) -> Observable<NoteModel>
    func deleteNote(requestNote: GetNoteRequest) -> Completable
    func editNote(requestNote: GetNoteRequest, note: NoteModel) -> Completable
    func createNote(noteModel: NoteModel) -> Completable
}
