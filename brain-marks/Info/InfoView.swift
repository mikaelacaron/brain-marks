//
//  InfoView.swift
//  InfoView
//
//  Created by Niklas Oemler on 05.10.21.
//

import Foundation
import SwiftUI

struct InfoView<ViewModel: InfoViewModel>: View {
    let viewModel: ViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(viewModel.imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
            Spacer()
            Text(viewModel.title)
                .font(.largeTitle)
                .bold()
            Text(viewModel.message)
                .font(.headline)
                .foregroundColor(Color("twitter"))
            if let appVersion = viewModel.appVersion {
                Text(appVersion)
                    .font(.footnote)
                    .opacity(0.75)
            }
        }
        .padding()
    }
}

// MARK: - Previews
struct InfoView_previews: PreviewProvider {
    static var previews: some View {
        InfoView(viewModel: DefaultInfoViewModel())
    }
}
