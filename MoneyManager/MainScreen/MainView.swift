//
//  MainView.swift
//  MoneyManager
//
//  Created by Александр Калашников on 29.09.2024.
//

import SwiftUI

struct MainView: View {
    @State var text: String = "0"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBackground.ignoresSafeArea()
                VStack(alignment:.leading) {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            
                            Text("8200 на 24 дня")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .fontDesign(.monospaced)
                            
                            Image(systemName: "gearshape")
                                .foregroundStyle(.white)
                                .font(.title3)
                        }
                        
                        Divider()
                            .overlay(.white)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("1911")
                                    .foregroundStyle(.white)
                                    .font(.largeTitle)
                                    .fontDesign(.monospaced)
                                    .bold()
                                
                                Text("На сегодня:")
                                    .foregroundStyle(.white)
                                    .fontDesign(.monospaced)
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                            .overlay(.white)
                        
                        Text("Показываем, сколько тратить, чтобы выжить на те деньги, что есть на счету")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontDesign(.monospaced)
                        
                        NavigationLink {
                            //
                        } label: {
                            Text("Изменить срок и сумму")
                                .foregroundStyle(.mainOrange)
                                .font(.title3)
                                .fontDesign(.monospaced)
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text("\(text)")
                            .foregroundStyle(.keyboardBackground)
                            .font(.largeTitle)
                            .fontDesign(.monospaced)
                            .padding(.horizontal, 15)
                    }
                    
                    CalcKeyboard(text: $text)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// Компонент для кнопки
struct CalcButton: View {
    let label: String
    let image: String?
    let width: CGFloat
    let height: CGFloat
    let forColor: Color
    let backgroundColor: Color
    
    var body: some View {
        if image != nil {
            Image(systemName: image!)
                .foregroundColor(forColor)
                .font(.title)
                .fontDesign(.monospaced)
                .frame(width: width, height: height)
                .background(backgroundColor)
        } else {
            Text(label)
                .foregroundColor(.black)
                .font(.title)
                .fontDesign(.monospaced)
                .frame(width: width, height: height)
                .background(backgroundColor)
        }
    }
}

struct CalcKeyboard: View {
    @Binding var text: String
    let buttonLabels = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["0", ","]
    ]
    
    var body: some View {
        GeometryReader { geometryProxy in
            let buttonWidth = geometryProxy.size.width / 4 - 1
            let buttonHeight = geometryProxy.size.height / 4 - 1
            let doubleButtonWidth = geometryProxy.size.width / 2 - 1
            
            HStack(spacing: 1) {
                VStack(spacing: 1) {
                    ForEach(buttonLabels, id: \.self) { row in
                        HStack(spacing: 1) {
                            ForEach(row, id: \.self) { label in
                                let width = (label == "0") ? doubleButtonWidth : buttonWidth
                                CalcButton(label: label, image: nil,
                                           width: width,
                                           height: buttonHeight, forColor: .black,
                                           backgroundColor: .numsBackground)
                                .onTapGesture {
                                    if text == "0" {
                                        text = ""
                                    }
                                    text.append(label)
                                }
                            }
                        }
                    }
                }
                
                VStack(spacing: 1) {
                    CalcButton(label: "Del", image: "delete.backward", width: buttonWidth, height: buttonHeight, forColor: .gray, backgroundColor: .delBackground)
                        .onTapGesture {
                            text.removeLast()
                            if text.isEmpty {
                                text = "0"
                            }
                        }
                    CalcButton(label: "Enter", image: "return", width: buttonWidth, height: buttonHeight * 3 + 2, forColor: .black, backgroundColor: .mainOrange)
                        .onTapGesture {
                            // Здесь должно быть добавление траты
                        }
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.42)
        .background(Color.keyboardBackground)
    }
}

#Preview {
    MainView()
}
