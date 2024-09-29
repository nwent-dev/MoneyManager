//
//  SettingsView.swift
//  MoneyManager
//
//  Created by Александр Калашников on 29.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.mainBackground.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Text("Отменить")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontDesign(.monospaced)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Сохранить")
                            .foregroundStyle(.mainOrange)
                            .font(.title3)
                            .fontDesign(.monospaced)
                    }
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.keyboardBackground)
                
                HStack(spacing: 20) {
                    VStack {
                        // Нужно сделать так что этот текст был сверху
                        Text("Сумма")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontDesign(.monospaced)
                    }
                    VStack(alignment: .leading) {
                        Text("8200")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .fontDesign(.monospaced)
                            .bold()
                        
                        Text("341 в день")
                            .foregroundStyle(.white)
                            .fontDesign(.monospaced)
                    }
                    Spacer()
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.keyboardBackground)
                
                HStack(spacing: 32) {
                    Text("Срок")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontDesign(.monospaced)
                    
                    Text("по 22 октября")
                        .foregroundStyle(.mainOrange)
                        .font(.title3)
                        .fontDesign(.monospaced)
                    
                    Spacer()
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    SettingsView()
}
