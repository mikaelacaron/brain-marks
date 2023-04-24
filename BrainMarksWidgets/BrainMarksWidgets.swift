//
//  BrainMarksCreateCategory.swift
//  BrainMarksCreateCategory
//
//  Created by Susannah Skyer Gupta on 10/6/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
      let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {

        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
          let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  func readContainer() {
    guard let URL = FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: "group.com.suzgupta.brainmarks"
    ) else {
      return
    }
    let decoder = JSONDecoder()
    if let codeData = try? Data(contentsOf: URL.appendingPathComponent("categories.json")) {
      do {
        let contents = try decoder.decode([LocalCategory].self, from: codeData)
        print(contents)
      } catch {
        print("Error: Can't decode contents")
      }
    }
  }
}

struct BrainMarksCreateCategoryEntryView : View {
    var entry: Provider.Entry

    var body: some View {

      ZStack {
        Image("littleLogo")
          .resizable()
          .scaledToFill()
          .opacity(0.1)
        Image(systemName: "folder.badge.plus")
          .font(.title)
      }
      .widgetURL(URL(string: "brainmarks://addCategory"))
   }
}

struct BrainMarksAddURLView : View {
    var entry: Provider.Entry

    var body: some View {

      ZStack {
        Image("littleLogo")
          .resizable()
          .scaledToFill()
          .opacity(0.1)
        Image(systemName: "plus.circle")
          .font(.title)
      }
      .widgetURL(URL(string: "brainmarks://addTweet"))
   }
}

struct BrainMarksLockScreenEntryView : View {
  var entry: Provider.Entry

  var body: some View {
      ZStack {
        Circle().fill(Color.accentColor).opacity(0.75)
        Image(systemName: "gamecontroller")
          .font(.largeTitle)
      }
      .onAppear() {
        let entry = SimpleEntry(date: Date())
        entry.readContainer()
      }
      // will need to pass which category to open as a URL parameter
      .widgetURL(URL(string: "brainmarks://openCategory"))
  }
}

@main
struct BrainMarksWidgetBundle: WidgetBundle {
  @WidgetBundleBuilder
  var body: some Widget {
    BrainMarksCreateCategory()
    BrainMarksAddURL()
    BrainMarksLockScreenWidget()
    // more widgets can go here
  }
}

struct BrainMarksAddURL: Widget {
    let kind: String = "BrainMarksAddURL"

    var body: some WidgetConfiguration {
        StaticConfiguration(
          kind: kind,
          provider: Provider()
        ) { entry in
          BrainMarksAddURLView(entry: entry)
        }
        .configurationDisplayName("Add Tweet")
        .description("Quickly add a Tweet to Brain Marks")
        .supportedFamilies([.systemSmall])
    }
}

struct BrainMarksCreateCategory: Widget {
    let kind: String = "BrainMarksCreateCategory"

    var body: some WidgetConfiguration {
        StaticConfiguration(
          kind: kind,
          provider: Provider()
        ) { entry in
            BrainMarksCreateCategoryEntryView(entry: entry)
        }
        .configurationDisplayName("Add Category")
        .description("Quickly add a new Brain Marks category")
        .supportedFamilies([.systemSmall])
    }
}
struct BrainMarksCreateCategory_Previews: PreviewProvider {
    static var previews: some View {
      BrainMarksCreateCategoryEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
struct BrainMarksLockScreenWidget: Widget {
    let kind: String = "BrainMarksLockScreen"

    var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
              BrainMarksLockScreenEntryView(entry: entry)
        }
        .configurationDisplayName("View Category")
        .description("Quickly access a Brain Marks category")
        .supportedFamilies([.accessoryCircular])
    }
}

struct BrainMarksLockScreenWidget_Previews: PreviewProvider {
  static var previews: some View {
    BrainMarksLockScreenEntryView(entry: SimpleEntry(date: Date()))
      .previewContext(WidgetPreviewContext(family: .accessoryCircular))
  }
}
