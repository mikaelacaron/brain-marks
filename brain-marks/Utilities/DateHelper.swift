//
//  DateHelper.swift
//  brain-marks
//
//  Created by Victor Capilla Developer on 5/10/21.
//

import Foundation


func customizeDateFrom(string: String, fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: String = "dd-MM-yyyy HH:mm:ss") -> String {
    
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = fromFormat
    if let date = dateFormatter.date(from: string) {
        dateFormatter.dateFormat = toFormat
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    } else {
        return ""
    }
    
}

