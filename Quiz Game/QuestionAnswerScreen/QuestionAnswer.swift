import Foundation

struct Response: Codable {
    let results: [QuestionAnswer]
}

struct QuestionAnswer: Codable {
    let category: Category
    let difficulty: Difficulty
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    var allAnswers: [String] {
        ([correctAnswer] + incorrectAnswers).sorted()
    }

    enum Difficulty: String, Codable {
        case easy
        case medium
        case hard
    }

    enum Category: String, Codable {
        case general = "General Knowledge"
        case books = "Entertainment: Books"
        case film = "Entertainment: Film"
        case music = "Entertainment: Music"
        case theatre = "Entertainment: Musicals & Theatres"
        case tv = "Entertainment: Television"
        case videoGames = "Entertainment: Video Games"
        case boardGames = "Entertainment: Board Games"
        case scienceNature = "Science & Nature"
        case computers = "Science: Computers"
        case maths = "Science: Mathematics"
        case mythology = "Mythology"
        case sports = "Sports"
        case geography = "Geography"
        case history = "History"
        case politics = "Politics"
        case art = "Art"
        case celebrities = "Celebrities"
        case animals = "Animals"
        case vehicles = "Vehicles"
        case comics = "Entertainment: Comics"
        case gadgets = "Science: Gadgets"
        case anime = "Entertainment: Japanese Anime & Manga"
        case cartoons = "Entertainment: Cartoon & Animations"
    }

    enum CodingKeys: String, CodingKey {
        case category, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
