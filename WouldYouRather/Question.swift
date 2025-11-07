import Foundation

struct Question: Identifiable, Codable, Equatable {
    let id: UUID
    let optionA: String
    let optionB: String
    var responseA: Int
    var responseB: Int
    var hasBeenAsked: Bool
    
    init(id: UUID = UUID(), optionA: String, optionB: String, responseA: Int = 0, responseB: Int = 0, hasBeenAsked: Bool = false) {
        self.id = id
        self.optionA = optionA
        self.optionB = optionB
        self.responseA = responseA
        self.responseB = responseB
        self.hasBeenAsked = hasBeenAsked
    }
    
    var totalResponses: Int {
        responseA + responseB
    }
    
    var percentageA: Double {
        guard totalResponses > 0 else { return 0 }
        return Double(responseA) / Double(totalResponses) * 100
    }
    
    var percentageB: Double {
        guard totalResponses > 0 else { return 0 }
        return Double(responseB) / Double(totalResponses) * 100
    }
}

struct UserResponse: Identifiable, Codable {
    let id: UUID
    let questionId: UUID
    let selectedOption: String
    let timestamp: Date
    
    init(id: UUID = UUID(), questionId: UUID, selectedOption: String, timestamp: Date = Date()) {
        self.id = id
        self.questionId = questionId
        self.selectedOption = selectedOption
        self.timestamp = timestamp
    }
}
