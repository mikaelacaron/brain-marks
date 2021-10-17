//
//  Text+ShorthandOperators.swift
//  brain-marks
//
//  Created by Igor Chernyshov on 20.10.2021.
//

import SwiftUI

extension Text {

	// MARK: - Addition
	static func += (lhs: inout Text, rhs: Text) {
		// swiftlint:disable:next shorthand_operator
		lhs = lhs + rhs
	}
}
