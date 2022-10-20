//
//  InformationControllerPresenter.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 20.10.2022.
//

import Foundation
import UIKit

class InformationViewControllerPresenter {
    
    let migraineEpisode: MigraineEpisode
    
    init (migraineEpisode: MigraineEpisode){
        self.migraineEpisode = migraineEpisode
    }
    
    var title: String { if (UserSettings.language == nil) || (UserSettings.language == "eng")
        {return "Information about Migrain Episode"} else {
            return "Информация об эпизоде мигрени"
        }
    }
    
    var dateLabelText: String { if (UserSettings.language == nil) || (UserSettings.language == "eng")
        {return "Date: \(migraineEpisode.date!)"} else {
            return "Дата: \(migraineEpisode.date!)"
        }
        
    }
    
    var triggersLabelText: String {if (UserSettings.language == nil) || (UserSettings.language == "eng") {
        
        if (migraineEpisode.triggers == nil) || (migraineEpisode.triggers == ""){
            return "No triggers"
        }  else {
            return "Triggers:  \(migraineEpisode.triggers!)"
        }
    } else {
        if (migraineEpisode.triggers == nil) || (migraineEpisode.triggers == ""){
            return "Без триггеров"
        }  else {
            return "Триггеры:  \(migraineEpisode.triggers!)"
        }
        
    }
    }
    
    var auraLabelText: String {
        if (UserSettings.language == nil) || (UserSettings.language == "eng")
        { if (migraineEpisode.aura == nil) || (migraineEpisode.aura == false) {
            return "No Aura"
        } else {
            return "With Aura"
        }
                
        } else {
            if (migraineEpisode.aura == nil) || (migraineEpisode.aura == false) {
                return "Без Ауры"
            }
            else {
                return "С Aурой"
            }
            }
    }
    
    var intensityLabelText: String {
        if (UserSettings.language == nil) || (UserSettings.language == "eng")
        {return "Intensity: "} else {
                return "Интенсивность: "
            }
       
        
    }
    
    var intensityView: UIImage { UIImage(imageLiteralResourceName: "\(migraineEpisode.intensity)")
    }
    
    var medicationLabelText: String { if (UserSettings.language == nil) || (UserSettings.language == "eng")
        {if migraineEpisode.medication == "" {
            return "No medication"
        }  else {
            return "Medication: \(migraineEpisode.medication!)"
        }} else {
            if migraineEpisode.medication == "" {
                return "Без приема анальгетиков"
            }  else {
                return "Медикаменты:  \(migraineEpisode.medication!)"
            }
        }
        
    }
    
    var durationLabelText: String {if (UserSettings.language == nil) || (UserSettings.language == "eng")
        {return "Duration: \(String(describing: migraineEpisode.dutation!)) hours"} else {
            return "Продолжительность: \(String(describing: migraineEpisode.dutation!)) часов"
        }
        
    }
    
    var intensityAfterMedicationLabelText: String {
        if (UserSettings.language == nil) || (UserSettings.language == "eng")
        {return "Intensity after medicatoin: "} else {
                return "Интенсивность после приема анальгетиков: "
            }
       
        
    }
    
    var intensityAfterMedicationView: UIImage { UIImage(imageLiteralResourceName: "\(migraineEpisode.intensityAfterMadication)")
    }
    
    
}


