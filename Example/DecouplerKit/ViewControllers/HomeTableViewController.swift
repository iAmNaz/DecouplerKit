//
//  HomeTableViewController.swift
//  
//
//  Created by Nazario Mariano on 07/06/2018.
//

import UIKit
import DecouplerKit
import PromiseKit
class HomeTableViewController: UITableViewController {
    var registry: ResponderRegistry!
    fileprivate var sessions = [ExerciseSessionViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = Request(proc: Task.Exercise(.list))
        
        firstly {
            registry.tx(request: request)
        }.done { response in
            self.sessions = response.body()
            self.tableView.reloadData()
        }.catch { (error) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSessionDetail" {
            let vc = segue.destination as! ComposerContainerViewController
            let selectedIndex = tableView.indexPathForSelectedRow
            vc.session = sessions[(selectedIndex?.row)!]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sessions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let session = sessions[indexPath.row]
        cell.textLabel?.text = session.formattedDate()
        cell.detailTextLabel?.text = session.name
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ex = self.sessions[indexPath.row]
            deleteRow(exercise: ex)
            sessions.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }   
    }
    
    fileprivate func deleteRow(exercise: ExerciseSessionViewModel) {
        let deleteRequest = Request(proc: Task.Exercise(.delete), body: exercise)
        registry.tx(request: deleteRequest).done { (response) in
            let _  = response
        }
    }
}
