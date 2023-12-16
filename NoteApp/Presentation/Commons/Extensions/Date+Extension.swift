//
//  Date+Extension.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/13/23.
//

import Foundation

public enum DateFormatType: String {
    case ddMMyyyyHyphenhhmma = "dd/MM/yyyy, hh:mm a"
    case ddMMyyyyHyphenHHmmss = "dd/MM/yyyy, HH:mm:ss"
    case yyyyMMddSlashHHmm = "yyyy/MM/dd HH:mm"
    case yyyyMMddDashHHmm = "dd/MM/yyyy - hh:mm a"
    case hhmma = "hh:mm a"
    case HHmmHyphenddMMYYYY = "HH:mm '-' dd MMM YYYY"
    case ddMMyyyy = "dd/MM/yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyyAthhmma = "dd/MM/yyyy 'at' hh:mm a"
    case ddMMMyyyy = "dd MMM yyyy"
    case ddMMyyyySpaceHyphenhhmma = "dd MMM yyyy, hh:mm a"
    case ddMMMyyyyWithDash = "dd-MMM-yyyy"
    case ddMMMHyphenyyyy = "dd MMM, yyyy"
    case eeeeDDMMMYYYY = "EEEE, dd MMM yyyy"
}

extension Date {
    public func convertToString(formated: DateFormatType) -> String? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = formated.rawValue
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
}
