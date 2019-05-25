//
//  RCObject.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/25.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct RCObject: XMLParsableObject {
    let accessor: XML.Accessor

    init(accessor: XML.Accessor) {
        self.accessor = accessor
    }
    
    func getRubySentence() -> String {
        var sentence: String = ""
        for word in accessor["ResultSet", "Result", "WordList", "Word"] {
            if let Furigana = word.Furigana.text {
                sentence += Furigana
            }
            else if let Surface = word.Surface.text {
                sentence += Surface
            }
        }
        return sentence
    }
}
