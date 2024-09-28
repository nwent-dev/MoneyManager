//
//  MainView.swift
//  MoneyManager
//
//  Created by Александр Калашников on 29.09.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBackground.ignoresSafeArea()
                VStack(alignment:.leading) {
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
                    
                    Spacer()
                }
                .padding(.horizontal, 15)
            }
        }
    }
}

#Preview {
    MainView()
}
