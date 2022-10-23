//
//  WhatsNewView.swift
//  brain-marks
//
//  Created by Susannah Skyer Gupta on 10/25/22.
//

import SwiftUI

struct WhatsNewView: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 10) {
          Text("**v1.2**")
          .font(.title3)
          Text("* Delightful updates arriving soon!")
          Text("**v1.1**")
          .font(.title3)
          Text("* Fix add folder and add tweet button not working in iOS 15")
      }
      .padding()
      Spacer()
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView()
    }
}
