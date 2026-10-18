DROP DATABASE IF EXISTS airport_db;
CREATE DATABASE airport_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airport_db;

CREATE TABLE airlines (
    airline_id INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL
);

CREATE TABLE airports (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    iata_code  CHAR(3) NOT NULL,
    city       VARCHAR(80) NOT NULL
);

CREATE TABLE aircraft (
    aircraft_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_id  INT NOT NULL,
    model       VARCHAR(80) NOT NULL,
    seats       INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE flights (
    flight_id         INT AUTO_INCREMENT PRIMARY KEY,
    flight_number     VARCHAR(10) NOT NULL,
    aircraft_id       INT NOT NULL,
    airport_id   INT NOT NULL,
    departure_city    VARCHAR(80) NOT NULL,
    arrival_city      VARCHAR(80) NOT NULL,
    departure_time    DATETIME NOT NULL,
    arrival_time      DATETIME NOT NULL,
    base_price        DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (aircraft_id)     REFERENCES aircraft(aircraft_id),
    FOREIGN KEY (airport_id) REFERENCES airports(airport_id)
);

CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(120) NOT NULL,
    passport_no  VARCHAR(20) NOT NULL
);

CREATE TABLE tickets (
    flight_id    INT NOT NULL,
    passenger_id INT NOT NULL,
    seat_number  VARCHAR(5),
    price        DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (flight_id, passenger_id),
    FOREIGN KEY (flight_id)    REFERENCES flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id) ON DELETE CASCADE
);