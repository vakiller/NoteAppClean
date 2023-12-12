//
//  BaseLabel.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import UIKit

class BaseLabel: UILabel {
    
    public func setStyle(style: BaseLabel.Styles) {
        switch style {
        case .largeTitleText:
            self.font = .boldSystemFont(ofSize: 24)
        case .titleText:
            self.font = .boldSystemFont(ofSize: 20)
        case .body:
            self.font = .systemFont(ofSize: 16)
        case .caption:
            self.font = .systemFont(ofSize: 12)
        }
    }
    
}

extension BaseLabel {
    public enum Styles {
        case largeTitleText
        case titleText
        case body
        case caption
    }
}
