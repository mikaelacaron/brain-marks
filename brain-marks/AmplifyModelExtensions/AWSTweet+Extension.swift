//
//  AWSTweet+Extension.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import Foundation

extension AWSTweet: Identifiable {}
extension AWSTweet:Hashable{
    public static func == (lhs: AWSTweet, rhs: AWSTweet) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
             hasher.combine(id)
         }
}
