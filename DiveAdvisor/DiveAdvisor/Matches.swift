/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 import MapKit
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Matches {
	public var currents : String?
	public var distance : String?
	public var hazards : String?
	public var lat : String?
	public var name : String?
	public var water : String?
	public var marinelife : String?
	public var description : String?
	public var maxdepth : String?
	public var mindepth : String?
	public var predive : String?
	public var id : String?
	public var equipment : String?
	public var lng : String?
    public var ocean : String?
    public var country : String?
    public var mapItem: MKMapItem?
/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let matches_list = Matches.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Matches Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Matches]
    {
        var models:[Matches] = []
        for item in array
        {
            models.append(Matches(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let matches = Matches(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Matches Instance.
*/
	required public init?(dictionary: NSDictionary) {

		currents = dictionary["currents"] as? String
		distance = dictionary["distance"] as? String
		hazards = dictionary["hazards"] as? String
		lat = dictionary["lat"] as? String
		name = dictionary["name"] as? String
		water = dictionary["water"] as? String
		marinelife = dictionary["marinelife"] as? String
		description = dictionary["description"] as? String
		maxdepth = dictionary["maxdepth"] as? String
		mindepth = dictionary["mindepth"] as? String
		predive = dictionary["predive"] as? String
		id = dictionary["id"] as? String
		equipment = dictionary["equipment"] as? String
		lng = dictionary["lng"] as? String
        
        mapItem = makeMapItem(lat: lat, lng: lng)

	}

    private func makeMapItem(lat: String?, lng: String?) -> MKMapItem? {
        if let lat = Double(lat!),
            let lng = Double(lng!) {
            let sourceLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            sourceMapItem.name = self.name
            return sourceMapItem
        } else {
            return nil
        }
    }
		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.currents, forKey: "currents")
		dictionary.setValue(self.distance, forKey: "distance")
		dictionary.setValue(self.hazards, forKey: "hazards")
		dictionary.setValue(self.lat, forKey: "lat")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.water, forKey: "water")
		dictionary.setValue(self.marinelife, forKey: "marinelife")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.maxdepth, forKey: "maxdepth")
		dictionary.setValue(self.mindepth, forKey: "mindepth")
		dictionary.setValue(self.predive, forKey: "predive")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.equipment, forKey: "equipment")
		dictionary.setValue(self.lng, forKey: "lng")

		return dictionary
	}

}
