//
//  ViewExt - AdaptiveView.swift
//  brain-marks
//
//  Created by AC Richter on 22.12.21.
//

import SwiftUI

/// Wraps all passed views into a stack. The stacks orientation changes with the device orientaion according to the standard direction.
///
/// - Parameters:
///   - standartDirection: the `StackDirection` in which views will be ordered by default, .vertical by default.
///   - spacing: The distance between adjacent subviews, 0 by default.
///   - content: A view builder that creates the content of this stack.
/// - Note: This acts just like a normal H/VStack.
    
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
