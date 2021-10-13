//
//  String+Ext.swift
//  brain-marks
//
//  Created by Niklas Oemler on 13.10.21.
//

import Foundation

extension String {
    func formatTimestamp() -> String {
                
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
            .withFractionalSeconds,
            .withFullDate,
            .withFullTime
        ]
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.amSymbol = "AM"
        dateFormater.pmSymbol = "PM"
        
        if let date = inputFormatter.date(from: self) {
            return dateFormater.string(from: date)
        } else {
            return self
        }
    }
}
