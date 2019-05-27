//
//  RCInputViewController.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/24.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import UIKit
import SnapKit

class RCInputViewController: UIViewController, RCGradeListViewDelegate{

    private var grade: Grade = .grade0
    private let titleLabel = UILabel()              //　タイトルLabel
    private let inputTextView = UITextView()        // 入力TextView
    private let gradeChangeButton = UIButton()      // 変換レベル選択ボタン
    private let gradeDescriptionLabel = UILabel()   //　変換レベル説明Label
    private let convertButton = UIButton()          // 変換ボタン

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGesture()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI Setup
    func setupUI() {
        title = "ルビ振りツール"
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(titleLabel)
        view.addSubview(inputTextView)
        view.addSubview(gradeDescriptionLabel)
        view.addSubview(gradeChangeButton)
        view.addSubview(convertButton)
        
        setupTitleLabel()
        setupInputTextView()
        setupGradeDescriptionLabel()
        setupGradeChangeButton()
        setupConvertButton()
    }
    
    // MARK: - Setup UI and Layout
    
    // タイトルLabel設定
    func setupTitleLabel() {
        titleLabel.text = "変換したい文字を入力してください"
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.left.equalToSuperview().offset(20)
            make.bottom.equalTo(inputTextView.snp.top).offset(-10)
        }
    }
    
    // TextView設定
    func setupInputTextView() {
        inputTextView.layer.borderColor = UIColor.gray.cgColor
        inputTextView.layer.borderWidth = 3.0
        inputTextView.layer.cornerRadius = 10.0
        inputTextView.font = UIFont.systemFont(ofSize: 15)
        
        inputTextView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(gradeDescriptionLabel.snp.top).offset(-10)
        }
    }
    
    // 変換レベル説明Label設定
    func setupGradeDescriptionLabel() {
        gradeDescriptionLabel.text = grade.description
        gradeDescriptionLabel.numberOfLines = 0
        
        gradeDescriptionLabel.snp.makeConstraints { (make) in
            make.height.equalTo(70)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(convertButton.snp.top).offset(-10)
        }
    }
    
    // 変換レベル選択ボタン
    func setupGradeChangeButton() {
        gradeChangeButton.setTitle("変換レベル設定", for: .normal)
        gradeChangeButton.setTitleColor(UIColor.black, for: .normal)
        gradeChangeButton.layer.borderColor = UIColor.black.cgColor
        gradeChangeButton.layer.borderWidth = 1.0
        gradeChangeButton.layer.cornerRadius = 5.0
        gradeChangeButton.addTarget(self, action: #selector(self.gradeChangeButtonClicked(_:)), for: .touchUpInside)
        
        gradeChangeButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(gradeDescriptionLabel.snp.right).offset(20)
            make.centerY.equalTo(gradeDescriptionLabel.snp.centerY)
        }
    }
    
    // 変換ボタン設定
    func setupConvertButton() {
        convertButton.setTitle("変換開始", for: .normal)
        convertButton.setTitle("変換中", for: .disabled)
        convertButton.setTitleColor(UIColor.black, for: .normal)
        convertButton.backgroundColor = UIColor.white
        convertButton.layer.borderColor = UIColor.black.cgColor
        convertButton.layer.borderWidth = 1.0
        convertButton.layer.cornerRadius = 5.0
        convertButton.addTarget(self, action: #selector(self.convertButtonClicked(_:)), for: .touchUpInside)
        
        convertButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
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
    
    // MARK: - IBAction
    @objc func gradeChangeButtonClicked(_ button: UIButton) {
        let gradeListViewController = RCGradeListViewController()
        gradeListViewController.delegate = self
        navigationController?.pushViewController(gradeListViewController, animated: true)
    }
    
    @objc func convertButtonClicked(_ button: UIButton) {
        guard let text = inputTextView.text,
            !inputTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                let alert = UIAlertController.init(title: "エラー",
                                                   message:"文字を入力してください",
                                                   preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                return
        }
        
        convertButton.isEnabled = false
        RCAPIClient.init(sentence: text, grade: grade.rawValue).requestForRubyConvert { [weak self] (result) in
            switch result {
            case .success(let rcObj):
                self?.navigationController?.pushViewController(RCOutputViewController(input: text, output: rcObj.getRubySentence()), animated: true)

            case .failure(let error):
                let alert = UIAlertController.init(title: "エラー",
                                                   message:(error as! NetworkError).rawValue,
                                                   preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            self?.convertButton.isEnabled = true
        }
    }
    
    func gradeListView(_ listView:RCGradeListViewController, didSelectGrade grade: Grade) {
        self.grade = grade
        gradeDescriptionLabel.text = grade.description
    }
}
