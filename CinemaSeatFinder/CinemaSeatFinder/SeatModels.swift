import Foundation // For UUID

// Enum to represent the status of a seat
enum SeatStatus {
    case available
    case taken
    case selected
}

// Struct to represent a single seat
struct Seat: Identifiable {
    let id: UUID // Unique identifier for the seat
    var row: Int     // Row number of the seat
    var number: Int  // Seat number within the row
    var status: SeatStatus

    // Initializer
    init(id: UUID = UUID(), row: Int, number: Int, status: SeatStatus) {
        self.id = id
        self.row = row
        self.number = number
        self.status = status
    }
}

// Struct to provide mock data for seats
struct MockData {
    static func generateMockSeats(rows: Int, seatsPerRow: Int) -> [[Seat]] {
        var grid: [[Seat]] = []
        for r in 0..<rows {
            var rowArray: [Seat] = []
            for s in 0..<seatsPerRow {
                let randomNumber = Double.random(in: 0..<1) // Random number between 0.0 and 1.0
                let status: SeatStatus
                if randomNumber < 0.60 { // 60% chance
                    status = .available
                } else if randomNumber < 0.95 { // 35% chance (0.60 + 0.35 = 0.95)
                    status = .taken
                } else { // 5% chance
                    status = .selected
                }
                rowArray.append(Seat(row: r, number: s, status: status))
            }
            grid.append(rowArray)
        }
        return grid
    }
}
