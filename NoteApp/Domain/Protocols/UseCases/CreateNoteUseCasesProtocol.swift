//
//  NotesUseCasesProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

public protocol CreateNoteUseCasesProtocol {
    func createNewTextNote(noteModel: NoteModel) -> Observable<Bool>
    func createNewCheckListNote(noteModel: NoteModel) -> Observable<Bool>
}
