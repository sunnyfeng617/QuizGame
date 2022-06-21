import SwiftUI

struct AnswerCell: View {
    let text: String
    var isAnswered: Bool
    let isCorrect: Bool
    var isSelected: Bool
    let lightBlue = Color(uiColor: UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00))

    var body: some View {
        HStack {
            Text(String(htmlEncodedString: text) ?? text)
            Spacer()
            if isAnswered && isSelected {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
            }
        }
        .padding()
        .background(isAnswered ? (isCorrect ? .green : .red) : lightBlue)
        .cornerRadius(15)
        .padding(.vertical, 4)
        .opacity(isAnswered && !isSelected ? 0.7 : 1)
    }
}

struct AnswerCell_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCell(text: "This is an answer", isAnswered: false, isCorrect: true, isSelected: false)
        AnswerCell(text: "This is an answer", isAnswered: true, isCorrect: true, isSelected: true)
        AnswerCell(text: "This is an answer", isAnswered: true, isCorrect: false, isSelected: false)
    }
}
