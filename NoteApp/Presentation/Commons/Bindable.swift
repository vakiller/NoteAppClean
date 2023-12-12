//
//  Bindable.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation

protocol Bindable {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get set }
    func bindViewModel()
}
