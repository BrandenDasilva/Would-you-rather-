import SwiftUI

struct ContentView: View {
    @StateObject private var questionManager = QuestionManager()
    @State private var showHistory = false
    @State private var selectedOption: String?
    @State private var showResults = false
    @State private var showResetAlert = false
    
    private let resultsDisplayDuration: TimeInterval = 3.0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    if let question = questionManager.currentQuestion {
                        if !showResults {
                            questionView(question: question)
                        } else {
                            resultsView(question: question)
                        }
                    } else {
                        Text("Loading question...")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
            .navigationTitle("Would You Rather?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showHistory = true
                    }) {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showResetAlert = true
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showHistory) {
                HistoryView(questionManager: questionManager)
            }
            .alert("Reset All Data?", isPresented: $showResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    questionManager.resetAllData()
                }
            } message: {
                Text("This will reset all questions and delete all response history. This action cannot be undone.")
            }
        }
    }
    
    @ViewBuilder
    private func questionView(question: Question) -> some View {
        VStack(spacing: 30) {
            Text("Would You Rather...")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.top, 40)
            
            Spacer()
            
            VStack(spacing: 20) {
                OptionButton(
                    text: question.optionA,
                    color: .pink,
                    isSelected: selectedOption == "A"
                ) {
                    handleSelection(question: question, option: "A")
                }
                
                Text("OR")
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                
                OptionButton(
                    text: question.optionB,
                    color: .cyan,
                    isSelected: selectedOption == "B"
                ) {
                    handleSelection(question: question, option: "B")
                }
            }
            
            Spacer()
            
            if selectedOption != nil {
                Button(action: {
                    if let option = selectedOption {
                        questionManager.recordResponse(question: question, selectedOption: option)
                        withAnimation {
                            showResults = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + resultsDisplayDuration) {
                            withAnimation {
                                showResults = false
                                selectedOption = nil
                            }
                        }
                    }
                }) {
                    Text("Submit")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                .transition(.scale)
            }
        }
    }
    
    @ViewBuilder
    private func resultsView(question: Question) -> some View {
        VStack(spacing: 30) {
            Text("Results")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            VStack(spacing: 20) {
                ResultCard(
                    text: question.optionA,
                    percentage: question.percentageA,
                    responses: question.responseA,
                    color: .pink
                )
                
                ResultCard(
                    text: question.optionB,
                    percentage: question.percentageB,
                    responses: question.responseB,
                    color: .cyan
                )
            }
            
            Text("Total Responses: \(question.totalResponses)")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    
    private func handleSelection(question: Question, option: String) {
        withAnimation(.spring()) {
            selectedOption = option
        }
    }
}

struct OptionButton: View {
    let text: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.opacity(isSelected ? 1.0 : 0.7))
                    .shadow(color: isSelected ? color : .clear, radius: 10)
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(), value: isSelected)
        }
        .padding(.horizontal, 20)
    }
}

struct ResultCard: View {
    let text: String
    let percentage: Double
    let responses: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(text)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
            
            HStack {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 30)
                            .cornerRadius(10)
                        
                        Rectangle()
                            .fill(color)
                            .frame(width: geometry.size.width * CGFloat(percentage / 100), height: 30)
                            .cornerRadius(10)
                    }
                }
                .frame(height: 30)
                
                Text(String(format: "%.1f%%", percentage))
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(width: 60)
            }
            
            Text("\(responses) votes")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
        )
        .padding(.horizontal, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
