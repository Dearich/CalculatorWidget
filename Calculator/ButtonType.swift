
import UIKit
import SwiftUI

enum ButtonsType: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "＋"
    case subtract = "﹣"
    case divide = "÷"
    case mutliply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "±"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

// MARK: - Operation

enum Operation {
    case add, subtract, multiply, divide, none
}


// MARK: - Constants

struct Constants {
        static let cornerRadius: CGFloat = 35.0
        static let decimalPoint: String = "."
        static let emptyString: String = ""
        static let maxStringLength: Int = 14
        static let pointAfterZero: String = "0."
}
