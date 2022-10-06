//
//  AppIconSettings.swift
//  brain-marks
//
//  Created by Koty Stannard on 10/6/22.
//

import Foundation
import SwiftUI

public struct Icon {

    public let displayName: String
    public let iconName: String?
    public let image: UIImage?
}

public final class AppIconSettings: ObservableObject {
    
    @Published public var iconIndex: Int = 0
    
    public private(set) var icons: [Icon] = []
    public var currentIconName: String? {
        UIApplication.shared.alternateIconName
    }
    
    public init() {
        fetchAppIcons()
        sortIcons()
    }
    
    private func fetchAppIcons() {
        if let bundleIcons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any] {
            if let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
               let iconFileName = (primaryIcon["CFBundleIconFiles"] as? [String])?.first {
                let displayName = (primaryIcon["CFBundleIconName"] as? String) ?? ""
                icons.append(
                    Icon(displayName: displayName,
                         iconName: nil,
                         image: UIImage(named: iconFileName)
                        )
                )
            }
            
            if let alternateIcons = bundleIcons["CFBundleAlternateIcons"] as? [String: Any] {
                alternateIcons.forEach { iconName, iconInfo in
                    if let iconInfo = iconInfo as? [String: Any],
                       let iconFileName = (iconInfo["CFBundleIconFiles"] as? [String])?.first {
                        icons.append(
                            Icon(displayName: iconName,
                                 iconName: iconName,
                                 image: UIImage(named: iconFileName)
                                )
                        )
                    }
                }
            }
        }
    }
    
    /// Sort Icons by name
    ///  - Preserves icon location in list instead of being random upon every app launch
    func sortIcons() {
        icons = icons.sorted(by: { $0.displayName < $1.displayName })
        
        // Hack solution to move Default & Black icons to top of list
        icons.swapAt(1, 1)
        icons.swapAt(2, 0)
        
        // Assign sorted icon index
        iconIndex = icons.firstIndex(where: { icon in
            return icon.iconName == currentIconName
        }) ?? 0
    }
}
