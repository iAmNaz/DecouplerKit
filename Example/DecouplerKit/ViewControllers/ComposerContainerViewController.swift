//
//  ComposerContainerViewController.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import DecouplerKit

class ComposerContainerViewController: UIViewController {
    var registry: ResponderRegistry!
    var session: ExerciseSessionViewModel!
    
    fileprivate var childVC: ExerciseComposerTableViewController!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!

    @IBAction func saveAction(_ sender: Any) {
        childVC.saveSession()
        dismissMe()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismissMe()
    }
    
    func dismissMe() {
        dismiss(animated: true) {}
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editorContainer" {
            childVC = segue.destination as? ExerciseComposerTableViewController
            childVC.saveBtn = saveBtn
            childVC.session = session
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
