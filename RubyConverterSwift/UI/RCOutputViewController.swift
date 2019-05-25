//
//  RCOutputViewController.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/24.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import UIKit
import SnapKit

class RCOutputViewController: UIViewController {

    var inputText: String!
    var outputText: String!
    
    let inputTextViewTitleLabel = UILabel()     // 入力タイトルLabel
    let inputTextView = UITextView()            // 入力TextView
    
    let outputTextViewTitleLabel = UILabel()    // 変換結果タイトルLabel
    let outputTextView = UITextView()           // 変換結果TextView

    required init(input: String, output: String) {
        super.init(nibName: nil, bundle: nil)
        inputText = input
        outputText = output
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupGesture()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(inputTextViewTitleLabel)
        view.addSubview(inputTextView)
        view.addSubview(outputTextViewTitleLabel)
        view.addSubview(outputTextView)
        
        // 入力タイトルLabel設定
        inputTextViewTitleLabel.text = "入力した文字"
        
        // 入力TextView設定
        inputTextView.text = inputText
        inputTextView.isEditable = false
        inputTextView.font = UIFont.systemFont(ofSize: 15)
        inputTextView.sizeToFit()
        inputTextView.isScrollEnabled = false
        
        // 変換結果タイトルLabel設定
        outputTextViewTitleLabel.text = "変換結果"
 
        // 変換結果TextView設定
        outputTextView.layer.borderColor = UIColor.gray.cgColor
        outputTextView.layer.borderWidth = 3.0
        outputTextView.layer.cornerRadius = 10.0
        outputTextView.text = outputText
    }
    
    // MARK: - Layout Setup
    func setupLayout() {
        inputTextViewTitleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(inputTextView.snp.top).offset(-10)
        }
        
        inputTextView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(outputTextViewTitleLabel.snp.top).offset(-10)
        }
        
        outputTextViewTitleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(outputTextView.snp.top).offset(-20)
        }
        
        outputTextView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.greaterThanOrEqualTo(inputTextView.snp.size)
        }
    }
    
    // MARK: - Setup Gesture
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Dismiss Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
