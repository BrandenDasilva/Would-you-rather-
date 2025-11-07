import Foundation
import SwiftUI

class QuestionManager: ObservableObject {
    @Published var questions: [Question] = []
    @Published var userResponses: [UserResponse] = []
    @Published var currentQuestion: Question?
    
    private let questionsKey = "savedQuestions"
    private let responsesKey = "userResponses"
    
    init() {
        loadQuestions()
        loadResponses()
        if questions.isEmpty {
            initializeQuestions()
        }
        selectNextQuestion()
    }
    
    private func initializeQuestions() {
        questions = [
            Question(optionA: "Have the ability to fly", optionB: "Have the ability to become invisible"),
            Question(optionA: "Live in a world without music", optionB: "Live in a world without movies"),
            Question(optionA: "Always have to sing instead of speak", optionB: "Always have to dance everywhere you go"),
            Question(optionA: "Be able to talk to animals", optionB: "Be able to speak all human languages"),
            Question(optionA: "Have a pause button for your life", optionB: "Have a rewind button for your life"),
            Question(optionA: "Live without the internet", optionB: "Live without air conditioning and heating"),
            Question(optionA: "Have the ability to time travel", optionB: "Have the ability to teleport"),
            Question(optionA: "Always be 10 minutes late", optionB: "Always be 20 minutes early"),
            Question(optionA: "Fight one horse-sized duck", optionB: "Fight 100 duck-sized horses"),
            Question(optionA: "Have unlimited battery life on all your devices", optionB: "Have free WiFi wherever you go"),
            Question(optionA: "Be able to control fire", optionB: "Be able to control water"),
            Question(optionA: "Never be able to use a touchscreen", optionB: "Never be able to use a keyboard"),
            Question(optionA: "Have dinner with your favorite historical figure", optionB: "Have dinner with your favorite fictional character"),
            Question(optionA: "Live in a treehouse", optionB: "Live in a cave"),
            Question(optionA: "Have a personal chef", optionB: "Have a personal chauffeur"),
            Question(optionA: "Always know what time it is", optionB: "Always know where north is"),
            Question(optionA: "Be the funniest person in the room", optionB: "Be the smartest person in the room"),
            Question(optionA: "Have a third arm", optionB: "Have a third eye"),
            Question(optionA: "Be able to read minds", optionB: "Be able to see the future"),
            Question(optionA: "Live in space", optionB: "Live underwater"),
            Question(optionA: "Have a personal robot", optionB: "Have a pet dragon"),
            Question(optionA: "Always have to whisper", optionB: "Always have to shout"),
            Question(optionA: "Never have to sleep", optionB: "Never have to eat"),
            Question(optionA: "Be stuck on a deserted island alone", optionB: "Be stuck on a deserted island with someone you can't stand"),
            Question(optionA: "Have the ability to change your hair color at will", optionB: "Have the ability to change your eye color at will"),
            Question(optionA: "Live in a world of permanent winter", optionB: "Live in a world of permanent summer"),
            Question(optionA: "Have a rewind button for conversations", optionB: "Have a fast-forward button for awkward situations"),
            Question(optionA: "Be able to run at super speed", optionB: "Be able to jump super high"),
            Question(optionA: "Have unlimited sushi for life", optionB: "Have unlimited tacos for life"),
            Question(optionA: "Always have wet socks", optionB: "Always have a small rock in your shoe"),
            Question(optionA: "Live in a world where everyone tells the truth", optionB: "Live in a world where everyone is kind"),
            Question(optionA: "Have a photographic memory", optionB: "Have the ability to forget anything you want"),
            Question(optionA: "Be able to breathe underwater", optionB: "Be able to survive in space without a suit"),
            Question(optionA: "Have a magic carpet", optionB: "Have a time machine"),
            Question(optionA: "Be the best player on a losing team", optionB: "Be the worst player on a winning team"),
            Question(optionA: "Have every song you've ever heard stuck in your head", optionB: "Have the same dream every night"),
            Question(optionA: "Be a famous inventor", optionB: "Be a famous explorer"),
            Question(optionA: "Have legs as long as your fingers", optionB: "Have fingers as long as your legs"),
            Question(optionA: "Always feel slightly cold", optionB: "Always feel slightly warm"),
            Question(optionA: "Have a completely automated smart home", optionB: "Have a vacation home on a tropical island"),
            Question(optionA: "Be able to control the weather", optionB: "Be able to control technology with your mind"),
            Question(optionA: "Have perfect pitch", optionB: "Have perfect balance"),
            Question(optionA: "Live without chocolate", optionB: "Live without cheese"),
            Question(optionA: "Be always slightly overdressed", optionB: "Be always slightly underdressed"),
            Question(optionA: "Have a lifetime supply of books", optionB: "Have a lifetime supply of video games"),
            Question(optionA: "Be able to shrink to the size of an ant", optionB: "Be able to grow to the size of a building"),
            Question(optionA: "Have to wear clown shoes every day", optionB: "Have to wear a clown nose every day"),
            Question(optionA: "Have the ability to never feel pain", optionB: "Have the ability to heal instantly"),
            Question(optionA: "Be a character in your favorite book", optionB: "Be a character in your favorite TV show"),
            Question(optionA: "Have taste buds on your fingers", optionB: "Have eyes in the back of your head")
        ]
        saveQuestions()
    }
    
