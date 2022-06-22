import SwiftUI


class QuestionAnswerViewModel: ObservableObject {

    let category: QuestionAnswer.Category
    @Published var questions: [QuestionAnswer] = []

    init(category: QuestionAnswer.Category) {
        self.category = category
    }

    func fetchQuestions() async throws -> [QuestionAnswer] {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(category.categoryNumber())") else {
            throw URLError.urlError
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let questions = try JSONDecoder().decode(Response.self, from: data)
        return questions.results
    }

    func load() {
        Task { @MainActor in
            do {
                questions = try await fetchQuestions()
            } catch {

            }
        }
    }
}

struct QuestionAnswerView: View {
    @ObservedObject var viewModel: QuestionAnswerViewModel
    @State var index: Int = 0
    @State var isAnswered: Bool = false
    @State var selectedAnswer: String? = nil
    @State var points: Int = 0

    var body: some View {
        VStack {
            questionAnswerSection()
            Spacer()
            continueButton
        }
        .padding(16)
        .onAppear {
            viewModel.load()
        }
    }

    @ViewBuilder
    private func questionAnswerSection() -> some View {
        if index < viewModel.questions.count {
            let questionAnswer = viewModel.questions[index]
            difficultyPoints(difficulty: questionAnswer.difficulty, points: points)
            Text(String(htmlEncodedString: questionAnswer.question) ?? questionAnswer.question)
            answerSection(answers: questionAnswer.allAnswers, correctAnswer: questionAnswer.correctAnswer)
        } else if viewModel.questions.count != 0 {
            displayPoints(points: points)
        }
    }

    @ViewBuilder
    private func answerSection(answers: [String], correctAnswer: String) -> some View {
        ForEach(answers, id:\.self) { answer in
            AnswerCell(text: answer, isAnswered: isAnswered, isCorrect: answer == correctAnswer, isSelected: answer == selectedAnswer)
                .onTapGesture {
                    if answer == correctAnswer && !isAnswered { points += 1 }
                    if !isAnswered {
                        selectedAnswer = answer
                        isAnswered = true
                    }
                }
        }
    }
    
    @ViewBuilder
    private func difficultyPoints(difficulty: QuestionAnswer.Difficulty, points: Int) -> some View {
        HStack {
            Text(difficulty.rawValue.capitalized)
            Spacer()
            Text("Points \(points)")
        }
        .padding(.bottom, 15)
    }
    
    @ViewBuilder
    private func displayPoints(points: Int) -> some View {
        Spacer()
        if points == 1 {
            Text("You scored \(points) point!")
        } else {
            Text("You scored \(points) points!")
        }
        Spacer()
    }

    var continueButton: some View {
        Button(action: {
            index += 1
            isAnswered = false
        }) {
            isAnswered ? Text("Continue") : Text("Skip")
        }.padding()
    }
}

struct QuestionAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QuestionAnswerViewModel(category: .film)
        QuestionAnswerView(viewModel: viewModel)
    }
}

enum URLError: Error {
    case urlError
}
