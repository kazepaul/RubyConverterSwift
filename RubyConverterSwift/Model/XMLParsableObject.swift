//
//  XMLParsableObject.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/25.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import Foundation
import SwiftyXMLParser

protocol XMLParsableObject {
    var accessor: XML.Accessor { get }
    init(accessor: XML.Accessor)
}
