//
//  String+Ext.swift
//  brain-marks
//
//  Created by Niklas Oemler on 13.10.21.
//

import Foundation
/// An extension to `String` to add `formattimestamp`, `removingUrls` functionality
extension String {
    
    /// To format the timestamp
    /// - Returns: A `String` with date formatted as specified data format
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
    
    /// To remove urls by replacing matched types
    /// - Returns: A `String` with replaced matches of detector
    func removingUrls() -> String {
        let types = NSTextCheckingResult.CheckingType.link.rawValue
        guard let detector = try? NSDataDetector(types: types) else {
            return self
        }
        return detector.stringByReplacingMatches(in: self,
                                                    options: [],
                                                    range: NSRange(location: 0, length: self.utf16.count),
                                                    withTemplate: "")
    }
}
