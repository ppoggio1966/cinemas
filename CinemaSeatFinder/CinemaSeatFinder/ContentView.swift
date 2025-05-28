import SwiftUI

// SeatStatus enum and Seat struct are now in SeatModels.swift

struct ContentView: View {
    // Initialize seats using the mock data generator
    // 10 rows, 12 seats per row as specified for Atlas Caballito simulation
    @State private var seats: [[Seat]] = MockData.generateMockSeats(rows: 10, seatsPerRow: 12)

    // Function to get the color for a seat based on its status
    private func colorForStatus(_ status: SeatStatus) -> Color {
        switch status {
        case .available:
            return .green
        case .taken:
            return .red
        case .selected:
            return .blue
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            Text("Cinema Seats")
                .font(.title)
                .padding(.bottom, 20)

            ForEach(0..<seats.count, id: \.self) { rowIndex in
                HStack(spacing: 10) {
                    ForEach(0..<seats[rowIndex].count, id: \.self) { colIndex in
                        Rectangle()
                            .fill(colorForStatus(seats[rowIndex][colIndex].status))
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                            .onTapGesture {
                                let currentStatus = seats[rowIndex][colIndex].status
                                switch currentStatus {
                                case .available:
                                    // Change status from available to selected
                                    seats[rowIndex][colIndex].status = .selected
                                case .selected:
                                    // Change status from selected back to available
                                    seats[rowIndex][colIndex].status = .available
                                case .taken:
                                    // Taken seats are not interactive
                                    break
                                }
                            }
                    }
                }
            }
            Spacer() // Pushes the grid to the top
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
