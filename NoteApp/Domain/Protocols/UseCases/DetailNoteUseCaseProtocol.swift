//
//  DetailNoteUseCaseProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

public protocol DetailNoteUseCaseProtocol {
    func getDetailNote(request: GetNoteRequest) -> Observable<NoteModel>
    func editNote(request: GetNoteRequest, note: NoteModel) -> Completable
    func editNote(request: GetNoteRequest, note: NoteModel) -> Observable<NoteModel>
    func createNote(request: NoteModel) -> Observable<NoteModel>
}
