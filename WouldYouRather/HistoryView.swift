import SwiftUI

struct HistoryView: View {
    @ObservedObject var questionManager: QuestionManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 15) {
                        let askedQuestions = questionManager.getAskedQuestions()
                        
                        if askedQuestions.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "clock")
                                    .font(.system(size: 60))
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.top, 100)
                                
                                Text("No questions answered yet!")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text("Start answering questions to build your history")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        } else {
                            ForEach(askedQuestions.sorted(by: { $0.totalResponses > $1.totalResponses })) { question in
                                HistoryCard(question: question)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Question History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

struct HistoryCard: View {
    let question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Would You Rather...")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
            
            VStack(spacing: 10) {
                HStack {
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 10, height: 10)
                    
                    Text(question.optionA)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Text(String(format: "%.0f%%", question.percentageA))
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.pink)
                }
                
                HStack {
                    Circle()
                        .fill(Color.cyan)
                        .frame(width: 10, height: 10)
                    
                    Text(question.optionB)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Text(String(format: "%.0f%%", question.percentageB))
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.cyan)
                }
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            HStack {
                Image(systemName: "person.2.fill")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 12))
                
                Text("\(question.totalResponses) total responses")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.15))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(questionManager: QuestionManager())
    }
}
