//
//  SettingsViewModel.swift
//  MoneyManager
//
//  Created by Александр Калашников on 29.09.2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var totalMoney: String = "0"
    @Published var moneyForDay: Int = 0
    @Published var toThisDate: Date = .init()
    @Published var dayDifference: String = "0"
    @Published var savedMoney: String = "0"
    @Published var isMoneySaved: Bool = false
    
    private let userDefaultsService: UserDefaultsService
    
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
        fetchDataFromUserDefaults()
        checkToday()
    }
    
    func saveDataToUserDefaults() {
        userDefaultsService.save(totalMoney: self.totalMoney, toThisDate: self.toThisDate, moneyForDay: self.moneyForDay, dayDifference: self.dayDifference)
    }
    
    func fetchDataFromUserDefaults() {
        let data = userDefaultsService.fetch()
        self.totalMoney = data.totalMoney
        self.toThisDate = data.toThisDate
        self.moneyForDay = data.moneyForDay
        self.dayDifference = data.dayDifference
        if toThisDate < Date.now {
            self.toThisDate = Date.now
        }
    }
    
    func getDateOptions() -> [(date: Date, displayText: String)] {
        var dateOptions: [(Date, String)] = []
        let calendar = Calendar.current
        
        for offset in 0..<40 {
            if let date = calendar.date(byAdding: .day, value: offset, to: Date()) {
                let number = offset + 1
                let numberString = String(number)
                let dayText: String
                
                if number % 100 >= 11 && number % 100 <= 14 {
                    dayText = "\(date.formatted(.dateTime.day().month(.wide))) - \(number) дней"
                } else if numberString.last == "1" {
                    dayText = "\(date.formatted(.dateTime.day().month(.wide))) - \(number) день"
                } else if ["2", "3", "4"].contains(numberString.last) {
                    dayText = "\(date.formatted(.dateTime.day().month(.wide))) - \(number) дня"
                } else {
                    dayText = "\(date.formatted(.dateTime.day().month(.wide))) - \(number) дней"
                }
                dateOptions.append((date: date, displayText: dayText))
            }
        }
        return dateOptions
    }
    
    func selectDate(_ date: Date) {
        self.toThisDate = date
        calculateMoneyForDay()
    }
    
    func calculateMoneyForDay() {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date.now)
        let toThisDate = calendar.startOfDay(for: self.toThisDate)
        
        if currentDate == toThisDate {
            guard let totalMoneyInt = Int(totalMoney), totalMoneyInt > 0 else {
                moneyForDay = 0
                return
            }
            self.dayDifference = validateDay(1)
            moneyForDay = totalMoneyInt
        } else {
            guard let daysDifference = calendar.dateComponents([.day], from: currentDate, to: toThisDate).day,
                  daysDifference > 0,
                  let totalMoneyInt = Int(totalMoney), totalMoneyInt > 0 else {
                moneyForDay = 0
                return
            }
            self.dayDifference = validateDay(daysDifference + 1)
            moneyForDay = totalMoneyInt / (daysDifference + 1)
        }
    }
    
    func validateDay(_ day: Int) -> String {
        if day % 100 >= 11 && day % 100 <= 14 {
            return "\(day) дней"
        } else if String(day).last == "1" {
            return "\(day) день"
        } else if ["2", "3", "4"].contains(String(day).last) {
            return "\(day) дня"
        } else {
            return "\(day) дней"
        }
    }
    
    func savedMoneyForToday() {
        self.moneyForDay += Int(savedMoney) ?? 0
    }
    
    func checkToday() {
        func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
            let calendar = Calendar.current
            
            // Извлекаем только нужные компоненты: год, месяц, день
            let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
            let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
            
            // Сравниваем компоненты
            return components1.year == components2.year &&
                   components1.month == components2.month &&
                   components1.day == components2.day
        }
        
        let today = Date()
        let userDefaults = UserDefaults.standard
        let lastUpdate = userDefaults.object(forKey: "lastUpdate") as? Date ?? .init()
        
        if !isSameDate(today, lastUpdate) {
            if moneyForDay != 0 {
                savedMoney = String(moneyForDay)
                isMoneySaved = true
            }
            calculateMoneyForDay()
        }
        
        userDefaults.set(today, forKey: "lastUpdate")
    }
    
    func increaseMoneyForDay() {
        guard let savedMoneyInt = Int(savedMoney) else {
            return
        }
        self.moneyForDay += savedMoneyInt
        isMoneySaved = false
    }
    
    func collectMoney() {
        calculateMoneyForDay()
        isMoneySaved = false
    }
    
    func makeSpend(money: Int) {
        guard let totalMoneyInt = Int(totalMoney), totalMoneyInt >= money, moneyForDay >= money else {
            // Если денег недостаточно для траты
            return
        }

        // Отнимаем деньги от общего баланса и денег на день
        moneyForDay -= money
        totalMoney = String(totalMoneyInt - money)
        
        // Сохраняем изменения
        saveDataToUserDefaults()
    }
}

