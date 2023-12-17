//
//  NoteModel.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation

public struct NoteModel {
    public let id: String?
    public let createAt: Date?
    public let lastUpdate: Date?
    public let title: String?
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
    public var searchText: String?
    public var sortByDate: SortValue?
    public var fromDate: Date?
    public var limit: Int?
}

public enum SortValue: String {
    case asc
    case des
}
