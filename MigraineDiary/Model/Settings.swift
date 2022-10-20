//
//  Settings.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 20.10.2022.
//

import Foundation


final class UserSettings {
    
    private enum SettingsKeys: String {
        case language
    }
    
    static var language: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.language.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.language.rawValue
            if let language = newValue {
                print ("value: \(language) was eddded to key \(key)" )
                defaults.set(language, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    

}
