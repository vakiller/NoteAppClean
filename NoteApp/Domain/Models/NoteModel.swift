//
//  NoteModel.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation

public struct NoteModel {
    public let id: String?
    public let lastUpdate: Date?
    public let content: String?
    public let checkList: [CheckListItem]?
}

public struct CheckListItem {
    public let id: String?
    public let title: String?
    public let isCheck: Bool?
}

public struct GetNoteRequest {
    public let noteId: String?
}

public struct GetListNotesRequest {
    public let searchText: String?
    public let sortByDate: SortValue?
}

public enum SortValue: String {
    case asc
    case des
}
