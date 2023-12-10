//
//  ListNoteUseCasesProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import RxSwift

public protocol ListNoteUseCasesProtocol {
    func getListNotes(requestModel: GetListNotesRequest) -> Observable<[NoteModel]>
    func deleteListNotes(request: GetNoteRequest) -> Observable<Bool>
}
