//
//  ReuseableCell.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import UIKit

protocol ReuseableCell {
    static var reuseIdentifier: String { get }
}

extension ReuseableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
