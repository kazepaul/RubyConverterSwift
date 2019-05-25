//
//  RCConstaints.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/25.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import Foundation

enum Grade: Int {
    case grade0
    case grade1
    case grade2
    case grade3
    case grade4
    case grade5
    case grade6
    case grade7
    case grade8
    
    func gradeDescription() -> String {
        
        switch self {
        case .grade0:
            return "ひらがなを含むテキストにふりがなを付けます。"
        case .grade1:
            return "小学1年生向け。漢字にふりがなを付けます。"
        case .grade2:
            return "小学2年生向け。1年生で習う漢字にはふりがなを付けません。"
        case .grade3:
            return "小学3年生向け。1～2年生で習う漢字にはふりがを付けません。"
        case .grade4:
            return "小学4年生向け。1～3年生で習う漢字にはふりがなを付けません。"
        case .grade5:
            return "小学5年生向け。1～4年生で習う漢字にはふりがなを付けません。"
        case .grade6:
            return "小学6年生向け。1～5年生で習う漢字にはふりがなを付けません。"
        case .grade7:
            return "中学生以上向け。小学校で習う漢字にはふりがなを付けません。"
        case .grade8:
            return "一般向け。常用漢字にはふりがなを付けません。"
        }
    }
    
    static func allCases() -> [Grade] {
        return [.grade0, .grade1, .grade2, .grade3, .grade4, .grade5, .grade6, .grade7, .grade8]
    }
}

