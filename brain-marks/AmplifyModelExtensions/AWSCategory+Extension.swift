//
//  AWSCategory+Extension.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import Foundation

extension AWSCategory: Identifiable {}
extension AWSCategory: Hashable{
    public func hash(into hasher: inout Hasher) {
             hasher.combine(id)
         }
         public static func ==(lhs: AWSCategory, rhs: AWSCategory) -> Bool {
             return lhs.id == rhs.id
         }
}
