//
//  Utils.swift
//  Social posts
//
//  Created by Ahmed Hamdy Gomaa on 10/20/18.
//  Copyright © 2018 Ahmed Hamdy Gomaa. All rights reserved.
//

import Foundation


class Utils {
    static let dateForamtter = DateFormatter()
    public static func convertDateToString(date: Date) -> String {
        dateForamtter.dateFormat = "dd MMM YYYY hh:mm a"
        return dateForamtter.string(from:date)
    }
}
