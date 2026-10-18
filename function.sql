DELIMITER $$
CREATE FUNCTION fn_free_seats(p_flight_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_sold  INT DEFAULT 0;

    SELECT a.seats INTO v_total
    FROM flights f
    JOIN aircraft a ON a.aircraft_id = f.aircraft_id
    WHERE f.flight_id = p_flight_id;

    SELECT COUNT(*) INTO v_sold
    FROM tickets
    WHERE flight_id = p_flight_id;

    RETURN GREATEST(v_total - v_sold, 0);
END$$
DELIMITER ;