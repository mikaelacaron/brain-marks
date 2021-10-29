//
//  BMButton.swift
//  brain-marks
//
//  Created by Mikaela Caron on 6/25/21.
//

import SwiftUI

struct BMButton: View {
    
    var text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .frame(width: 150, height: 50)
            .foregroundColor(.white)
            .background(Color(UIColor(named: "twitter")!))
            .font(.system(size: 20, weight: .semibold, design: .default))
            .cornerRadius(10)
    }
}

struct BMButton_Previews: PreviewProvider {
    static var previews: some View {
        BMButton(text: "Text")
    }
}
