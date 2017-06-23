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
            if let detailWeatherObject = detailWeatherObject {
                cell.setValuesOnWeatherInfo(detailWeatherObject: detailWeatherObject)
            }
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case detailRows.imageSliderRow.rawValue:
            return 200
        default:
            return UITableViewAutomaticDimension
        }
    }

}



/*
 public var tempC : String?
 public var tempF : String?
 public var windspeedMiles : String?
 public var windspeedKmph : String?
 public var winddir16Point : String?
 public var weatherIconUrl : Array<WeatherIconUrl>?
 public var swellHeight_m : String?
 public var swellHeight_ft : String?
 public var waterTemp_C : String?
 public var waterTemp_F : String?
 */


/*
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //enums for each case (e.g. 0, 1, 2, ...)
    switch indexPath.row {
    case detailRows.imageRow.rawValue:
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCellID", for: indexPath) as! ImageCell
        
        cell.delegate = self
        
        if let urlString = detailMovieObject?.poster {
            let url = URL(string: urlString)
            cell.fullImage.kf.setImage(with: url)
        }
        
        if let ratings = self.detailMovieObject?.imdbRating {
            cell.votes.text = "\(ratings)"
        }
        
        if let urlString = detailMovieObject?.poster {
            let url = URL(string: urlString)
            cell.profileMovie.kf.setImage(with: url)
        }
        
        //cell.isUserInteractionEnabled = false
        cell.imdbIco.image = #imageLiteral(resourceName: "imdb-2-icon")
        
        return cell
        
        
    case detailRows.plotRow.rawValue:
        let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
        cell.moviePlot.text = self.detailMovieObject?.plot
        
        return cell
*/
