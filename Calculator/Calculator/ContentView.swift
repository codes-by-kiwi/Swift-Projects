//
//  ContentView.swift
//  Calculator
//
//  Created by Fizza Usman on 10/1/22.
//

import SwiftUI

//this will have a list of all the different button types
enum ButtonsCalculator: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four="4"
    case five="5"
    case six="6"
    case seven="7"
    case eight="8"
    case nine="9"
    case zero="0"
    case add="+"
    case subtract="-"
    case divide="/"
    case multiply="x"
    case equal="="
    case clear="AC"
    case decimal="."
    case percent="%"
    case negative="-/+"
    
    var btnClr: Color {
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return .purple
        }
    }
    
}

enum Operation{
    case add, subtract, multiply, divide, none
    
}

struct ContentView: View {
    @State var value = "0"
    
    @State var runningNumber = 0
    
    @State var currentOperation: Operation = .none
    //we want to have a 2d array that will represent grid of buttons we have in our calculator
    let buttons : [[ButtonsCalculator]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    var body: some View {
        ZStack {
            //background of calculator is black
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                //Text display of calc
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                //should be a white color
                        .foregroundColor(.white)
                }
                //add a padding modifier to horizontal stack because the 0 goes way off the side, touching up the edge
                .padding()
                
                // Our buttons
                ForEach(buttons, id: \.self){
                    row in
                    HStack(spacing: 12){
                        ForEach(row, id:\.self){
                        item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label:{
                                Text(item.rawValue)
                                    .font(.system(size: 25))
                                    .frame(width: self.buttonViewW(item: item), height: self.buttonViewH()
                                    )
                                    .background(item.btnClr)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonViewW(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
                
                
                
            }
        }
    }
    
    func didTap(button: ButtonsCalculator) {
        switch button{
        case .add, .subtract, .divide, .multiply, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonViewW(item: ButtonsCalculator) -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    func buttonViewH() -> CGFloat{
        return(UIScreen.main.bounds.width - (5*12))/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
