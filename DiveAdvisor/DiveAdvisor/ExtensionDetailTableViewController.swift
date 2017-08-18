//
//  ExtensionDetailTableViewController.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 20/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit



extension DetailTableViewController: UITextViewDelegate{


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section { //NEED TO HAVE SECTIONS TO HAVE VARYING CELL HEIGHTS
            
        case detailRows.imageSliderRow.rawValue:
            print("image slider")
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            imageCell.siteDetail = siteDetailObject
            imageCell.separatorInset.left = view.frame.width
            
            return imageCell
            
            
            
        case detailRows.descriptionRow.rawValue:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            
            // must delegate back to view controller so it can auto resize
            descriptionCell.DescriptionTextView.delegate = self
            
            //test encode html
            let text = siteDetailObject?.description
            let str = text?.replacingOccurrences(of: "<[^]>]+>", with: "", options: .regularExpression, range: nil)
            
            descriptionCell.DescriptionTextView.text = str
            
            return descriptionCell
        
        default: //weather cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCellID", for: indexPath) as! WeatherCell
            cell.awakeFromNib()

            if let detailWeatherObject = detailWeatherObject {
                cell.setValuesOnWeatherInfo(detailWeatherObject: detailWeatherObject)
            }
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case detailRows.imageSliderRow.rawValue:
            if siteDetailObject?.imageUrls == nil {
                return 0
            } else {
                return view.percentage(type: .height, with: 40)
            }
        case detailRows.descriptionRow.rawValue:
            return UITableViewAutomaticDimension
        default:
            return view.percentage(type: .height, with: 40)
        }
    }

}


enum CalculationType {
    case height
    case width
}

extension UIView {
    func percentage(type: CalculationType, with percentage: CGFloat) -> CGFloat {
        
        if type == .height {
            return percentage * self.frame.height/100
        } else {
            return percentage * self.frame.width/100
        }
    }
}
