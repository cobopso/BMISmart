//
//  HumanVisual.swift
//  BMISmart
//
//  Created by Nguyễn Hữu Khánh on 29/03/2021.
//

import Foundation
import UIKit

struct HumanVisual {
    let gender: Gender
    let age: Int
    let look: HumanFit
    
    
    func getAdvice() -> String {
        switch look {
        case .Underweight:
            return "Thiếu cân trầm trọng, hãy bổ sung dinh dưỡng ngay, bằng cách ăn nhiều cá, thịt và ngũ cốc. Cũng đừng quên ăn nhiều rau vào nhé!"
        case .Normal:
            return "Bạn có một cơ thể cân đối, chúc mừng bạn nhé!"
        case .Overweight:
            return "Bạn có chút thừa cân, hãy chăm tập thể dục lên nào!"
        case .Obese:
            return "Bạn mà không béo thì không có ai gầy, ngưng ăn nhiều thịt cá và các đồ ăn nhăn và đồ ăn nhiều đường. Tập thể dục đều đặn lên đi!"
        }
    }
    
    func getColor() -> UIColor {
        switch look {
        case .Underweight:
            return .red
        case .Normal:
            return .rightColor
        case .Overweight:
            return .orange
        case .Obese:
            return .red
        }
    }
    
    func getVisual() -> String {
        var olds = ""
        if gender == .male {
            if age < 16 {
                olds = "boy"
            } else {
                olds = "man"
            }
        } else {
            if age < 16 {
                olds = "girl"
            } else {
                olds = "woman"
            }
        }
        
            switch look {
            case .Underweight:
                return "\(olds)Thin"
            case .Normal:
                return "\(olds)Normal"
            case .Overweight:
                return "\(olds)Chubby"
            case .Obese:
                return "\(olds)Obese1"
            }
    }
}


