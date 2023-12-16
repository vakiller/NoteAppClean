//
//  ViewModelType.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get set }
    var output: Output { get set }
    
    var disposeBag: DisposeBag { get set }
    
}
