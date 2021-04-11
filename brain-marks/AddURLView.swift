//
//  AddURLView.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import SwiftUI

struct AddURLView: View {
    @State var newEntry = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{ Form{
            TextField("Enter copied url", text: $newEntry)
                .autocapitalization(.none)
          
            
        }.navigationBarItems(trailing:   Button("Save"){
            //save tweet
            get(url: newEntry)
            presentationMode.wrappedValue.dismiss()
        })
    }
    }

}

struct AddURLView_Previews: PreviewProvider {
    static var previews: some View {
        AddURLView()
    }
}
extension AddURLView {
    func get(url:String) {
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
                        print(result)
                        
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
