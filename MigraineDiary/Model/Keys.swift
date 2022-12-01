//
//  Keys.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 27.09.2022.
//

import Foundation


struct Keys {
    
    //UserSettings.language
    
    static var appTitle: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Migrain Diary"} else {
                return "Дневник Мигрени"
            }
        }
    }
    
    static var languageAlerMassage: String {
        get { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Choose a language"} else {
                return "Выберите язык"}
            }
        }
    }




