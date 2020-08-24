//
//  Extension.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import UIKit
import DeepDiff



extension DiffAware where Self: Hashable {
    public var diffId: Int {
        return hashValue
    }

    public static func compareContent(_ a: Self, _ b: Self) -> Bool {
        return a == b
    }
}
extension Date {
    static func convertDateString(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "en_US")
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"

        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!)
    }
    
}

extension UIColor {
    
    static var colorOrange: UIColor {
        return UIColor(red: 1.00, green: 0.45, blue: 0.08, alpha: 1.00)
    }
    
    static var colorWhite: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    static var colorLightBlack: UIColor {
        return UIColor(red: 0.22, green: 0.21, blue: 0.20, alpha: 1.00)
    }
    
    static var colorBlack: UIColor {
        return UIColor(red: 0.13, green: 0.13, blue: 0.12, alpha: 1.00)
    }

    
}
