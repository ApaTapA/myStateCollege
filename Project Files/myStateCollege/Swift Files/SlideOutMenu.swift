//
//  SlideOutMenu.swift
//  myStateCollege
//
//  Created by Thomas Diffendal on 1/7/18.
//  Copyright © 2018 ApaTapA. All rights reserved.
//

import UIKit
//import FirebaseDatabase

class SlideCustomCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var slideOutIcon: UIImageView!
}

class SlideOutMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sideMenuOptions = ["Academics", "Campus Dining", "Campus Information", "Campus News & Events", "Campus Police" ,"Greeklife", "Nightlife" , "Parking & Transportation", "Sports & Fitness", "Student Health", "", "Feedback", "Help"]
    
    let sideMenuImages = ["academic_icon", "campus_dining_icon", "campus_information_icon", "campus_news_and_events_icon", "campus_police_icon", "greek_life_icon","nightlife_icon", "parking_and_transportation_icon", "sports_and_fitness_icon", "student_health_icon", "" , "feedback_icon", "help_icon"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sideMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 10)
        {
            return 1
        }
        else
        {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SlideCustomCell
        
          cell.titleLabel.text = sideMenuOptions[indexPath.row]
          cell.slideOutIcon.image = UIImage(named: (sideMenuImages[indexPath.row]+".png"))
        
        
        if (indexPath.row == 10 || indexPath.row == 14)
        {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (indexPath.row <= 9)
        {
            self.performSegue(withIdentifier: "openCategory", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = tableView.indexPathForSelectedRow
        {
            if indexPath.row == 0
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Academic"
            }
            else if indexPath.row == 1
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Campus Dining"
            }
            else if indexPath.row == 2
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Campus Information"
            }
            else if indexPath.row == 3
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Campus News & Events"
            }
            else if indexPath.row == 4
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Campus Police"
            }
            else if indexPath.row == 5
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Greeklife"
            }
            else if indexPath.row == 6
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Nightlife"
            }
            else if indexPath.row == 7
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Parking & Transportation"
            }
            else if indexPath.row == 8
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Sports & Fitness"
            }
            else if indexPath.row == 9
            {
                let nav = segue.destination as! UINavigationController
                let sceneryController = nav.topViewController as! CategoryTVC
                sceneryController.navigationItem.title = "Student Health"
            }
        }
    }

}
