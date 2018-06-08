//
//  DateViewController.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    weak var composerVC: ExerciseComposerTableViewController!
    
    var durationPicker: Bool!
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {

    }
    
    @IBAction func saveAction(_ sender: Any) {
        if datePickerView.datePickerMode == .dateAndTime {
            composerVC.date = datePickerView.date
        }else{
            composerVC.duration = datePickerView.date
        }
        dismissMe()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismissMe()
    }
    
    func dismissMe() {
        dismiss(animated: true) {
            
            print(self.datePickerView.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if durationPicker {
            datePickerView.datePickerMode = .countDownTimer
        }else{
            datePickerView.datePickerMode = .dateAndTime
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
