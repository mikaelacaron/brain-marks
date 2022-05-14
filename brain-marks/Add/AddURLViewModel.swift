//
//  AddURLViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/13/21.
//

import SwiftUI

final class AddURLViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    
    func saveTweet(url: String, to category: AWSCategory, onSuccess: @escaping () -> Void) {
        TwitterAPI.fetchTweet(url: url) { result in
            switch result {
            case .success(let tweet):
                DataStoreManger.shared.createTweet(
                    tweet: tweet,
                    category: category)
                onSuccess()
            case .failure(let error):
                self.alertItem = self.alertItem(for: error)
            }
        }
    }

    private func alertItem(for error: Error) -> AlertItem {
        if let httpError = error as? HttpError {
            switch httpError {
            case .badResponse, .badRequest:
                return AlertContext.somethingWentWrong
            case .badURL:
                return AlertContext.badURL
            }
        } else {
            return AlertContext.somethingWentWrong
        }
    }
}
