import XCTest
@testable import CinemaSeatFinder // Allows access to internal types from the main app target

class SeatLogicTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test the initialization of the Seat struct
    func testSeatInitialization() throws {
        let seatID = UUID()
        let seatRow = 2
        let seatNumber = 5
        let seatStatus = SeatStatus.available

        let seat = Seat(id: seatID, row: seatRow, number: seatNumber, status: seatStatus)

        XCTAssertEqual(seat.id, seatID, "Seat ID should match the provided ID.")
        XCTAssertEqual(seat.row, seatRow, "Seat row should match the provided row number.")
        XCTAssertEqual(seat.number, seatNumber, "Seat number should match the provided seat number.")
        XCTAssertEqual(seat.status, seatStatus, "Seat status should match the provided status.")
    }
    
    // Test the default UUID initialization
    func testSeatDefaultIDInitialization() throws {
        let seatRow = 1
        let seatNumber = 1
        let seatStatus = SeatStatus.taken
        
        let seat = Seat(row: seatRow, number: seatNumber, status: seatStatus)
        
        XCTAssertNotNil(seat.id, "Seat ID should be automatically generated and not nil.")
        XCTAssertEqual(seat.row, seatRow)
        XCTAssertEqual(seat.number, seatNumber)
        XCTAssertEqual(seat.status, seatStatus)
    }

    // Test the MockData.generateMockSeats function
    func testMockDataGeneration() throws {
        let numRows = 3
        let numSeatsPerRow = 4
        let mockSeats = MockData.generateMockSeats(rows: numRows, seatsPerRow: numSeatsPerRow)

        // 1. Assert that the returned 2D array has the correct number of rows
        XCTAssertEqual(mockSeats.count, numRows, "The number of rows generated should match numRows.")

        // Iterate through each generated row
        for r in 0..<numRows {
            let row = mockSeats[r]
            // 2. Assert that each row has the correct number of seats
            XCTAssertEqual(row.count, numSeatsPerRow, "Row \(r) should have numSeatsPerRow seats.")

            // Iterate through each seat in the row
            for s in 0..<numSeatsPerRow {
                let seat = row[s]
                // 3. Assert that all generated Seat objects have valid row and number properties
                XCTAssertEqual(seat.row, r, "Seat at (\(r),\(s)) should have row \(r).")
                XCTAssertEqual(seat.number, s, "Seat at (\(r),\(s)) should have number \(s).")

                // 4. Assert that each seat has one of the defined SeatStatus values
                // This is inherently true by Swift's strong typing for enums,
                // but we can check it's one of the known cases.
                let isValidStatus = (seat.status == .available || seat.status == .taken || seat.status == .selected)
                XCTAssertTrue(isValidStatus, "Seat at (\(r),\(s)) has an invalid status: \(seat.status).")
            }
        }
    }
    
    func testMockDataGenerationEmpty() throws {
        let numRows = 0
        let numSeatsPerRow = 0
        let mockSeats = MockData.generateMockSeats(rows: numRows, seatsPerRow: numSeatsPerRow)
        XCTAssertEqual(mockSeats.count, numRows, "The number of rows should be 0.")

        let mockSeatsNonEmptyRows = MockData.generateMockSeats(rows: 2, seatsPerRow: 0)
        XCTAssertEqual(mockSeatsNonEmptyRows.count, 2, "The number of rows should be 2.")
        XCTAssertTrue(mockSeatsNonEmptyRows[0].isEmpty, "Each row should be empty if seatsPerRow is 0.")
        XCTAssertTrue(mockSeatsNonEmptyRows[1].isEmpty, "Each row should be empty if seatsPerRow is 0.")
    }
}
