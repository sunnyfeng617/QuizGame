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

    enum Category: String, Codable, CaseIterable, Comparable {
        static func < (lhs: QuestionAnswer.Category, rhs: QuestionAnswer.Category) -> Bool {
            return String(describing: lhs.rawValue) < String(describing: rhs.rawValue)
        }

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

        func categoryNumber() -> Int {
            switch self {
            case .general: return 9
            case .books: return 10
            case .film: return 11
            case .music: return 12
            case .theatre: return 13
            case .tv: return 14
            case .videoGames: return 15
            case .boardGames: return 16
            case .scienceNature: return 17
            case .computers: return 18
            case .maths: return 19
            case .mythology: return 20
            case .sports: return 21
            case .geography: return 22
            case .history: return 23
            case .politics: return 24
            case .art: return 25
            case .celebrities: return 26
            case .animals: return 27
            case .vehicles: return 28
            case .comics: return 29
            case .gadgets: return 30
            case .anime: return 31
            case .cartoons: return 32
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case category, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
