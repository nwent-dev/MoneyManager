//
//  MainView.swift
//  MoneyManager
//
//  Created by Александр Калашников on 29.09.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel(userDefaultsService: UserDefaultsService())
    @State var text: String = "0"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBackground.ignoresSafeArea()
                VStack(alignment:.leading) {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                SettingsView(viewModel: self.viewModel)
                            } label: {
                                Text("\(viewModel.totalMoney) на \(viewModel.dayDifference)")
                                    .modifier(MyTextStyle(font: .title3, color: .white, fontWeight: .regular))
                                
                                Image(systemName: "gearshape")
                                    .foregroundStyle(.white)
                                    .font(.title3)
                            }
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(Color.keyboardBackground)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(viewModel.moneyForDay)")
                                    .modifier(MyTextStyle(font: .largeTitle, color: .white, fontWeight: .bold))
                                
                                Text("На сегодня")
                                    .modifier(MyTextStyle(font: .headline, color: .white, fontWeight: .regular))
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(Color.keyboardBackground)
                        
                        Text("Показываем сколько тратить чтобы выжить на те деньги, что есть на счету")
                            .modifier(MyTextStyle(font: .title3, color: .white, fontWeight: .regular))
                        
                        NavigationLink {
                            SettingsView(viewModel: self.viewModel)
                        } label: {
                            Text("Изменить срок и сумму")
                                .modifier(MyTextStyle(font: .title3, color: .mainOrange, fontWeight: .regular))
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text("\(text)")
                            .modifier(MyTextStyle(font: .largeTitle, color: .keyboardBackground, fontWeight: .regular))
                            .padding(.horizontal, 15)
                    }
                    
                    CalcKeyboard(viewModel: self.viewModel ,text: $text)
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
                .frame(width: width, height: height)
                .background(backgroundColor)
        } else {
            Text(label)
                .foregroundColor(.black)
                .font(.title)
                .frame(width: width, height: height)
                .background(backgroundColor)
        }
    }
}

struct CalcKeyboard: View {
    @ObservedObject var viewModel: MainViewModel
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
                            viewModel.makeSpend(money: Int(text) ?? 0)
                            text = "0"
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
