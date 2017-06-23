//
//  DetailTableViewController.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 15/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit

enum detailRows: Int {
    case imageSliderRow = 0
    case descriptionRow = 1
    case weatherRow = 2
    case detailRow = 3
    case reviewRow = 4
    
    func positionAsInteger() -> Int {
        switch self {
        case .imageSliderRow:
            return 0
        case .descriptionRow:
            return 1
        case .weatherRow:
            return 2
        case .detailRow:
            return 3
        case .reviewRow:
            return 4
        }
    }
}

class DetailTableViewController: UITableViewController {

    var detailWeatherObject: Hourly?
    var siteDetailObject: SiteDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
        
        let imageCell = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        self.tableView.register(imageCell, forCellReuseIdentifier: "detailImageCellID")
        
        let descriptionTableViewNib = UINib(nibName: "DescriptionTableViewCell", bundle:  nil)
        self.tableView.register(descriptionTableViewNib, forCellReuseIdentifier: "descriptionTableViewCell")
        
        let weatherCell = UINib(nibName: "WeatherCell", bundle:nil)
        self.tableView.register(weatherCell, forCellReuseIdentifier: "WeatherCellID")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.tableView.reloadData()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    deinit {
//        print("denit")
//    }

}
