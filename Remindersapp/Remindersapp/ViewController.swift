//
//  ViewController.swift
//  Remindersapp
//
//  Created by Fizza Usman on 12/11/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var messageTF: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //manages notification related activities for your app
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.alert, .sound])
        { (permissionGranted, error) in
            if (!permissionGranted)
            {
                print("Permission Denied")
            }
        }
    }

    @IBAction func scheduleAction(_ sender: Any) {
        notificationCenter.getNotificationSettings{(settings) in
            
            DispatchQueue.main.async{
                
                let title = self.titleTF.text!
                let message = self.messageTF.text!
                let date = self.datePicker.date
                
                if(settings.authorizationStatus == .authorized)
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year,.month, .day, .hour, .minute], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { (error) in
                        if (error != nil)
                        {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                    let ac = UIAlertController(title: "Notification is Scheduled", message: "At " + self.formattedDate(date: date), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler:{(_) in }))
                    self.present(ac, animated: true)
                    }

                else
                {
                    let ac = UIAlertController(title: "Enable Notifications ?", message: "To use this feature you must enable notifications in the control center " + self.formattedDate(date: date), preferredStyle: .alert)
                    
                    let go2Settings = UIAlertAction(title:"Settings", style: .default)
                    {(_) in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else {
                            return
                        }
                        if (UIApplication.shared.canOpenURL(settingsURL))
                        {
                            UIApplication.shared.open(settingsURL) {
                                (_) in
                            }
                        }
                    }
                    ac.addAction(go2Settings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler:{(_) in }))
                    self.present(ac, animated: true)
                }
                }
            }
        }
        
        func formattedDate(date:Date) -> String{
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y HH:mm"
            return formatter.string(from: date)
            
        }
        
    }
