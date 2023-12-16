//
//  String+Extension.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/13/23.
//

import Foundation
import UIKit

extension String {
    
    func color() -> UIColor {
        let hash = self.hash
        let colorCode = abs(hash) % 0x1000000
        let red = colorCode >> 16
        let green = (colorCode >> 8) & 0xff
        let blue = colorCode & 0xff
        return UIColor(red: CGFloat(red) / 256, green: CGFloat(green) / 256, blue: CGFloat(blue) / 256, alpha: 1)
    }
    
}
