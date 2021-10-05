//
//  EmptyListView.swift
//  EmptyListView
//
//  Created by Niklas Oemler on 05.10.21.
//

import Foundation
import SwiftUI

struct EmptyListView: View {
    var title: String = "This looks empty in here..."
    let message: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Spacer()
            Image(systemName: "moon.stars")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("twitter"))
            Text(title)
                .font(.title)
                .bold()
                .padding(.top, 20)
            Text(message)
                .font(.headline)
                .opacity(0.75)
            Spacer()
        }
        .padding()
    }
}


// MARK: - Previews
struct EmptyListView_previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(
            message: "Lets get started by adding your first category!"
        )
    }
}
