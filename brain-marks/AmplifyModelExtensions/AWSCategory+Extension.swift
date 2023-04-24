//
//  AWSCategory+Extension.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import Foundation
/// An `Identifiable`   extension to `AWSCategory`
extension AWSCategory: Identifiable {}

/// An extention of `AWSCategory` as `Hashable` with added functionality of `hash` and  comparable `==` equatable.
extension AWSCategory: Hashable {
    
    /// To hash combine `hasher` with`id`
    /// - Parameter hasher: An  `inout` parameter of Hasher type, hashed combined with `id`
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// To check whether two `AWSCategory` are equal
    /// - Parameters:
    ///   - lhs: It is an `AWSCategory`
    ///   - rhs: It is an `AWSCategory`
    /// - Returns: Bool value (true when lhs and rhs are equal or false)
    public static func == (lhs: AWSCategory, rhs: AWSCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
