
struct StudentModel {
    
    static let sharedInstance = StudentModel()
    
    var createdAt: String!
    var name: String!
    var lat: Double!
    var long: Double!
    var url: String!
    
    var duplicate = false

}