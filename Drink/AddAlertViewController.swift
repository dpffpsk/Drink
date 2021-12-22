//
//  AddAlertViewController.swift
//  Drink
//
//  Created by 이니텍 on 2021/12/20.
//

import Foundation
import UIKit

class AddAlertViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //선택된 시간을 부모뷰에 전달하기 위한 클로저
    var pickedDate: ((_ date: Date) -> Void)?
    
    //취소버튼
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //저장버튼
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //클로저 통해 선택된 시간 전달
        
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
