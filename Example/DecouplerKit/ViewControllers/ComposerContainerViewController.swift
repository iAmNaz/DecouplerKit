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
        dismiss(animated: true) {
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editorContainer" {
            childVC = segue.destination as! ExerciseComposerTableViewController
            childVC.saveBtn = saveBtn
            childVC.session = session
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
