//
//  AddURLView.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import SwiftUI
import UIKit

struct AddURLView: View {
    @State private var showingAlert = false
    @State private var selectedCategory = AWSCategory(name: "")
    @State var newEntry = ""
    @Environment(\.presentationMode) var presentationMode
    let categories: [AWSCategory]
    
    let pasteBoard    = UIPasteboard.general
    
    var body: some View {
        NavigationView {
            Form {
                
                TextField("Enter copied url", text: $newEntry)
                    .autocapitalization(.none)
                Picker(selection: $selectedCategory , label: Text("Category"), content: {
                    ForEach(categories,id:\.self) { category in
                        Text(category.name).tag(category.id)
                    }
                })
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button {
                        // create new category
                    } label: {
                        HStack {
                            Image(systemName: "plus.app")
                                .font(.system( size: 25))
                            Text("Add Category")
                        }
                    }
                ,trailing:   Button("Save") {
                    // save tweet
                    if selectedCategory.name == ""{
                        print("Please select a CATEGORY")
                        showingAlert = true
                    }
                    
                    else{ get(url: newEntry) { result in
                        switch result {
                        case .success(let tweet):
                            
                            DataStoreManger.shared.fetchCategories { (result) in
                                if case .success(let categories) = result {
                                    DataStoreManger.shared.createTweet(
                                        tweet: tweet,
                                        category: selectedCategory)
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        case .failure(let error):
                            print("❌ Couldn't save tweet: \(error)")
                        }
                    }
                    }
                })
        }
        .onAppear {
            newEntry = pasteBoard.string ?? ""
        }
        .onDisappear{
            selectedCategory.name = ""
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Uh Oh!"), message: Text("You must select a category"), dismissButton: .default(Text("Ok")))
        }
    }
}

extension AddURLView {
    func get(url:String, completion: @escaping (Result<ReturnedTweet, Error>) -> Void) {
        
        let id = url.components(separatedBy: "/").last!.components(separatedBy: "?")[0]
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/\(id)?expansions=author_id")!,
                                 timeoutInterval: Double.infinity)
        
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
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        
                        let authorName = result.includes.users.first?.name ?? ""
                        let authorUsername = result.includes.users.first?.username ?? ""
                        
                        let tweetToSave = ReturnedTweet(id: result.data.id,
                                                        text: result.data.text,
                                                        authorName: authorName,
                                                        authorUsername: authorUsername)
                        
                        completion(.success(tweetToSave))
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
