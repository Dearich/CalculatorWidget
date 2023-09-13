//
//  CalculationManager.swift
//  CalculatorWidgetExtension
//
//  Created by Azizbek on 13.09.2023.
//

import Foundation

struct ProvisionModel: Identifiable{
    var id: String = UUID().uuidString
    var value: String
    var runningNumber: Int
    var currentOperation: Operation = .none
}

class ModelData {
    static let shared = ModelData()
    
    var provisionModel = ProvisionModel(value: "0", runningNumber: 0)
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                provisionModel.currentOperation = .add
                provisionModel.runningNumber = Int(provisionModel.value) ?? 0
            }
            else if button == .subtract {
                provisionModel.currentOperation = .subtract
                provisionModel.runningNumber = Int(provisionModel.value) ?? 0
            }
            else if button == .mutliply {
                provisionModel.currentOperation = .multiply
                provisionModel.runningNumber = Int(provisionModel.value) ?? 0
            }
            else if button == .divide {
                provisionModel.currentOperation = .divide
                provisionModel.runningNumber = Int(provisionModel.value) ?? 0
            }
            else if button == .equal {
                let runningValue = provisionModel.runningNumber
                let currentValue = Int(provisionModel.value) ?? 0
                switch provisionModel.currentOperation {
                case .add: provisionModel.value = "\(runningValue + currentValue)"
                case .subtract: provisionModel.value = "\(runningValue - currentValue)"
                case .multiply: provisionModel.value = "\(runningValue * currentValue)"
                case .divide: provisionModel.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }

            if button != .equal {
                provisionModel.value = "0"
            }
        case .clear:
            provisionModel.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if provisionModel.value == "0" {
                provisionModel.value = number
            }
            else {
                provisionModel.value = "\(provisionModel.value)\(number)"
            }
        }
    }
}
