//
//  CalculatorWidget.swift
//  CalculatorWidget
//
//  Created by Azizbek on 13.09.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(value: "123", runningNumber: 0, currentOperation: .none)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(value: ModelData.shared.provisionModel.value,
                                runningNumber: ModelData.shared.provisionModel.runningNumber,
                                currentOperation: ModelData().provisionModel.currentOperation)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(value: ModelData.shared.provisionModel.value,
                                runningNumber: ModelData.shared.provisionModel.runningNumber,
                                currentOperation: ModelData().provisionModel.currentOperation)
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = .now
    let value: String
    let runningNumber: Int
    let currentOperation: Operation
}

struct CalculatorWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(entry: entry)
    }
}

struct CalculatorWidget: Widget {
    let kind: String = "CalculatorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CalculatorWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.black.edgesIgnoringSafeArea(.all)
                    }
            } else {
                CalculatorWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    CalculatorWidget()
} timeline: {
    SimpleEntry(value: "233", runningNumber: 123, currentOperation: .none)
}
