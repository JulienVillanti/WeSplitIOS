//
//  ContentView.swift
//  WeSplit
//
//  Created by Julien Villanti on 2024-09-21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var tipPercentage2 = 15
    @FocusState private var amountIsFocused: Bool

    let tipPercentages: [Int] = [10, 15, 20, 25, 30]
    
    let tipPercentages2 = 0...100

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var bigTotal: Double {
        let amountBeforeTip = Double(checkAmount)
        let totalTip = Double(checkAmount * Double(tipPercentage) / 100)
        let BigTotal = amountBeforeTip + totalTip
        
        return BigTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage2) {
                        ForEach(0 ..< 101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                }
                
                Section("Total amount (global)") {
                    Text(bigTotal, format: .currency(code: Locale.current.currency?.identifier ?? "CAD")).font(.largeTitle)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
