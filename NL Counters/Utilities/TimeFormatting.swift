//
//  TimeFormatting.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/22/22.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes % 60 == 1 {
        if minutes < 60 {
            return "\(minutes) minute"
        } else if minutes >= 60 && hours < 24 {
            return "\(hours) hours, \(minutes%60) minute"
        } else {
            return "\(days) days, \(hours%24) hours"
        }
    } else {
        if minutes < 60 {
            return "\(minutes) minutes"
        } else if minutes >= 60 && hours < 24 {
            return "\(hours) hours, \(minutes%60) minutes"
        } else {
            return "\(days) days, \(hours%24) hours"
        }
    }
    
}
