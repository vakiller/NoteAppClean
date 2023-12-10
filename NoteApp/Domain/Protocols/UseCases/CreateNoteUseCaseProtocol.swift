//
//  NotesUseCasesProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

public protocol CreateNoteUseCaseProtocol {
    func createNewTextNote(noteModel: NoteModel) -> Completable
    func createNewCheckListNote(noteModel: NoteModel) -> Completable
    func getDetailNote(noteRequest: GetNoteRequest) -> Observable<NoteModel>
}
