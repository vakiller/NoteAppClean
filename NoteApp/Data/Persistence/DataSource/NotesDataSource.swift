//
//  NotesDataSource.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import CoreData
import RxSwift

public class NoteDataSource: NoteDataSourceProtocol {
    
    private let coreDataHelper: CoreDataHelperProtocol
    
    private let noteEntityName: String = "NoteEntity"
    
    public init(coreDataHelper: CoreDataHelperProtocol) {
        self.coreDataHelper = coreDataHelper
    }
    
    private func mapToNoteModel(noteEntity: NoteEntity) -> NoteModel? {
        
        let checkItemsEntity = noteEntity.checkList?.array as? [CheckItemEntity]
        let checkListItems = checkItemsEntity?.map({ CheckListItem(id: $0.id, title: $0.title, isCheck: $0.isCheck) })
        let noteModel = NoteModel(id: noteEntity.id,createAt: noteEntity.createAt, lastUpdate: noteEntity.lastUpdate, title: noteEntity.title, content: noteEntity.content, checkList: checkListItems)
        return noteModel
        
    }
    
    public func getListNotes() -> Observable<[NoteModel]> {
        return Observable<[NoteModel]>.create { [weak self] observer in
            
            guard let self = self else {
                return Disposables.create()
            }
            
            do {
                if let listNotesEntity = try self.coreDataHelper.getListData(entityName: self.noteEntityName) as? [NoteEntity] {
                    let listNotesModel = listNotesEntity.compactMap({ self.mapToNoteModel(noteEntity: $0)})
                    observer.onNext(listNotesModel)
                    observer.onCompleted()
                } else {
                    observer.onError(CoreDataError.fetch)
                }
                
                
            } catch {
                observer.onError(CoreDataError.fetch)
            }
            return Disposables.create()
        }
    }
    
    public func getNoteDetail(idNote: String) -> RxSwift.Observable<NoteModel> {
        return Observable<NoteModel>.create { [weak self] observer in
            
            guard let self = self else {
                return Disposables.create()
            }
            
            do {
                let predicate = NSPredicate(format: "id = %@", idNote)
                if let noteEntityData = try self.coreDataHelper.getListData(entityName: self.noteEntityName, predicate: predicate, limit: 1).first as? NoteEntity,
                let noteData = mapToNoteModel(noteEntity: noteEntityData) {
                    observer.onNext(noteData)
                } else {
                    observer.onError(CoreDataError.fetch)
                }
                
            } catch {
                observer.onError(CoreDataError.fetch)
            }
            
            return Disposables.create()
        }
    }
    
    public func createNote(noteModel: NoteModel) -> Completable {
        return Completable.create { completable in
            do {
                let uuid = UUID().uuidString
                let newNote = NoteEntity(context: self.coreDataHelper.getContext())
                newNote.id = uuid
                newNote.content = noteModel.content
                newNote.lastUpdate = noteModel.lastUpdate
                newNote.checkList = NSOrderedSet(array: noteModel.checkList ?? [])
                newNote.title = noteModel.title
                newNote.createAt = noteModel.createAt
                
                try self.coreDataHelper.saveContext(entity: newNote)
                completable(.completed)
                
            } catch {
                completable(.error(CoreDataError.save))
            }
            
            return Disposables.create()
        }
    }
    
    public func createNote(noteModel: NoteModel) -> RxSwift.Observable<NoteModel> {
        return Observable<NoteModel>.create { [weak self] observer in
            
            guard let self = self else {
                return Disposables.create()
            }
            
            do {
                let uuid = UUID().uuidString
                let newNote = NoteEntity(context: self.coreDataHelper.getContext())
                newNote.id = uuid
                newNote.content = noteModel.content
                newNote.lastUpdate = noteModel.lastUpdate
                newNote.checkList = NSOrderedSet(array: noteModel.checkList ?? [])
                newNote.title = noteModel.title
                newNote.createAt = noteModel.createAt
                
                try self.coreDataHelper.saveContext(entity: newNote)
                
                let predicate = NSPredicate(format: "id = %@", uuid)
                if let noteEntityData = try self.coreDataHelper.getListData(entityName: self.noteEntityName, predicate: predicate, limit: 1).first as? NoteEntity,
                    let noteData = mapToNoteModel(noteEntity: noteEntityData) {
                    observer.onNext(noteData)
                } else {
                    observer.onError(CoreDataError.save)
                }
                    
                
            } catch {
                observer.onError(CoreDataError.save)
            }
            
            return Disposables.create()
        }
    }
    
    public func updateNote(idNote: String, noteModel: NoteModel) -> RxSwift.Observable<NoteModel> {
        return Observable<NoteModel>.create { observer in
            return Disposables.create()
        }
    }
    
    public func updateNote(idNote: String, noteModel: NoteModel) -> Completable {
        return Completable.create { completable in
            
            
            
            return Disposables.create()
        }
    }
    
    public func deleteNote(idNote: String) -> Completable {
        return Completable.create { completable in
            
            
            
            return Disposables.create()
        }
    }
    
    
}
