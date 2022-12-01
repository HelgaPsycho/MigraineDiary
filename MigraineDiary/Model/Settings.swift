//
//  Settings.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 20.10.2022.
//

import Foundation


final class UserSettings {
    
    
    static var language: String! {
        get {
            return UserDefaults.standard.string(forKey: "language")
        }
        set {
            let defaults = UserDefaults.standard
            let key = "language"
            if let language = newValue {
                print ("value: \(language) was eddded to key \(key)" )
                defaults.set(language, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static func resetLanguage (){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "language")    }
    

}
