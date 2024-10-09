//
//  UserDefaultsService.swift
//  MoneyManager
//
//  Created by Александр Калашников on 30.09.2024.
//

import Foundation

class UserDefaultsService {
    func save(totalMoney: String, toThisDate: Date, moneyForDay: Int, dayDifference: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(totalMoney, forKey: "totalMoney")
        userDefaults.set(toThisDate, forKey: "toThisDate")
        userDefaults.set(moneyForDay, forKey: "moneyForDay")
        userDefaults.set(dayDifference, forKey: "dayDifference")
    }
    
    func fetch() -> (totalMoney: String, toThisDate: Date, moneyForDay: Int, dayDifference: String) {
        let userDefaults = UserDefaults.standard
        let totalMoney = userDefaults.string(forKey: "totalMoney") ?? "0"
        let toThisDate = userDefaults.object(forKey: "toThisDate") as? Date ?? .init()
        let moneyForDay = userDefaults.integer(forKey: "moneyForDay")
        let dayDifference = userDefaults.string(forKey: "dayDifference") ?? "0"
        return (totalMoney, toThisDate, moneyForDay, dayDifference)
    }
}
