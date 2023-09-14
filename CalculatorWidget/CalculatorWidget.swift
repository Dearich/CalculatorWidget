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
        SimpleEntry(value: "2", sequence: "1+1=", size: context.displaySize)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            value: CalculationManager.shared.provisionModel.value,
            sequence: CalculationManager.shared.provisionModel.sequence,
            size: context.displaySize
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(
            value: CalculationManager.shared.provisionModel.value,
            sequence: CalculationManager.shared.provisionModel.sequence,
            size: context.displaySize
        )
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = .now
    let value: String
    let sequence: String
    let size: CGSize
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
        .configurationDisplayName("Basic Calculator as Interactive Widget")
        .description("This is an calculator widget.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    CalculatorWidget()
} timeline: {
    SimpleEntry(value: "2", sequence: "1+1=", size: CGSize(width:329, height: 345))
}
