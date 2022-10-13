//
//  IrrelevantCuteView.swift
//  brain-marks
//
//  Created by Susannah Skyer Gupta on 10/7/22.
//

import SwiftUI

struct IrrelevantCuteView: View {
    var body: some View {
        VStack {
          Image("SuzsDogDaisy")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(maxWidth:200)
          Text("Cute but Terrible 🐾")
            .font(.system(.body, design: .rounded))
            .fontWeight(.bold)
        }
    }
}

struct IrrelevantCuteView_Previews: PreviewProvider {
    static var previews: some View {
        IrrelevantCuteView()
    }
}
