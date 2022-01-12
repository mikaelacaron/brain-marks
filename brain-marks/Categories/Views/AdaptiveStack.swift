//
//  AdaptiveStack.swift
//  brain-marks
//
//  Created by Mikaela Caron on 1/12/22.
//

import SwiftUI

/// A Stack just like `VStack` or `HStack`, that changes its layout direction
/// depending on the device's orientation.
/// It can be used like a regular stack
/// - Parameters
///     - direction: a **`StackDirection`** that describes the default direction the stack will have.
///     - spacing: an optional **`CGFloat`** that describes the spacing between to items. Default is nil.
///     - content: a **`ViewBuilder`** function that takes any amout of views
///     and wraps them inside a `VStack` or `HStack`.
struct AdaptiveStack<Content: View>: View {
    
    enum StackDirection {
        case vertical
        case horizontal
    }
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private var standardDirection: StackDirection
    private var spacing: CGFloat?
    private var content: Content
    
    init(direction standardDirection: StackDirection = .vertical,
         spacing: CGFloat? = nil,
         @ViewBuilder content: () -> Content) {
        self.standardDirection = standardDirection
        self.spacing = spacing
        self.content = content()
    }
    
    var body: some View {
        if standardDirection == .vertical {
            if verticalSizeClass == .regular {
                VStack(spacing: spacing) {
                    content
                }
            } else {
                HStack(spacing: spacing) {
                    content
                }
            }
        } else {
            if verticalSizeClass == .compact {
                VStack(spacing: spacing) {
                    content
                }
            } else {
                HStack(spacing: spacing) {
                    content
                }
            }
        }
    }
}
