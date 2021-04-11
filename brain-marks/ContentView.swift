//
//  ContentView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CategoryList(categories: [
                Category(id: 0, name: "SwiftUI", numberOfTweets: 3, imageName: "swift"),
                Category(id: 1, name: "BigBrainHacks", numberOfTweets: 5, imageName: "laptopcomputer")
            ])
            Button("hey",action: {
                get()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension ContentView {
    func get() {
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/1380990780248973312")!,timeoutInterval: Double.infinity)
        
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
