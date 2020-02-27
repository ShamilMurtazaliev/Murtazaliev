//
//  MainPresenter.swift
//  Murtazaliev
//
//  Created by Murtazaliev Shamil on 27/02/2020.
//  Copyright © 2020 Shamil Murtazaliev. All rights reserved.
//

import Foundation

class MainPresenter {
    
    var view: MainVC!
    var model: MainModel
    
    init(view: MainVC) {
        self.view = view
        self.model = MainModel()
    }
    
    func setTimeTable() {
        model.getTimeTable(url: URL(string: "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1/")!, success: { (result) in
            self.view.creatCell(timeTable: result)
        }) { (failure) in
            print(failure)
        }
    }
}
