//
//  Date+.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation

extension Date {
    
    // Convert String to Date
    func convertStringToDate(stringDate:String , _ stringDateFormat:String ) -> Date {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = stringDateFormat
        dateFormate.timeZone = TimeZone.init(abbreviation: "UTC")
        let dateResult:Date = dateFormate.date(from: stringDate)!
        
        return dateResult
    }
    
    // Convert Date to String
    func convertDateToString(date:Date , _ stringDateFormat:String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringDateFormat
        //dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        //dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let stringDateResult:String = dateFormatter.string(from: date)
        
        return stringDateResult
    }
}

