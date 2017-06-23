//
//  InfoCell.swift
//  OMDB
//
//  Created by Ivo  Nederlof on 31-01-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    /*
     N 348.75 - 11.25
     
     NNE 11.25 - 33.75
     
     NE 33.75 - 56.25
     
     ENE 56.25 - 78.75
     
     E 78.75 - 101.25
     
     ESE 101.25 - 123.75
     
     SE 123.75 - 146.25
     
     SSE 146.25 - 168.75
     
     S 168.75 - 191.25
     
     SSW 191.25 - 213.75
     
     SW 213.75 - 236.25
     
     WSW 236.25 - 258.75
     
     W 258.75 - 281.25
     
     WNW 281.25 - 303.75
     
     NW 303.75 - 326.25
     
     NNW 326.25 - 348.75
 */
    enum windDirection: String {
        case N
        case NNE
        case NE
        case ENE
        case E
        case ESE
        case SE
        case SSE
        case S
        case SSW
        case WSW
        case W
        case WNW
        case NW
        case NNW
    }
    
    //weather values
    @IBOutlet var airTempTitle: UILabel!
    @IBOutlet var airTempValue: UILabel!
    
    @IBOutlet var waterTempTitle: UILabel!
    @IBOutlet var waterTempValue: UILabel!
    
    @IBOutlet var waveHeightTitle: UILabel!
    @IBOutlet var waveHeightValue: UILabel!
    
    @IBOutlet var windspeedTitle: UILabel!
    @IBOutlet var windspeedValue: UILabel!
    
    //weather images
    @IBOutlet weak var airTempImage: UIImageView?
    @IBOutlet weak var waterTempImage: UIImageView?
    @IBOutlet weak var waveHeightImage: UIImageView?
    @IBOutlet weak var windSpeedImage: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesOnWeatherInfo(detailWeatherObject: Hourly) {
        var locale = NSLocale.current
        if locale.usesMetricSystem {
            if let tempC = detailWeatherObject.tempC {
                airTempTitle.text = "Temp C"
                airTempValue.text = tempC
            }
            
            if let waterTempC = detailWeatherObject.waterTemp_C {
                waterTempTitle.text = "WaterTemp C"
                waterTempValue.text = waterTempC
            }
            
            if let swellHeight_m = detailWeatherObject.swellHeight_m {
                waveHeightTitle.text = "Wave Height m"
                waveHeightValue.text = swellHeight_m
            }
            
            if let windspeedKmph = detailWeatherObject.windspeedKmph {
                windspeedTitle.text = "Wind Speed Kmph"
                windspeedValue.text = windspeedKmph
            }
            
        } else {
            
            if let tempF = detailWeatherObject.tempF {
                airTempTitle.text = "Temp F"
                airTempValue.text = detailWeatherObject.tempF
            }
            
            if let waterTemp_F = detailWeatherObject.waterTemp_F {
                waterTempTitle.text = "WaterTemp F"
                waterTempTitle.text = waterTemp_F
            }
            
            if let swellHeight_ft = detailWeatherObject.swellHeight_ft {
                waveHeightTitle.text = "Wave Height ft"
                waveHeightTitle.text = swellHeight_ft
            }
            if let windspeedMiles = detailWeatherObject.windspeedMiles {
                windspeedTitle.text = "Wind Speed Mph"
                windspeedTitle.text = windspeedMiles
            }
        }
        imageForWeather(detailWeatherObject: detailWeatherObject)
    }
    
    func imageForWeather(detailWeatherObject: Hourly) {
        let windDirectionString = detailWeatherObject.winddir16Point
        let direction = windDirection(rawValue: windDirectionString!)
        windSpeedImage?.image = UIImage.init(named: "windDirectionNorth")

        if let waterTemp = Double(detailWeatherObject.waterTemp_C!) {
            if waterTemp <= 23.0 {
                waterTempImage?.image = #imageLiteral(resourceName: "waterTempCold")
            } else {
                waterTempImage?.image = #imageLiteral(resourceName: "waterTempWarm")
            }
        }
        
        if let waterTemp = Double(detailWeatherObject.tempC!) {
            if waterTemp <= 10.0 {
                airTempImage?.image = #imageLiteral(resourceName: "waterTempCold")
            } else {
                airTempImage?.image = #imageLiteral(resourceName: "waterTempWarm")
            }
        }

        if let swellFt = Double(detailWeatherObject.swellHeight_ft!) {
            if swellFt >= 3.0 {
                waveHeightImage?.image = UIImage.init(named: "waveHeightLarge")
            } else {
                waveHeightImage?.image = UIImage.init(named: "waveHeightSmall")
            }
        }
        
        
//        switch direction {
//        case windDirection.v: // , windDirection.NE ,windDirection.NNE, windDirection.NNW:
//                windSpeedImage?.image = UIImage.init(named: "windDirectionNorth")
//            break
//        case windDirection.E: // , windDirection.ENE ,windDirection.ESE:
//                windSpeedImage?.image = UIImage.init(named: "windDirectionEast")
//            break
//            case windDirection.S:
//                windSpeedImage?.image = UIImage.init(named: "windDirectionSouth")
//            break
//            case windDirection.W:
//                windSpeedImage?.image = UIImage.init(named: "windDirectionWest")
//            break
//        default :
//            break
//        }
    }
    
}
