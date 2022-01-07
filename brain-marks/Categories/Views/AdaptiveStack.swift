//
//  AdaptiveStack.swift
//  brain-marks
//
//  Created by AC Richter on 07.01.22.
//

import SwiftUI

/// A Stack just like V- or HStack, that changes its layout direction depending on the device's Orientation
/// - Parameters
///     - direction: a **`StackDirection`** that describes the default direction the stack will have.
///     - spacing: an optional **`CGFloat`** that describes the spacing between to items. Default is nil.
///     - content: a **`ViewBuilder`** function that takes any amout of views and wraps them inside a V- or HStack.
/// - Note
///   - This can be used just like a regular Stack

struct AdaptiveStack<Content: View>: View {
    
    enum StackDirection {
        case vertical
        case horizontal
    }
    
    @Environment(\.verticalSizeClass) var sizeClass
    
    private var standardDirection: StackDirection
    private var spacing: CGFloat?
    private var content: Content
    
    public init(direction standardDirection: StackDirection = .vertical, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.standardDirection = standardDirection
        self.spacing = spacing
        self.content = content()
    }
    
    var body: some View {
        if standardDirection == .vertical {
            if sizeClass == .regular {
                VStack(spacing: spacing) {
                    content
                }
            } else {
                HStack(spacing: spacing) {
                    content
                }
            }
        } else {
            if sizeClass == .compact {
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