    func selectNextQuestion() {
        let unaskedQuestions = questions.filter { !$0.hasBeenAsked }
        
        if unaskedQuestions.isEmpty {
            // All questions asked, reset
            for index in questions.indices {
                questions[index].hasBeenAsked = false
            }
            saveQuestions()
            currentQuestion = questions.randomElement()
        } else {
            currentQuestion = unaskedQuestions.randomElement()
        }
    }
    
    func recordResponse(question: Question, selectedOption: String) {
        guard let index = questions.firstIndex(where: { $0.id == question.id }) else { return }
        
        // Update question statistics
        if selectedOption == "A" {
            questions[index].responseA += 1
        } else {
            questions[index].responseB += 1
        }
        
        // Mark question as asked
        questions[index].hasBeenAsked = true
        
        // Record user response
        let response = UserResponse(questionId: question.id, selectedOption: selectedOption)
        userResponses.append(response)
        
        // Save data
        saveQuestions()
        saveResponses()
        
        // Load next question
        selectNextQuestion()
    }
    
    func getAskedQuestions() -> [Question] {
        return questions.filter { $0.hasBeenAsked }
    }
    
    private func saveQuestions() {
        do {
            let encoded = try JSONEncoder().encode(questions)
            UserDefaults.standard.set(encoded, forKey: questionsKey)
        } catch {
            print("Error saving questions: \(error.localizedDescription)")
        }
    }
    
    private func loadQuestions() {
        guard let data = UserDefaults.standard.data(forKey: questionsKey) else { return }
        do {
            questions = try JSONDecoder().decode([Question].self, from: data)
        } catch {
            print("Error loading questions: \(error.localizedDescription)")
        }
    }
    
    private func saveResponses() {
        do {
            let encoded = try JSONEncoder().encode(userResponses)
            UserDefaults.standard.set(encoded, forKey: responsesKey)
        } catch {
            print("Error saving responses: \(error.localizedDescription)")
        }
    }
    
    private func loadResponses() {
        guard let data = UserDefaults.standard.data(forKey: responsesKey) else { return }
        do {
            userResponses = try JSONDecoder().decode([UserResponse].self, from: data)
        } catch {
            print("Error loading responses: \(error.localizedDescription)")
        }
    }
    
    func resetAllData() {
        for index in questions.indices {
            questions[index].responseA = 0
            questions[index].responseB = 0
            questions[index].hasBeenAsked = false
        }
        userResponses.removeAll()
        saveQuestions()
        saveResponses()
        selectNextQuestion()
    }
}
