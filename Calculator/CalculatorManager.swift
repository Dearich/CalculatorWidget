//
//  CalculationManager.swift
//  CalculatorWidgetExtension
//
//  Created by Azizbek on 13.09.2023.
//

import Foundation
import SwiftUI

final class ProvisionModel: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    @Published var value: String = "0"
    @Published var sequence: String = ""
    let buttons: [[ButtonsType]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var displayValue: Double {
        get {
            return Double(value) ?? Double.nan
        }
        set {
            let tmp = String(newValue).removeAfterPointIfZero()
            value = tmp.setMaxLength(of: 8)
        }
    }
    
}

class CalculationManager {
    // using singleton for store value in widget
    static let shared = CalculationManager()
    
    // MARK: - Properties
    
    private var brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    // model and state for create entry for snapshot in widget
    var provisionModel = ProvisionModel()
    
    // MARK: - Methods
    
    func didTap(button: ButtonsType) {
        switch button {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .decimal:
            touchDigit(button.rawValue)
            
        case .add, .subtract, .divide, .mutliply, .equal, .clear, .percent, .negative:
            performOperation(button.rawValue)
        }
        
    }
}
    
private extension CalculationManager {
    private func touchDigit(_ digit: String) {
        if userIsInTheMiddleOfTyping {
            if digit == "." && (provisionModel.value.range(of: Constants.decimalPoint) != nil) {
                return
            } else {
                let tmp = provisionModel.value + digit
                provisionModel.value = tmp.setMaxLength(of: Constants.maxStringLength)
            }
            
        } else {
            if digit == Constants.decimalPoint {
                provisionModel.value = Constants.pointAfterZero
            } else {
                provisionModel.value = digit.removeAfterPointIfZero()
            }
            userIsInTheMiddleOfTyping = true
        }
        
        provisionModel.sequence = brain.description
    }
    
    private func performOperation(_ mathematicalSymbol: String) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(provisionModel.displayValue)
            userIsInTheMiddleOfTyping = false
        }
        brain.performOperation(mathematicalSymbol)
        if let result = brain.result {
            provisionModel.displayValue = result
        }
        provisionModel.sequence = brain.description
    }
}
    
