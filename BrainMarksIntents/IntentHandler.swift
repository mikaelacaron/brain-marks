//
//  IntentHandler.swift
//  BrainMarksIntents
//
//  Created by Susannah Skyer Gupta on 10/30/22.
//

import Intents
import SwiftUI

class IntentHandler: INExtension, ConfigurationIntentIntentHandling {

  @ObservedObject var viewModel = CategoryListViewModel()

  // based on https://github.com/chFlorian/StocksApp/blob/main/StocksAppIntents/IntentHandler.swift

  func provideTweetCategoryOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<TweetCategory>?, Error?) -> Void) {

    let categories: [TweetCategory] = viewModel.categories

          // Create a collection with the array of categories.
          let collection = INObjectCollection(items: categories)

          // Call the completion handler, passing the collection.
          completion(collection, nil)
      }
    
}
