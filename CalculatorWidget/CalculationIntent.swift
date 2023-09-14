//
//  CalculationIntent.swift
//  CalculatorWidgetExtension
//
//  Created by Azizbek on 13.09.2023.
//

import AppIntents


struct CalculationIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculation button"
    static var description = IntentDescription("Use calculator in Widget.")

    @Parameter(title: "CalcButton")
    var calcButtonTitle: String

    init() {}

    init(calcButton: String) {
        self.calcButtonTitle = calcButton
    }

    func perform() async throws -> some IntentResult {
        CalculationManager.shared.didTap(button: .init(rawValue: calcButtonTitle) ?? .clear)
        print("Updated")
        return .result()
    }
}
