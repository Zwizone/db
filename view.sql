CREATE VIEW v_flights_summary AS
SELECT
    f.flight_id,
    f.flight_number,
    al.name AS airline,
    CONCAT(f.departure_city, ' → ', f.arrival_city) AS route,
    apt.city AS airport,
    f.departure_time,
    f.arrival_time,
    f.base_price,
    a.seats AS seats_total,
    COUNT(t.passenger_id) AS seats_sold,
    fn_free_seats(f.flight_id) AS seats_free
FROM flights f
JOIN aircraft a   ON a.aircraft_id = f.aircraft_id
JOIN airlines al  ON al.airline_id = a.airline_id
JOIN airports apt ON apt.airport_id = f.airport_id
LEFT JOIN tickets t ON t.flight_id = f.flight_id
GROUP BY f.flight_id, f.flight_number, al.name, f.departure_city, 
         f.arrival_city, apt.city, f.departure_time, f.arrival_time, 
         f.base_price, a.seats;