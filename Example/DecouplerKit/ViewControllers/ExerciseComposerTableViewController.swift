//
//  ExerciseComposerTableViewController.swift
//  
//
//  Created by Nazario Mariano on 07/06/2018.
//

import UIKit
import DecouplerKit

class ExerciseComposerTableViewController: UITableViewController {
    @IBOutlet weak var exerciseNameTf: UITextField!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBAction func editingChangedName(_ sender: UITextField) {
        session?.name = sender.text
        sessionChanged()
    }
    
    var registry: ResponderRegistry!
    weak var parentVC: UIViewController!
    weak var saveBtn: UIBarButtonItem!
    var dateFormatter = DateFormatter()
    var session: ExerciseSessionViewModel?
    var isNew = true
    
    var duration: Date! {
        didSet {
            session?.duration = duration
            sessionChanged()
            setDurationLabel()
        }
    }
    var date: Date! {
        didSet {
            session?.date = date
            sessionChanged()
            setDateLabel()
        }
    }
    
    func setDateLabel() {
        dateLbl.text = dateFormatter.string(from: date)
    }
    
    func setDurationLabel() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: duration)
        if let hr = components.hour, let min = components.minute{
            durationLbl.text = "\(hr) hrs \(min) mins"
        }
    }
    
    func sessionChanged() {
        let validationRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        registry.tx(request: validationRequest).done { response in
            self.saveBtn.isEnabled = true
        }.catch { (error) in
            self.saveBtn.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DateViewController
            vc.composerVC = self
        
        if segue.identifier == "toDatePicker" {
            vc.durationPicker = false
        }else{
            vc.durationPicker = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .medium
        clearsSelectionOnViewWillAppear = false
        
        if session != nil {
            isNew = false
            exerciseNameTf.text = session?.name
            durationLbl.text = session?.formattedDuration()
            dateLbl.text = session?.formattedDate()
            sessionChanged()
        }else {
            session = ExerciseSessionViewModel(dateFormatter: dateFormatter, name: nil, date: date, duration: nil)
            date = Date()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parentVC = self.presentingViewController
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func saveSession() {
        var action: Task!
        if isNew {
            action = Task.Exercise(.add)
        }else{
            action = Task.Exercise(.edit)
        }
        
        let saveRequest = Request(proc: action, body: session)
        registry.tx(request: saveRequest).done { (response) in
            self.parentVC.dismiss(animated: true, completion: nil)
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }
}
