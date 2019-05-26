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
        // MARK: - Test Code
        RCAPIClient.init(sentence: "私は帰ってきた！", grade: 1).requestForRubyConvert { [weak self] (result) in
            switch result {
                case .success(let rcObj):
                    print(rcObj.getRubySentence())
                case .failure(let error):
                    print((error as! NetworkError).rawValue)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}

