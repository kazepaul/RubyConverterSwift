//
//  RCInputViewController.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/24.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import UIKit
import SnapKit

class RCInputViewController: UIViewController {
    
    let titleLabel = UILabel()   //　タイトルLabel
    let inputTextView = UITextView()  // 入力TextView
    let gradeSlider = UISlider()    // 変換レベルスライダ
    let gradeDescriptionLabel = UILabel()   //　変換レベル説明Label
    let convertButton = UIButton()  // 変換ボタン
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        
        changeGrade(0)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(titleLabel)
        view.addSubview(inputTextView)
        view.addSubview(gradeDescriptionLabel)
        view.addSubview(gradeSlider)
        view.addSubview(convertButton)
        
        // タイトルLabel設定
        titleLabel.text = "変換したい文字を入力してください"
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.left.equalToSuperview().offset(20)
            make.bottom.equalTo(inputTextView.snp.top).offset(-10)
        }
        
        // TextView設定
        inputTextView.layer.borderColor = UIColor.gray.cgColor
        inputTextView.layer.borderWidth = 3.0
        inputTextView.layer.cornerRadius = 10.0
        inputTextView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(gradeDescriptionLabel.snp.top).offset(-10)
        }
        
        // 変換レベル説明Label設定
        gradeDescriptionLabel.numberOfLines = 0
        gradeDescriptionLabel.snp.makeConstraints { (make) in
            make.height.equalTo(70)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(gradeSlider.snp.top).offset(-10)
        }
        // スライダ設定
        gradeSlider.maximumValue = 8
        gradeSlider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .valueChanged)
        gradeSlider.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(convertButton.snp.top).offset(-20)
        }
        // 変換ボタン設定
        convertButton.setTitle("変換開始", for: .normal)
        convertButton.setTitleColor(UIColor.black, for: .normal)
        convertButton.backgroundColor = UIColor.white
        convertButton.layer.borderColor = UIColor.black.cgColor
        convertButton.layer.borderWidth = 1.0
        convertButton.layer.cornerRadius = 5.0
        convertButton.addTarget(self, action: #selector(self.convertButtonClicked(_:)), for: .touchUpInside)
        convertButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - Setup Gesture
    func setupGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))

        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private Function
    func changeGrade(_ grade: Int) {
        switch grade {
        case 0:
            gradeDescriptionLabel.text = "ひらがなを含むテキストにふりがなを付けます。"
            break
        case 1:
            gradeDescriptionLabel.text = "小学1年生向け。漢字にふりがなを付けます。"
            break
        case 2:
            gradeDescriptionLabel.text = "小学2年生向け。1年生で習う漢字にはふりがなを付けません。"
            break
        case 3:
            gradeDescriptionLabel.text = "小学3年生向け。1～2年生で習う漢字にはふりがを付けません。"
            break
        case 4:
            gradeDescriptionLabel.text = "小学4年生向け。1～3年生で習う漢字にはふりがなを付けません。"
            break
        case 5:
            gradeDescriptionLabel.text = "小学5年生向け。1～4年生で習う漢字にはふりがなを付けません。"
            break
        case 6:
            gradeDescriptionLabel.text = "小学6年生向け。1～5年生で習う漢字にはふりがなを付けません。"
            break
        case 7:
            gradeDescriptionLabel.text = "中学生以上向け。小学校で習う漢字にはふりがなを付けません。"
            break
        case 8:
            gradeDescriptionLabel.text = "一般向け。常用漢字にはふりがなを付けません。"
            break
        default:
            gradeDescriptionLabel.text = "ひらがなを含むテキストにふりがなを付けます。"
            break
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    @objc func sliderValueChanged(_ slider: UISlider) {
        changeGrade(Int(slider.value))
    }
    
    @objc func convertButtonClicked(_ button: UIButton) {
        guard let text = inputTextView.text,
            !inputTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                return
        }
        navigationController?.pushViewController(RCOutputViewController(input: text, output: "I go to school by bus"), animated: true)
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
