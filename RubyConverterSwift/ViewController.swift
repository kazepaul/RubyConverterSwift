//
//  ViewController.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/22.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import Alamofire
import SwiftyXMLParser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RCAPIClient.init(sentence: "私は帰ってきた！", grade: "2").requestForRubyConvert { [weak self] (furiganaText) in
            print(furiganaText)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}

