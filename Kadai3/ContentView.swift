//
//  ContentView.swift
//  Kadai3
//

import SwiftUI

struct ContentView: View {
    @State private var textNum1: String = ""
    @State private var textNum2: String = ""
    @State private var signedNum1: Int = 0
    @State private var signedNum2: Int = 0
    @State private var isNum1Negative: Bool = false
    @State private var isNum2Negative: Bool = false
    @State private var calcAns: String = "Label"
    var body: some View {
        VStack(spacing: 50) {
            HStack(spacing: 50) {
                NumInputAndToggleField(textNum: $textNum1, isNumNegative: $isNum1Negative)
                NumInputAndToggleField(textNum: $textNum2, isNumNegative: $isNum2Negative)
            }
            Button(action: {
                signedNum1 = convertNum(textNum1, isNum1Negative)
                signedNum2 = convertNum(textNum2, isNum2Negative)
                calcAns = String(signedNum1 + signedNum2)
                UIApplication.shared.closeKeyboard()
            }, label: {
                Text("Button")
            })
            HStack(spacing: 75) {
                Text("\(signedNum1)")
                Text("+")
                Text("\(signedNum2)")
            }
            Text(calcAns)
        }.padding(50)
    }
    private func convertNum(_ textNum: String, _ isNegative: Bool) -> Int {
        guard let num = Int(textNum) else {
            return 0
        }
        return isNegative ? -num : num
    }
}

struct NumInputAndToggleField: View {
    @Binding var textNum: String
    @Binding var isNumNegative: Bool
    var body: some View {
        VStack {
            TextField("", text: Binding(
                        get: { self.textNum },
                        set: { self.textNum = $0.filter {"0123456789".contains($0)}}))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            HStack(alignment: .center, spacing: 10) {
                Text("+")
                Toggle("", isOn: $isNumNegative)
                Text("-")
            }
        }
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
