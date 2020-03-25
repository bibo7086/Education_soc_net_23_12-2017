//
//  GradeTableViewController.swift
//  social_project
//
//  Created by Saeed Ali on 1/19/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import UIKit

class GradeTableViewController: UITableViewController {
    
    static let getGradesPath = "/course/getGrades/"
    static let cellIdentifier = "GradeTableViewCell"
    
    @IBOutlet weak var totalWeight: UILabel!
    
    @IBOutlet weak var totalGradeLabel: UILabel!
    
    var Grades: [Grade] = []    // An array of grades
    var courseDetails: Courses! //contains course_id and course_id
    var gradaref: Int!
    var totalGrade: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGrades()
        //tableView.tableFooterView = UIView()
        
    }
    
    // Mark: - get all grades if any
    
    func fetchGrades(){
        let page_id = String(describing: courseDetails.page_id!)
        let URLParams = ["page_id": page_id]
        
        let _ = ProfileViewController.sharedWebClient.load(path: GradeTableViewController.getGradesPath, method: .get, params: URLParams){(data, error) in
            
            /* GUARD: was there an error */
            guard (error == nil) else {
                print(error?.errorDescription! as Any)
                return
            }
            
            guard let grades = data?["grades"] as? NSDictionary else {
                print("There was an error getting the grades")
                return
            }
            
            guard let arraygrades = grades["grades"] as? NSArray else {
                print("There was an error parsing the grades dictionary")
                return
            }
            
            guard let total = grades["total"] as? NSDictionary else {
                print("couldnt get the total grades")
                self.tableView.tableFooterView = UIView()
                return
            }
            
            
            guard let grade_ref = total["grade_reference"] as? Int else {
                print("I couldnt get the reference grade")
                return
            }
            guard let total_grade = total["grade"] as? Int else {
                print("I couldnt get the reference grade")
                return
            }
            
            self.gradaref = grade_ref
            self.totalGrade = total_grade
            
            self.Grades = Grade.modelsFromDictionaryArray(array: arraygrades as NSArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if (self.gradaref != nil){
                    self.totalWeight.text = String(self.gradaref) + "%"
                    self.totalGradeLabel.text = String(self.totalGrade)
                }
            }
            
            
            
            
            
            
            
            
            
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Grades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: GradeTableViewController.cellIdentifier, for: indexPath) as! GradeTableViewCell
        
        
        cell.titleLabel.text = Grades[indexPath.row].grade_title
        cell.gradeLabel.text = Grades[indexPath.row].grade
        cell.weightLabel.text = Grades[indexPath.row].grade_reference! + "%"
        
        
        return cell
        
        
    }
    
    
    
}
