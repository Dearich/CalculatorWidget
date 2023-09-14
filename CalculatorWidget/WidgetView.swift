//
//  WidgetView.swift
//  CalculatorWidgetExtension
//
//  Created by Azizbek on 13.09.2023.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    
    var entry: SimpleEntry

    let buttons: [[ButtonsType]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                Text(entry.sequence)
                    .font(.caption)
                    .foregroundColor(.white)
                Text(entry.value)
                    .bold()
                    .font(.system(size: 46))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText(value: Double(entry.value)!))
                    .invalidatableContent()
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50, alignment: .bottomTrailing)
            VStack {
                VStack {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { column in
                                Button(intent: CalculationIntent(calcButton: column.rawValue)) {
                                    Text(column.rawValue)
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: buttonWidth(item: column), idealHeight: 40, maxHeight: .infinity, alignment: .center)
                                }
                                .background(column.buttonColor)
                                .cornerRadius(self.buttonWidth(item: column)/2)
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    func buttonWidth(item: ButtonsType) -> CGFloat {
        if item == .zero {
            return ((entry.size.width) / 4) * 2
        }
        return (entry.size.width) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (entry.size.width - (5*12)) / 4
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(entry: .init(value: "2", sequence: "1+1=", size: CGSize(width:329, height: 345)))
    }
}
