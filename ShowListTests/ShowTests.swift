//
//  ShowTests.swift
//  ShowList

import XCTest
@testable import ShowList

final class ShowTests: XCTestCase {

    func test_decodingShowFromJSON_shouldSucceed() throws {
        let json = """
        {
            "id": 1,
            "url": "https://www.tvmaze.com/shows/1/under-the-dome",
            "name": "Under the Dome",
            "type": "Scripted",
            "language": "English",
            "genres": ["Drama", "Science-Fiction", "Thriller"],
            "status": "Ended",
            "runtime": 60,
            "averageRuntime": 60,
            "premiered": "2013-06-24",
            "ended": "2015-09-10",
            "officialSite": "http://www.cbs.com/shows/under-the-dome/",
            "schedule": {
                "time": "08:00",
                "days": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
            },
            "rating": {
                "average": 8.5
            },
            "weight": 100,
            "network": {
                "id": 2,
                "name": "CBS",
                "country": {
                    "name": "United States",
                    "code": "US",
                    "timezone": "America/New_York"
                },
                "officialSite": "https://www.cbs.com/"
            },
            "externals": {
                "tvrage": null,
                "thetvdb": 12345,
                "imdb": "tt1234567"
            },
            "image": {
                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                "original": "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
            },
            "summary": "A <b>test</b> summary with <i>HTML</i>.",
            "updated": 1739649693,
            "_links": {
                "self": {
                    "href": "https://api.tvmaze.com/shows/1"
                },
                "previousepisode": {
                    "href": "https://api.tvmaze.com/episodes/185054",
                    "name": "The Enemy Within"
                }
            }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let show = try decoder.decode(Show.self, from: json)

        XCTAssertEqual(show.id, 1)
        XCTAssertEqual(show.name, "Under the Dome")
        XCTAssertEqual(show.schedule.time, "08:00")
        XCTAssertEqual(show.days, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        XCTAssertEqual(show.time, "08:00")
        XCTAssertEqual(show.hour, 8)
        XCTAssertEqual(show.timeSlot, "Weekdays Mornings")
        XCTAssertEqual(show.summaryInString, "A test summary with HTML.")
        XCTAssertEqual(show.image.original, "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg")
        XCTAssertEqual(show.links.previousepisode.name, "The Enemy Within")
    }

    func test_scheduleTime_withWeekendEarlyMorning_shouldReturnEarlyWeekendsMornings() {
        let schedule = Schedule(time: "04:00", days: ["Saturday", "Sunday"])
        let show = Show.testStub(schedule: schedule)
        XCTAssertEqual(show.timeSlot, "Early Weekends Mornings")
    }
    
    func test_scheduleTime_withWeekdaysNights_shouldReturnWeekdaysNights() {
        let schedule = Schedule(time: "19:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        let show = Show.testStub(schedule: schedule)
        XCTAssertEqual(show.timeSlot, "Weekdays Nights")
    }

    func test_scheduleTime_withEmptyTime_shouldReturnDaysOnly() {
        let schedule = Schedule(time: "", days: ["Wednesday"])
        let show = Show.testStub(schedule: schedule)
        XCTAssertEqual(show.timeSlot, "Wednesday")
    }
    
    func test_hourShouldBeNilIfTimeEmpty() {
        let schedule = Schedule(time: "", days: ["Wednesday"])
        let show = Show.testStub(schedule: schedule)
        XCTAssertNil(show.hour)
    }
    
    func test_hourShouldBeNotNilIfTimeEmpty() {
        let schedule = Schedule(time: "04:00", days: ["Saturday", "Sunday"])
        let show = Show.testStub(schedule: schedule)
        XCTAssertNotNil(show.hour)
    }

    func test_summaryInString_shouldDecodeHTML() {
        let htmlSummary = "Test <b>bold</b> &amp; <i>italic</i> text."
        let schedule = Schedule(time: "10:00", days: ["Monday"])
        let show = Show.testStub(schedule: schedule, summary: htmlSummary)
        XCTAssertEqual(show.summaryInString, "Test bold & italic text.")
    }
}

extension Show {
    static func testStub(
        id: Int = 1,
        name: String = "Test Show",
        schedule: Schedule = Schedule(time: "10:00", days: ["Monday", "Tuesday"]),
        summary: String = "Test summary"
    ) -> Show {
        return Show(
            id: id,
            url: "https://www.tvmaze.com/shows/1/under-the-dome",
            name: name,
            type: "Scripted",
            language: "English",
            genres: [
                "Drama",
                "Science-Fiction",
                "Thriller"
              ],
            status: "Ended",
            runtime: 60,
            averageRuntime: 60,
            premiered: "2022-01-01",
            ended: "2015-09-10",
            officialSite: "http://www.cbs.com/shows/under-the-dome/",
            schedule: schedule,
            rating: Rating(average: 8.5),
            weight: 90,
            network: Network(
                id: 1,
                name: "CBS",
                country: Country(name: "United States", code: "US", timezone: "America/New_York"),
                officialSite: nil
            ),
            externals: Externals(tvrage: nil, thetvdb: nil, imdb: nil),
            image: Image(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg", original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"),
            summary: summary,
            updated: 1739649693,
            links: Links(
                self: Link(href: "https://api.tvmaze.com/shows/1"),
                previousepisode: PreviousEpisode(href: "https://api.tvmaze.com/episodes/185054", name: "The Enemy Within")
            )
        )
    }
}

