//
//  ViewModelListNoteTests.swift
//  NoteAppTests
//
//  Created by Le Mai Viet Anh on 12/18/23.
//nr

import XCTest
@testable import NoteApp
import RxSwift

class ViewModelListNoteTests: XCTestCase {
    
    var listNoteUseCaseMock: ListNoteUseCaseProtocol?
    var vm: ListNotesViewModel?
    var mockNoteRepository = MockNoteRepository()
    
    override func setUp() {
        listNoteUseCaseMock = ListNotesUseCaseMock()
        self.vm = ListNotesViewModel(listNoteUseCase: listNoteUseCaseMock!)
    }
    
    func test_start_request_list_note() {
        self.vm?.startRequestGetListNotes()
        
        XCTAssertEqual(self.vm?.output.listNotes.value?.first?.id, mockNoteRepository.listNotes.first?.id)
        XCTAssertEqual(self.vm?.output.listNotes.value?.count, mockNoteRepository.listNotes.count)
        XCTAssertEqual(self.vm?.output.listNotes.value?.last?.id, mockNoteRepository.listNotes.last?.id)
    }
    
    func test_delete_note_should_fail_in_list_note() {
        self.vm?.startRequestGetListNotes()
        self.vm?.deleteNoteInListNote(noteModel: mockNoteRepository.listNotes.first)
        
        XCTAssertEqual(self.vm?.listNotes.value?.firstIndex(where: { $0.id == mockNoteRepository.listNotes.first?.id }), 0)
    }
    
    func test_add_note_mock_data() {
        let addNoteMockData = AddNoteMockData(detailNoteUseCase: DiResolver.shared.resolve(DetailNoteUseCaseProtocol.self))
        addNoteMockData.addListNoteTest()
    }
    
    
}
