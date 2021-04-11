//
//  AddURLView.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import SwiftUI

struct AddURLView: View {
    @State var newEntry = ""
    var body: some View {
        NavigationView{ Form{
            TextField("Enter copied url", text: $newEntry)
          
            
        }.navigationBarItems(trailing:   Button("Save"){
            //save tweet
        })
    }
    }
}

struct AddURLView_Previews: PreviewProvider {
    static var previews: some View {
        AddURLView()
    }
}
