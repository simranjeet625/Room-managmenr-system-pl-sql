-- Create Customers Table
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    contact_number TEXT,
    email TEXT UNIQUE NOT NULL
);

-- Create Rooms Table
CREATE TABLE Rooms (
    room_id INTEGER PRIMARY KEY AUTOINCREMENT,
    room_number TEXT UNIQUE NOT NULL,
    room_type TEXT CHECK(room_type IN ('Single', 'Double', 'Suite')) NOT NULL,
    price REAL NOT NULL,
    status TEXT CHECK(status IN ('Available', 'Booked', 'Maintenance')) NOT NULL DEFAULT 'Available'
);

-- Create Reservations Table
CREATE TABLE Reservations (
    reservation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    room_id INTEGER,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status TEXT CHECK(status IN ('Confirmed', 'Cancelled', 'Completed')) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Insert Sample Customers
INSERT INTO Customers (first_name, last_name, contact_number, email) VALUES
('John', 'Doe', '1234567890', 'john.doe@example.com'),
('Jane', 'Smith', '0987654321', 'jane.smith@example.com');

-- Insert Sample Rooms
INSERT INTO Rooms (room_number, room_type, price, status) VALUES
('101', 'Single', 100.00, 'Available'),
('102', 'Double', 150.00, 'Available'),
('103', 'Suite', 250.00, 'Available');

-- Insert Sample Reservations
INSERT INTO Reservations (customer_id, room_id, check_in, check_out, status) VALUES
(1, 1, '2024-11-10', '2024-11-12', 'Confirmed'),
(2, 2, '2024-11-11', '2024-11-13', 'Confirmed');

-- View Available Rooms
SELECT * FROM Rooms WHERE status = 'Available';

-- View All Reservations
SELECT r.reservation_id, c.first_name, c.last_name, ro.room_number, r.check_in, r.check_out, r.status
FROM Reservations r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Rooms ro ON r.room_id = ro.room_id;

-- Update Room Status After Booking
UPDATE Rooms SET status = 'Booked' WHERE room_id = 1;

-- Cancel a Reservation
UPDATE Reservations SET status = 'Cancelled' WHERE reservation_id = 1;

-- View All Customers
SELECT * FROM Customers;

-- View All Rooms
SELECT * FROM Rooms;

-- View All Reservations
SELECT * FROM Reservations;