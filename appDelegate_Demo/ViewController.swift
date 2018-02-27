//
//  ViewController.swift
//  appDelegate_Demo
//
//  Created by Faisal Alkhotaifi on 2/25/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
//    let names = arrayOfPeoplesName().names
    var pickedName: [PersonName] = []
    var name: PersonName? = nil
    
    //Reference to app delegate
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    //Refence to context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
           pickedName = try context.fetch(PersonName.fetchRequest())
            tableView.reloadData()
        }catch let error{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickedName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let name = pickedName[indexPath.row]
        if let name = name.name{
            cell.textLabel?.text = name
        }
        
        return cell
    }

    @IBAction func addName(_ sender: Any) {
        let names = arrayOfPeoplesName()
        let arrayOfnames = names.names
        let randomIndex = Int(arc4random_uniform(UInt32(arrayOfnames.count)))
        //pickedName.append(arrayOfNames[randomIndex])
        name = PersonName(entity: PersonName.entity(), insertInto: context)
        if let name = name{
            name.name = arrayOfnames[randomIndex]
            pickedName.append(name)
        }
        tableView.reloadData()
        
        appDelegate.saveContext()
    }
    
    @IBAction func sendNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.body = "Notification sent successfully!"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}

