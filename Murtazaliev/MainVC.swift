//
//  MainVC.swift
//  Murtazaliev
//
//  Created by Murtazaliev Shamil on 27/02/2020.
//  Copyright © 2020 Shamil Murtazaliev. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cells: [Any] = []
    var timeTable: [TimeTable] = []
    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = MainPresenter(view: self)
        presenter.setTimeTable()
    }
    
    func creatCell(timeTable: [TimeTable]) {
        
        var day = 0
                
        self.timeTable = timeTable.sorted { (r1, r2) -> Bool in
            if r1.weekDay < r2.weekDay  {
                return true
            } else {
                return false
            }
        }
        
        self.timeTable.forEach { (item) in
            if item.weekDay == day {
                cells.append(item)
            } else {
                switch item.weekDay {
                case 1:
                    cells.append(Day(title: "Понедельник"))
                case 2:
                    cells.append(Day(title: "Вторник"))
                case 3:
                    cells.append(Day(title: "Среда"))
                case 4:
                    cells.append(Day(title: "Четверг"))
                case 5:
                    cells.append(Day(title: "Пятница"))
                case 6:
                    cells.append(Day(title: "Суббота"))
                case 7:
                    cells.append(Day(title: "Воскресенье"))
                default:
                    cells.append(Day(title: "Понедельник"))
                }
                cells.append(item)
                day = item.weekDay
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (cells[indexPath.row] as? TimeTable) != nil {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TimetableTVCell
            let item = cells[indexPath.row] as! TimeTable
            
            cell.titleLabel.text = item.name
            cell.descriptionLabel.text = item.description
            cell.nameLabel.text = item.teacher
            cell.timeLabel.text = "\(item.startTime) - \(item.endTime)"
            cell.locationLabel.text = item.place
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell") as! DayTVCell
            let item = cells[indexPath.row] as! Day

            cell.dayTitleLabel.text = item.title
            return cell
        }
    }
    
}

struct Day {
    var title: String
}
