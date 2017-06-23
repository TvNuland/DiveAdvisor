//
//  ExtensionDetailTableViewController.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 20/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit



extension DetailTableViewController {


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "reuseID", for: indexPath)
        switch indexPath.row {
            
        case detailRows.imageSliderRow.rawValue:
            print("image slider")
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath) as! DetailmageSliderCell
            
            imageCell.awakeFromNib()
            imageCell.siteDetail = siteDetailObject
            imageCell.separatorInset.left = view.frame.width
            
            return imageCell
            
            
            
        case detailRows.descriptionRow.rawValue:
            print("description")
            return cell
        
        case detailRows.weatherRow.rawValue:
            print("weather")
            return cell
        
        default:
            print("default")
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
