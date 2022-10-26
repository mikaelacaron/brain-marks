//
//  SFSymbols+Extension.swift
//  brain-marks
//
//  Created by Jay Wilson on 10/4/22.
//

import Foundation

extension SFSymbol {
    var name: String { return rawValue }

    static let ALL_ICONS = Self.allCases
    static let NO_DECORATORS = Self.allCases.filter {!$0.name.hasSuffix("fill")}
        .filter {!$0.name.hasSuffix("circle")}
        .filter {!$0.name.hasSuffix("square")}
        .filter { !$0.name.contains("badge")}
    static let initialSFSymbols = [SFSymbol._folder,
                                   SFSymbol._book,
                                   SFSymbol._musicnote,
                                   SFSymbol._listbullet,
                                   SFSymbol._gamecontroller,
                                   SFSymbol._brainheadprofile,
                                   SFSymbol._star,
                                   SFSymbol._handsclap,
                                   SFSymbol._bookmark,
                                   SFSymbol._dollarsigncircle,
                                   SFSymbol._shippingbox,
                                   SFSymbol._laptopcomputer,
                                   SFSymbol._chartbar,
                                   SFSymbol._gift,
                                   SFSymbol._moon,
                                   SFSymbol._crown,
                                   SFSymbol._person]
}
