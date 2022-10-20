//
//  BlankViewControllerPresenter.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 20.10.2022.
//

import Foundation

class BlankViewControllerPresenter {

    
    var appName: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Migrain Diary"} else {
                return "Дневник Мигрени"
            }
        }
    }
    
    var informationControllerTitle: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Information about Migrain Episode"} else {
                return "Инфонмация об эпизоде мигрени"
            }
        }
    }
    
    var migrainEpisodeBlank: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Migrain Episode Blank"} else {
                return "Бланк Эпизода Мигрени"
            }
        }
    }
    
    var triggers: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Triggers"} else {
                return "Триггеры"
            }
        }
    }
    
//    static var triggersList: String {
//        get {
//            return
//        }
//    }
    
    var withAura: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "With Aura"} else {
                return "С аурой"
            }
        }
    }
    
    var noAura: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "No Aura"} else {
                return "Без ауры"
            }
        }
    }
    
    var intensity: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Intensity"} else {
                return "Интенсивность"
                
            }
        }
    }
    
    var medication: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Medication:"} else {
                return "Медикаменты:"
                
            }
        }
    }
    
    var durationInHours: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Duration in hours"} else {
                return "Длительность в часах"
                
            }
        }
    }
    
    var intensityAfterMedication: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Intensity after medicatoin"} else {
                return "Интенсивность после приема медикаментов"
                
            }
        }
    }
    
    var date: String {
        get
        { if (UserSettings.language == nil) || (UserSettings.language == "eng")
            {return "Date"} else {
                return "Дата"
                
            }
        }
    }
    
    
}
