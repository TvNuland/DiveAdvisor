/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class SiteDetail {
	public var newer_version : String?
	public var currents : String?
	public var lat : String?
	public var marinelife : String?
	public var rating : String?
	public var maxdepth : String?
	public var mindepth : String?
	public var created_on : String?
	public var id : String?
	public var lng : String?
	public var votes : String?
	public var hazards : String?
	public var name : String?
	public var description : String?
	public var water : String?
	public var predive : String?
	public var equipment : String?
	public var created_by : String?
    public var urls:[Urls]?
    public var weblink: String?
/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let site_list = Site.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Site Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [SiteDetail]
    {
        var models:[SiteDetail] = []
        for item in array
        {
            models.append(SiteDetail(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let site = Site(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Site Instance.
*/
	required public init?(dictionary: NSDictionary) {

		newer_version = dictionary["newer_version"] as? String
		currents = dictionary["currents"] as? String
		lat = dictionary["lat"] as? String
		marinelife = dictionary["marinelife"] as? String
		rating = dictionary["rating"] as? String
		maxdepth = dictionary["maxdepth"] as? String
		mindepth = dictionary["mindepth"] as? String
		created_on = dictionary["created_on"] as? String
		id = dictionary["id"] as? String
		lng = dictionary["lng"] as? String
		votes = dictionary["votes"] as? String
		hazards = dictionary["hazards"] as? String
		name = dictionary["name"] as? String
		description = dictionary["description"] as? String
		water = dictionary["water"] as? String
		predive = dictionary["predive"] as? String
		equipment = dictionary["equipment"] as? String
		created_by = dictionary["created_by"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.newer_version, forKey: "newer_version")
		dictionary.setValue(self.currents, forKey: "currents")
		dictionary.setValue(self.lat, forKey: "lat")
		dictionary.setValue(self.marinelife, forKey: "marinelife")
		dictionary.setValue(self.rating, forKey: "rating")
		dictionary.setValue(self.maxdepth, forKey: "maxdepth")
		dictionary.setValue(self.mindepth, forKey: "mindepth")
		dictionary.setValue(self.created_on, forKey: "created_on")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.lng, forKey: "lng")
		dictionary.setValue(self.votes, forKey: "votes")
		dictionary.setValue(self.hazards, forKey: "hazards")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.water, forKey: "water")
		dictionary.setValue(self.predive, forKey: "predive")
		dictionary.setValue(self.equipment, forKey: "equipment")
		dictionary.setValue(self.created_by, forKey: "created_by")

		return dictionary
	}

}
