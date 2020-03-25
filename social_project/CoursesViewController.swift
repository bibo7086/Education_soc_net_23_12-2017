//
//  CoursesViewController.swift
//  social_project
//
//  Created by Saeed Ali on 12/21/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var CourseTableView: UITableView!
    
    
    var studentProfile: Records!
    var myCourses:[Courses] = []
    static let cellIdentifier = "CourseCell"
    
    override func viewDidAppear(_ animated: Bool) {
        myCourses = studentProfile.courses!
        CourseTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.22, blue: 0.47, alpha: 1.00)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let tbvc = self.tabBarController as! TabBarViewController!
        studentProfile = tbvc?.studentProfile
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CoursesToCoursePage" {
            let destVC = segue.destination as! CoursePageViewController
                destVC.courseDetail = sender as? Courses
                destVC.studentProfile = studentProfile
        }
    }
    
    
    
    
}


extension CoursesViewController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CoursesToCoursePage", sender: myCourses[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCourses.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CourseTableView.dequeueReusableCell(withIdentifier: CoursesViewController.cellIdentifier, for: indexPath) as! CourseTableViewCell
        
        cell.courseNameLabel?.text = myCourses[indexPath.row].name
        cell.courseCodeLabel?.text = myCourses[indexPath.row].code
        cell.instructorsNameLabel?.text = myCourses[indexPath.row].instructor?.fullName()
        
        
        
        
        return cell
    }
    
}
