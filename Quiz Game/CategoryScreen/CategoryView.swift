import SwiftUI

struct CategoryView: View {
    var body: some View {
        List {
            ForEach(QuestionAnswer.Category.allCases.sorted(), id:\.self) { category in
                NavigationLink {
                    QuestionAnswerView(viewModel: QuestionAnswerViewModel(category: category), isAnswered: false, selectedAnswer: nil)
                        .navigationTitle("Quiz Game")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text(category.rawValue)
                }

            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
