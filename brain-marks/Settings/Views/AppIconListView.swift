//
//  AppIconListView.swift
//  brain-marks
//
//  Created by Koty Stannard on 10/6/22.
//

import SwiftUI

struct AppIconListView: View {
    
    @EnvironmentObject var appIconSettings: AppIconSettings
    
    var body: some View {
        Form {
            Picker("App Icons", selection: $appIconSettings.iconIndex) {
                ForEach(appIconSettings.icons.indices, id: \.self) { index in
                    IconRow(icon: appIconSettings.icons[index])
                        .tag(index)
                }
            }
            .pickerStyle(.inline)
            .onChange(of: appIconSettings.iconIndex) { newIndex in
                guard UIApplication.shared.supportsAlternateIcons else {
                    print("Application does not support alternate icons.")
                    return
                }
                
                let currentIndex = appIconSettings.icons.firstIndex(where: { icon in
                    return icon.iconName == appIconSettings.currentIconName
                }) ?? 0
                
                guard newIndex != currentIndex else { return }
                
                let selectedIcon = appIconSettings.icons[newIndex].iconName
                UIApplication.shared.setAlternateIconName(selectedIcon) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IconRow: View {
    
    let icon: Icon
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: icon.image ?? UIImage())
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                )
                .padding(.trailing)
            Text(icon.displayName)
        }
    }
}

struct AppIconListView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconListView()
            .environmentObject(AppIconSettings())
    }
}
