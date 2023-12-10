//
//  ViewController.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let coreDataHelper = CoreDataHelper()
    
    var noteDataSource: NoteDataSourceProtocol?
    
    var noteRepository: NoteRepositoryProtocol?
    
    private var noteUseCase: CreateNoteUseCaseProtocol?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        self.noteDataSource = NoteDataSource(coreDataHelper: coreDataHelper)
        self.noteRepository = NoteRepository(noteDataSource: self.noteDataSource!)
        self.noteUseCase = CreateNoteUseCase(noteRepository: self.noteRepository!)
        
        self.testUseCase()
        // Do any additional setup after loading the view.
    }

    private func testUseCase() {
        
        let noteModel = NoteModel(id: "aaaa", lastUpdate: .now, content: "Test Now", checkList: [])
        
        self.noteUseCase?.createNewTextNote(noteModel: noteModel)
            .subscribe(onCompleted: {
                print("SAVE OK NAY !")
            },
                       onError: { error in
                print("Error Nayf \(error)")
            })
            .disposed(by: disposeBag)
        
        let noteRequest = GetNoteRequest(noteId: "aaaa")
        
        self.noteUseCase?.getDetailNote(noteRequest: noteRequest)
            .withUnretained(self)
            .subscribe(onNext: { owner, noteData in
                print("Detail \(noteData)")
            })
            .disposed(by: disposeBag)
    }

}

