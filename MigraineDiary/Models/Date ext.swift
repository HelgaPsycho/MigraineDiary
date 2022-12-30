//
//  Date ext.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 30.12.2022.
//

import Foundation

extension Date {
    var dayAndTimeTextEng: String {

            if Locale.current.calendar.isDateInToday(self) {
              let dateFormat = NSLocalizedString("Today", comment: "Today format string")
                return String(format: dateFormat)
            } else{
                let dateText = formatted(.dateTime.month(.abbreviated).day().year())
                let dateFormat = NSLocalizedString("%@", comment: "Date format string")
                return String(format: dateFormat, dateText)
            }
        }
    
    var dayAndTimeTextRu: String {

            //Passing .omitted for the date style creates a string of only the time component.
            if Locale.current.calendar.isDateInToday(self) {
                let dateFormat = NSLocalizedString("Сегодня", comment: "Сегодня format string")
                  return String(format: dateFormat)
            } else{
                let dateText = formatted(.dateTime.month(.abbreviated).day().year())
                let dateFormat = NSLocalizedString("%@", comment: "Date format string")
                return String(format: dateFormat, dateText)
            }
        }
}
