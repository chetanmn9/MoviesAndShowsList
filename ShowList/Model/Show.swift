//
//  Show.swift
//  ShowList

import Foundation

struct Show: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network?
    let externals: Externals
    let image: Image
    let summary: String
    let updated: Int
    let links: Links

    private enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, image, externals, summary, updated
        case links = "_links"
    }
    
    var year: String {
        return premiered?.components(separatedBy: "-").first ?? "No Year"
    }
    
    var genreDisplay: String {
        return genres.joined(separator: ", ")
    }
    
    var time: String {
        return schedule.time
    }
    
    var days: [String] {
        return schedule.days
    }
    
    var hour: Int? {
        if !time.isEmpty {
            return Int(time[..<time.index(time.startIndex, offsetBy: 2)])!
        }
        return nil
    }
    
    var summaryInString: String {
        summary.htmlToPlainText()
    }
    
    var timeSlot: String {
        var schedule = String()
        let weekends = ["Saturday", "Sunday"]
        let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        if let hour = hour {
            if [0, 7].contains(days.count) {
                schedule = addTimeDescriptor(for: hour)
            } else {
                schedule = addDayDescriptor(for: days) + " " + addTimeDescriptor(for: hour)
            }
            schedule = hour < 6 ? "Early" + " " + schedule : schedule
        } else {
            schedule = addDayDescriptor(for: days)
        }
        
        func addTimeDescriptor(for hour: Int) -> String {
            if hour < 12 {
                return "Mornings"
            } else if hour < 18 {
                return "Afternoons"
            } else {
                return "Nights"
            }
        }
        
        func addDayDescriptor(for days: [String]) -> String {
            if [2].contains(days.count) && days.allSatisfy(weekends.contains) {
                return "Weekends"
            } else if [5].contains(days.count) && days.allSatisfy(weekdays.contains) {
                return "Weekdays"
            } else {
                return days.joined(separator: ", ")
            }
        }
        return schedule
    }
}

struct Schedule: Codable, Equatable {
    let time: String
    let days: [String]
}

struct Rating: Codable, Equatable {
    let average: Double?
}

struct Network: Codable, Equatable {
    let id: Int
    let name: String
    let country: Country
    let officialSite: String?
}

struct Country: Codable, Equatable {
    let name: String
    let code: String
    let timezone: String
}

struct Externals: Codable, Equatable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct Image: Codable, Equatable {
    let medium: String
    let original: String
}

struct Links: Codable, Equatable {
    let `self`: Link
    let previousepisode: PreviousEpisode
}

struct Link: Codable, Equatable {
    let href: String
}

struct PreviousEpisode: Codable, Equatable {
    let href: String
    let name: String?
}


extension Show {
    static let mock = Show(
        id: 1,
        url: "https://www.tvmaze.com/shows/1/under-the-dome",
        name: "Under the Dome",
        type: "Scripted",
        language: "English",
        genres: ["Drama", "Science-Fiction", "Thriller"],
        status: "Ended",
        runtime: 60,
        averageRuntime: 60,
        premiered: "2013-06-24",
        ended: "2015-09-10",
        officialSite: "http://www.cbs.com/shows/under-the-dome/",
        schedule: Schedule(time: "21:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]),
        rating: Rating(average: 8.5),
        weight: 100,
        network: Network(
            id: 1,
            name: "Mock Network",
            country: Country(name: "USA", code: "US", timezone: "America/New_York"),
            officialSite: "https://mocknetwork.com"
        ),
        externals: Externals(tvrage: 123, thetvdb: 456, imdb: "tt1234567"),
        image: Image(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
        ),
        summary: "<p>This is a mock summary.</p>",
        updated: 1680000000,
        links: Links(
            self: Link(href: "https://api.tvmaze.com/shows/1"),
            previousepisode: PreviousEpisode(href: "https://api.tvmaze.com/episodes/185054", name: "The Enemy Within")
        )
    )
}

extension Show {
    static func mock(id: Int = 0, name: String = "Mock Show") -> Show {
        Show(
            id: id,
            url: "",
            name: name,
            type: "Scripted",
            language: "English",
            genres: [],
            status: "Running",
            runtime: 60,
            averageRuntime: 60,
            premiered: nil,
            ended: nil,
            officialSite: nil,
            schedule: Schedule(time: "", days: []),
            rating: Rating(average: 8.5),
            weight: 0,
            network: nil,
            externals: Externals(tvrage: nil, thetvdb: nil, imdb: nil),
            image: Image(medium: "", original: ""),
            summary: "",
            updated: 0,
            links: Links(
                self: Link(href: "https://api.tvmaze.com/shows/1"),
                previousepisode: PreviousEpisode(href: "https://api.tvmaze.com/episodes/185054", name: "The Enemy Within")
            )
        )
    }
}
