//
//  SettingsView.swift
//  MoneyManager
//
//  Created by Александр Калашников on 29.09.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Color.mainBackground.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Отменить")
                            .modifier(MyTextStyle(font: .title3, color: .mainText, fontWeight: .medium))
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.saveDataToUserDefaults()
                        dismiss()
                    } label: {
                        Text("Сохранить")
                            .modifier(MyTextStyle(font: .title3, color: .mainText, fontWeight: .medium))
                    }
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.keyboardBackground)
                
                AmountInputView(viewModel: self.viewModel)

                Divider()
                    .frame(height: 1)
                    .overlay(Color.keyboardBackground)
                
                ToThisDateView(viewModel: self.viewModel)
                
                Spacer()
                
            }
            .padding(.horizontal, 15)
            
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct AmountInputView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("Сумма")
                    .modifier(MyTextStyle(font: .title3, color: .mainText, fontWeight: .medium))
            }
            VStack(alignment: .leading, spacing: 0) {
                TextField("Введите сумму", text: $viewModel.totalMoney)
                    .modifier(MyTextStyle(font: .largeTitle, color: .mainText, fontWeight: .bold))
                    .onChange(of: viewModel.totalMoney) {
                        viewModel.calculateMoneyForDay()
                    }
                
                Text("\(viewModel.moneyForDay) в день")
                    .modifier(MyTextStyle(font: .headline, color: .mainText, fontWeight: .regular))
            }
            Spacer()
        }
    }
}

struct ToThisDateView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack(spacing: 32) {
            Text("Срок")
                .modifier(MyTextStyle(font: .title3, color: .mainText, fontWeight: .medium))
            
            Menu {
                ForEach(viewModel.getDateOptions(), id: \.date) { option in
                    Button {
                        viewModel.selectDate(option.date)
                    } label: {
                        Text(option.displayText)
                    }
                }
            } label: {
                Text("по \(viewModel.toThisDate.formatted(Date.FormatStyle().day().month(.wide)))")
                    .modifier(MyTextStyle(font: .title3, color: .mainOrange, fontWeight: .semibold))
            }
            Spacer()
        }
    }
}

struct MyTextStyle: ViewModifier {
    let font: Font
    let color: Color
    let fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontDesign(.default)
            .foregroundStyle(color)
            .fontWeight(fontWeight)
    }
}

#Preview {
    SettingsView(viewModel: MainViewModel(userDefaultsService: UserDefaultsService()))
}
