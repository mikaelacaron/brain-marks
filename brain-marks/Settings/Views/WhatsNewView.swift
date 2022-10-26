//
//  WhatsNewView.swift
//  brain-marks
//
//  Created by Susannah Skyer Gupta on 10/26/22.
//

import SwiftUI

struct WhatsNewView: View {
  @StateObject var viewModel: SettingsViewModel

    var body: some View {
      let plainString = viewModel.getStringFromBundle()
      let attributedString = viewModel.createAttributedString(plainString: plainString)
      Text(attributedString)
        .padding()
      Spacer()
    }
}
