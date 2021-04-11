//
//  AddURLView.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import SwiftUI

struct AddURLView: View {
    @State private var selectedCategory = "None"
    @State var newEntry = ""
    @Environment(\.presentationMode) var presentationMode
    let categories = ["SwiftUI", "BigBrainHacks"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter copied url", text: $newEntry)
                    .autocapitalization(.none)
                Picker(selection: $selectedCategory , label: Text("Category"), content: {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                })
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarItems(leading:Button(action: {
                // create new category
            }) {
                HStack {
                    Image(systemName: "plus.app")
                        .font(.system( size: 25))
                    Text("Add Category")
                    
                }
            } ,trailing:   Button("Save") {
                // save tweet
                
                get(url: newEntry)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
}

extension AddURLView {
    func get(url:String) {
        var count = 0
        
        let id = url.components(separatedBy: "/").last!.components(separatedBy: "?")[0]
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/\(id)")!,timeoutInterval: Double.infinity)
        
        request.addValue("Bearer \(Secrets.bearerToken)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                
                return
            }
            
            if let response = response as? HTTPURLResponse {
                guard (200 ... 299) ~= response.statusCode else {
                    print("Status code :- \(response.statusCode)")
                    return
                }
                
                do {
                    if error == nil {
                        let result = try JSONDecoder().decode(ResponseModel.self, from: data)
                        // update UI
                        count += 1
                        print("\(count)\(result)")
                        
                    }
                    
                    DispatchQueue.main.async {
                        // update UI
                    }
                    
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
