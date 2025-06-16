//
//  ContentView.swift
//  MacCalc
//
//  Created by Ivan Saydyashev on 15.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var task = "0"
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    let buttons = ["7", "8", "9", "÷", "4", "5", "6", "×", "1", "2", "3", "-", "0", "C", "=", "+"]
    
    var body: some View {
        VStack{
            Text(task).font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
            LazyVGrid(columns: columns){
                ForEach(buttons, id: \.self){ label in
                    Button(label){
                        if label.allSatisfy({$0.isNumber}){
                            if task == "0" || task == "Error"{
                                task = label
                            } else if task.count < 18{
                                task += label
                            }
                        } else if label == "C"{
                            task = "0"
                        } else if label == "="{
                            let format = task.replacingOccurrences(of: "×", with: "*").replacingOccurrences(of: "÷", with: "/")
                            let expr = NSExpression(format: format)
                            let result = expr.expressionValue(with: nil, context: nil) as? NSNumber
                            task = String(describing: result ?? 0)
                            if task == "0"{
                                task = "Error"
                            }
                        } else if task.count < 17{
                            if let last = task.last, "+-×÷".contains(last) == false {
                                task += label
                            }
                        }
                        
                    }.font(.title).padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .buttonStyle(PlainButtonStyle())
                        .contentShape(Rectangle())
                        
                }
            }
            Button(action: {
                task.removeLast()
                if task.isEmpty {
                    task = "0"
                }
            }) {
                Image(systemName: "delete.left")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
    
            }.frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .buttonStyle(PlainButtonStyle())
            .contentShape(Rectangle())
        }.padding(50)
    }
    
}



#Preview {
    ContentView()
}
