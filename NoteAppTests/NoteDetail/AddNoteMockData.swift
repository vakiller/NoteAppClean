//
//  AddNoteMockData.swift
//  NoteAppTests
//
//  Created by Le Mai Viet Anh on 12/18/23.
//

import Foundation
import RxSwift
@testable import NoteApp

final class AddNoteMockData {
    let detailNoteUseCase: DetailNoteUseCaseProtocol?
    let disposeBag = DisposeBag()
    
    let listNotes: [NoteApp.NoteModel] = [
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "1", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "2", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "3", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "4", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "5", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "6", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "7", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "8", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "9", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "10", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "11", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "12", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "13", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "14", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "15", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "1", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "2", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "3", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "4", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "5", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "6", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "7", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "8", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "9", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "10", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "11", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "12", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "13", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "14", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "15", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "1", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "2", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "3", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "4", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "5", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "6", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "7", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "8", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "9", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "10", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "11", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "12", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "13", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "14", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "15", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "1", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "2", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "3", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "4", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "5", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "6", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "7", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "8", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "9", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "10", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "11", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "12", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "13", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "14", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "15", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "1", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "2", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "3", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "4", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "5", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "6", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "7", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "8", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "9", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "10", content: "5", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "11", content: "1", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "12", content: "2", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "13", content: "3", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "14", content: "4", checkList: []),
        NoteModel(id: nil, createAt: Date.now, lastUpdate: Date.now, title: "15", content: "5", checkList: []),
    ]
    
    init(detailNoteUseCase: DetailNoteUseCaseProtocol?) {
        self.detailNoteUseCase = DetailNoteUseCase(noteRepository: DiResolver.shared.resolve(NoteRepositoryProtocol.self))
    }
    
    func addListNoteTest() {
        for note in listNotes {
            do {
                let uuid = UUID().uuidString
                let newNote = NoteEntity(context: CoreDataHelper.shared.getContext())
                newNote.id = uuid
                newNote.content = note.content
                newNote.lastUpdate = note.lastUpdate
                newNote.checkList = NSOrderedSet(array: note.checkList ?? [])
                newNote.title = note.title
                newNote.createAt = note.createAt
                
                try CoreDataHelper.shared.saveContext(entity: newNote)
                print("Added Note \(note.id ?? "")")
            } catch {
                print("Error Add")
            }
            
        }
    }
}
