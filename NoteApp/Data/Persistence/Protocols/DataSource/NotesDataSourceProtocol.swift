//
//  NotesDataSourceProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import CoreData
import RxSwift

public protocol NoteDataSourceProtocol {
    func getListNotes() -> Observable<[NoteModel]>
    func getNoteDetail(idNote: String) -> Observable<NoteModel>
    func createNote(noteModel: NoteModel) -> Completable
    func updateNote(idNote: String, noteModel: NoteModel) -> Completable
    func deleteNote(idNote: String) -> Completable
}

