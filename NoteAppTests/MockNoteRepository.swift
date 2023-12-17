//
//  MockNoteRepository.swift
//  NoteAppTests
//
//  Created by Le Mai Viet Anh on 12/18/23.
//

@testable import NoteApp
import Foundation
import RxSwift

final class MockNoteRepository: NoteRepositoryProtocol
{
    
    let listNotes: [NoteApp.NoteModel] = [
        NoteModel(id: "1", createAt: Date.now, lastUpdate: Date.now, title: "1", content: "1", checkList: []),
        NoteModel(id: "2", createAt: Date.now, lastUpdate: Date.now, title: "2", content: "2", checkList: []),
        NoteModel(id: "3", createAt: Date.now, lastUpdate: Date.now, title: "3", content: "3", checkList: []),
        NoteModel(id: "4", createAt: Date.now, lastUpdate: Date.now, title: "4", content: "4", checkList: []),
        NoteModel(id: "5", createAt: Date.now, lastUpdate: Date.now, title: "5", content: "5", checkList: []),
    ]
    
    func getListNotes() -> RxSwift.Observable<[NoteApp.NoteModel]> {
        return Observable<[NoteModel]>.just(listNotes)
    }
    
    func getListNotes(requestListNote: NoteApp.GetListNotesRequest) -> RxSwift.Observable<[NoteApp.NoteModel]> {
        return Observable<[NoteModel]>.just(listNotes)
    }
    
    func getDetailNote(requestNote: NoteApp.GetNoteRequest) -> RxSwift.Observable<NoteApp.NoteModel> {
        return Observable<NoteModel>.just(listNotes.first!)
    }
    
    func deleteNote(requestNote: NoteApp.GetNoteRequest) -> RxSwift.Completable {
        return Completable.error(CoreDataError.save)
    }
    
    func editNote(requestNote: NoteApp.GetNoteRequest, note: NoteApp.NoteModel) -> RxSwift.Completable {
        return Completable.never()
    }
    
    func editNote(requestNote: NoteApp.GetNoteRequest, note: NoteApp.NoteModel) -> RxSwift.Observable<NoteApp.NoteModel> {
        return Observable<NoteModel>.just(listNotes.first!)
    }
    
    func createNote(noteModel: NoteApp.NoteModel) -> RxSwift.Completable {
        return Completable.never()
    }
    
    func createNoteReturnValue(noteModel: NoteApp.NoteModel) -> RxSwift.Observable<NoteApp.NoteModel> {
        return Observable<NoteModel>.just(listNotes.first!)
    }
    
    
}

