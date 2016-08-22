
struct StudentModel {
    
    static var collection = [StudentModel]()
    
    var createdAt: String!
    
    var first: String!
    var last: String!
    var lat: Double!
    var long: Double!
    var url: String!
    
    init(dictionary: [String: AnyObject]){
        self.createdAt = dictionary["updatedAt"] as! String
        self.first = dictionary["firstName"] as! String!
        self.last = dictionary["lastName"] as! String!
        self.lat = dictionary["latitude"] as! Double!
        self.long = dictionary["longitude"] as! Double!
        self.url = dictionary["mediaURL"] as! String!
    }
    
    
}