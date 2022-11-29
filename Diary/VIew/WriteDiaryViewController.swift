//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 1 on 2022/11/29.
//

import UIKit

class WriteDiaryViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var confirmButton: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    private func configureContentsTextView() {
    }
    
    private func configureDatePicker() {
        
    }
}
