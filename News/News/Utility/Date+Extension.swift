//
//  Date+Extension.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation

extension Date {
    
    func getFormattedDate(date: Date) -> String {
         
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
      //  dateformat.timeZone = TimeZone(identifier:"GMT")
        return dateformat.string(from: date)
    }
    
}
