//
//  DiContainer.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import Swinject

func buildContainer() -> Container {
    let container = Container()
    
    // coredata
    
    container.register(CoreDataHelperProtocol.self) { _ in
        return CoreDataHelper.shared
    }
    
    container.register(NoteDataSourceProtocol.self) { _ in
        return NoteDataSource(coreDataHelper: container.resolve(CoreDataHelperProtocol.self)!)
    }
    
    // repository
    
    container.register(NoteRepositoryProtocol.self) { _ in
        return NoteRepository(noteDataSource: container.resolve(NoteDataSourceProtocol.self)!)
    }
    
    // usecase
    
    container.register(CreateNoteUseCaseProtocol.self) { _ in
        return CreateNoteUseCase(noteRepository: container.resolve(NoteRepositoryProtocol.self)!)
    }
    
    container.register(ListNoteUseCaseProtocol.self) { _ in
        return ListNoteUseCase(noteRepository: container.resolve(NoteRepositoryProtocol.self)!)
    }
    
    container.register(DetailNoteUseCaseProtocol.self) { _ in
        return DetailNoteUseCase(noteRepository: container.resolve(NoteRepositoryProtocol.self)!)
    }
    
    return container
    
}
