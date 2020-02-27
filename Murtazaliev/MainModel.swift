//
//  MainModel.swift
//  Murtazaliev
//
//  Created by Murtazaliev Shamil on 27/02/2020.
//  Copyright © 2020 Shamil Murtazaliev. All rights reserved.
//

import Foundation
import Alamofire
import CoreData


struct TimeTable: Decodable {
    var name: String
    var description: String
    var place: String
    var teacher: String
    var startTime: String
    var endTime: String
    var weekDay: Int
}

class MainModel {
    
    var timeTable: [TimeTable] = []
    
    func getTimeTable(url: URL, success: @escaping ([TimeTable]) -> Void, failure: @escaping (String) -> Void) {
        request(url).responseData { (response) in
                        
            do  {
                let result = try JSONDecoder().decode([TimeTable].self, from: response.data!)
                result.forEach { (item) in
                    self.saveName(timeTableItem: item)
                }
                
                success(result)
            } catch {
                
                let appDelegate =
                  UIApplication.shared.delegate as! AppDelegate
                
                let managedContext = appDelegate.persistentContainer.viewContext

                let fetchedResults = try!
                    managedContext.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: "TimeTableItem")) as? [NSManagedObject]
                                                
                fetchedResults?.forEach({ (item) in
                    
                    self.timeTable.append(TimeTable(name: item.value(forKey: "name") as! String, description: item.value(forKey: "descriptionTimeTable") as! String, place: item.value(forKey: "place") as! String, teacher: item.value(forKey: "teacher") as! String, startTime: item.value(forKey: "startTime") as! String, endTime: item.value(forKey: "endTime") as! String, weekDay: (item.value(forKey: "weekDayTimeTable") as! NSString).integerValue))
                })
                
                if self.timeTable != nil {
                    success(self.timeTable as! [TimeTable])
                } else {
                    failure("Error")
                }
            }
        }
    }
    
    func saveName(timeTableItem: TimeTable) {
      let appDelegate =
        UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
     
        let entity =  NSEntityDescription.entity(forEntityName: "TimeTableItem",
                                                 in:
        managedContext)
             
      let timeTable = NSManagedObject(entity: entity!,
                                   insertInto:managedContext)
     
        timeTable.setValue(timeTableItem.name, forKey: "name")
        timeTable.setValue(timeTableItem.description, forKey: "descriptionTimeTable")
        timeTable.setValue(timeTableItem.teacher, forKey: "teacher")
        timeTable.setValue(timeTableItem.startTime, forKey: "startTime")
        timeTable.setValue(timeTableItem.endTime, forKey: "endTime")
        timeTable.setValue(timeTableItem.place, forKey: "place")
        timeTable.setValue(String(timeTableItem.weekDay), forKey: "weekDayTimeTable")
    }
}
