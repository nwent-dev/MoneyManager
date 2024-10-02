//
//  UserDefaultsService.swift
//  MoneyManager
//
//  Created by Александр Калашников on 30.09.2024.
//

import Foundation

class UserDefaultsService {
    func save(totalMoney: String, toThisDate: Date) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(totalMoney, forKey: "totalMoney")
        userDefaults.set(toThisDate, forKey: "toThisDate")
    }
    
    func fetch() -> (totalMoney: String, toThisDate: Date) {
        let userDefaults = UserDefaults.standard
        let totalMoney = userDefaults.string(forKey: "totalMoney") ?? "0"
        let toThisDate = userDefaults.object(forKey: "toThisDate") as? Date ?? .init()
        return (totalMoney, toThisDate)
    }
}
