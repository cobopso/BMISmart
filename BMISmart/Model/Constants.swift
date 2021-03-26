//
//  Constants.swift
//  BMISmart
//
//  Created by Nguyễn Hữu Khánh on 26/03/2021.
//

import Foundation
import UIKit

extension UIColor {
    static let bgColor = UIColor(red: 246/255, green: 248/255, blue: 255/255, alpha: 1.0)
    static let lightGrayColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1.0)
    static let lightBlueColor = UIColor(red: 0.24, green: 0.36, blue: 0.91, alpha: 1.00)
    static let rightColor = UIColor(red: 0.36, green: 0.83, blue: 0.62, alpha: 1.00)
}

enum Size {
    case CompactHeight
    case Compact
    case Regular
}

extension UIView {
    func containerbg() {
        layer.cornerRadius = 20
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.3
    }
}

enum Human {
    case girlSlim
    case girlObese
    case womanSlim
    case womanObese
    
    case boySlim
    case boyObese
    case manSlim
    case manObese
}

enum Gender {
    case male
    case female
}

enum HumanFit {
    case Underweight
    case Normal
    case Overweight
    case Obese
}
