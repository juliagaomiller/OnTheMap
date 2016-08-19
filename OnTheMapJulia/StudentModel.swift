
class StudentModel {
    
    static let sharedInstance = StudentModel()
    
    var studentArray = [studentInformation]()
    
    var studentInfo: studentInformation!
    
    struct studentInformation {
        var createdAt: String!
        var name: String!
        var lat: Double!
        var long: Double!
        var url: String!
        
        init(date: String!, name: String!, lat: Double!, long: Double!, url: String!){
            self.createdAt = date
            self.name = name
            self.lat = lat
            self.long = long
            self.url = url
        }
    }
}