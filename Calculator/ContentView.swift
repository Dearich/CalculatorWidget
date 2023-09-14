//
//  ContentView.swift
//  Calculator
//
//

import AppIntents
import SwiftUI

struct ContentView: View {
    @ObservedObject private var provisionModel = CalculationManager.shared.provisionModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 6) {
                Spacer()
                Text(provisionModel.sequence)
                    .font(.caption)
                    .foregroundColor(.white)

                // Text display
                HStack {
                    Spacer()
                    Text(provisionModel.value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.5)
                        .contentTransition(.numericText(value: Double(provisionModel.value)!))
                }
                .padding()

                // Our buttons
                ForEach(provisionModel.buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                CalculationManager.shared.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }


    func buttonWidth(item: ButtonsType) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
