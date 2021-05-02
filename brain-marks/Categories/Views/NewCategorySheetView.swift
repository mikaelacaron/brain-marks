//
//  NewCategorySheetView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 5/1/21.
//

import SwiftUI

struct NewCategorySheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var newCategory = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Enter name of new category", text: $newCategory)
                    .padding()
                
                Spacer()
                
                HStack(spacing: 25) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(Color(UIColor(named: "twitter")!))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        DataStoreManger.shared.createCategory(
                            category: AWSCategory(name: newCategory,
                                                  imageName: "swift"))
                    } label: {
                        Text("Create")
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(Color(UIColor(named: "twitter")!))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .cornerRadius(10)
                    }
                }
                .padding(20)
            }
            .navigationBarTitle("New Category")
        }
    }
}

struct NewCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategorySheetView()
    }
}
