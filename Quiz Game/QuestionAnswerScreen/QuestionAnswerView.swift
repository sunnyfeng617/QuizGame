import SwiftUI


class QuestionAnswerViewModel: ObservableObject {

    @Published var questions: [QuestionAnswer] = []

    func fetchQuestions() async throws -> [QuestionAnswer] {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else {
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
            points(points: points)
            questionAnswerSection()
            Spacer()
            continueButton
        }
        .onAppear {
            viewModel.load()
        }.padding(16)
    }

    @ViewBuilder
    private func questionAnswerSection() -> some View {
        if index < viewModel.questions.count {
            let questionAnswer = viewModel.questions[index]
            Text(String(htmlEncodedString: questionAnswer.question) ?? questionAnswer.question)
            answerSection(answers: questionAnswer.allAnswers, correctAnswer: questionAnswer.correctAnswer)
        }
    }

    @ViewBuilder
    private func answerSection(answers: [String], correctAnswer: String) -> some View {
        ForEach(answers, id:\.self) { answer in
            AnswerCell(text: answer, isAnswered: isAnswered, isCorrect: answer == correctAnswer, isSelected: answer == selectedAnswer)
                .onTapGesture {
                    if answer == correctAnswer && isAnswered == false { points += 1 }
                    selectedAnswer = answer
                    isAnswered = true
                }
        }
    }

    @ViewBuilder
    private func points(points: Int) -> some View {
        HStack {
            Spacer()
            Text("Points \(points)")
        }
        .padding(.bottom, 15)
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
        let viewModel = QuestionAnswerViewModel()
        QuestionAnswerView(viewModel: viewModel)
    }
}

enum URLError: Error {
    case urlError
}
