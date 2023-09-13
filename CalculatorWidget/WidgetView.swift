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

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
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
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((widgetHeight(forFamily: .systemLarge).width) / 4) * 2
        }
        return (widgetHeight(forFamily: .systemLarge).width) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (widgetHeight(forFamily: .systemLarge).width - (5*12)) / 4
    }
    
    func widgetHeight(forFamily family:WidgetFamily) -> CGSize {
        // better to use getTimeline func context.displaySize before this one.
        switch family {
        case .systemSmall:
            switch UIScreen.main.bounds.size {
            case CGSize(width: 428, height: 926):   return CGSize(width:170, height: 170)
            case CGSize(width: 414, height: 896):   return CGSize(width:169, height: 169)
            case CGSize(width: 414, height: 736):   return CGSize(width:159, height: 159)
            case CGSize(width: 390, height: 844):   return CGSize(width:158, height: 158)
            case CGSize(width: 375, height: 812):   return CGSize(width:155, height: 155)
            case CGSize(width: 375, height: 667):   return CGSize(width:148, height: 148)
            case CGSize(width: 360, height: 780):   return CGSize(width:155, height: 155)
            case CGSize(width: 320, height: 568):   return CGSize(width:141, height: 141)
            default:                                return CGSize(width:155, height: 155)
            }
        case .systemMedium:
            switch UIScreen.main.bounds.size {
            case CGSize(width: 428, height: 926):   return CGSize(width:364, height: 170)
            case CGSize(width: 414, height: 896):   return CGSize(width:360, height: 169)
            case CGSize(width: 414, height: 736):   return CGSize(width:348, height: 159)
            case CGSize(width: 390, height: 844):   return CGSize(width:338, height: 158)
            case CGSize(width: 375, height: 812):   return CGSize(width:329, height: 155)
            case CGSize(width: 375, height: 667):   return CGSize(width:321, height: 148)
            case CGSize(width: 360, height: 780):   return CGSize(width:329, height: 155)
            case CGSize(width: 320, height: 568):   return CGSize(width:292, height: 141)
            default:                                return CGSize(width:329, height: 155)
            }
        case .systemLarge:
            switch UIScreen.main.bounds.size {
            case CGSize(width: 428, height: 926):   return CGSize(width:364, height: 382)
            case CGSize(width: 414, height: 896):   return CGSize(width:360, height: 379)
            case CGSize(width: 414, height: 736):   return CGSize(width:348, height: 357)
            case CGSize(width: 390, height: 844):   return CGSize(width:338, height: 354)
            case CGSize(width: 375, height: 812):   return CGSize(width:329, height: 345)
            case CGSize(width: 375, height: 667):   return CGSize(width:321, height: 324)
            case CGSize(width: 360, height: 780):   return CGSize(width:329, height: 345)
            case CGSize(width: 320, height: 568):   return CGSize(width:292, height: 311)
            default:                                return CGSize(width:329, height: 345)
            }
            
        default:
            return CGSize(width:329, height: 345)
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(entry: .init(value: "123", runningNumber: 0, currentOperation: .none))
    }
}
