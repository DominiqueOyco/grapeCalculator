//
//  ContentView.swift
//  simpleCalculator
//
//  Created by Dominique Oyco Work on 4/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var display = "0"
    @State private var firstNumber: Double?
    @State private var secondNumber: Double?
    @State private var operation: String?
    @State private var isTyping = false

    let buttons: [[String]] = [
        
        ["x²", "ln", "log"],
        ["π", "7", "8", "9", "÷"],
        ["√", "4", "5", "6", "×"],
        ["e", "1", "2", "3", "-"],
        ["(-)","0", "C", "=", "+"]
    ]

    var body: some View {
        VStack {
            Spacer()
            
            // Display Label
            Text(display)
                .font(.system(size: 70))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(Color.purple.opacity(0.3))
                .cornerRadius(20)
            
            // Buttons Grid
            ForEach(buttons, id: \.self) { row in
                HStack {
                    
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonPressed(button)
                        }) {
                            Text(button)
                                .font(.title)
                                .frame(width: 65, height: 110)
                                .background(self.isOperator(button) ? Color.purple : Color.purple.opacity(0.6))
                                .foregroundColor(.black)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .padding()
    }

    // Buttons functionality
    func buttonPressed(_ button: String) {
        if let _ = Double(button) {  // Number Pressed
            if isTyping {
                display += button
            } else {
                display = button
                isTyping = true
            }
        }else if button == "x²" {
            calculateResult()
        }else if button == "ln"{
            calculateResult()
        }else if button == "log"{
            calculateResult()
        }else if button == "π"{
            calculateResult()
        }else if button == "√"{
            calculateResult()
        }else if button == "e"{
            calculateResult()
        }else if button == "(-)"{
            calculateResult()
        }else if button == "C" {  // Clear
            clear()
        } else if button == "=" {  // Equals
            calculateResult()
        } else {  // Operators (+, -, ×, ÷)
            firstNumber = Double(display)
            operation = button
            isTyping = false
        }
    }

    // calculations
    func calculateResult() {
        guard let firstNum = firstNumber, let secondNum = Double(display), let op = operation else { return }
        
        switch op {
        case "+": display = String(firstNum + secondNum)
        case "-": display = String(firstNum - secondNum)
        case "×": display = String(firstNum * secondNum)
        case "÷":
            if secondNum != 0 {
                display = String(firstNum / secondNum)
            } else {
                display = "Error"
            }
        default: break
        }
        
        firstNumber = nil
        operation = nil
        isTyping = false
    }

    // Clear Function
    func clear() {
        display = "0"
        firstNumber = nil
        secondNumber = nil
        operation = nil
        isTyping = false
    }

    // Check if a Button is an Operator
    func isOperator(_ symbol: String) -> Bool {
        return ["+", "-", "×", "÷"].contains(symbol)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
