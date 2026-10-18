DELIMITER $$
CREATE PROCEDURE sp_buy_ticket(
    IN  p_flight_id    INT,
    IN  p_passenger_id INT,
    IN  p_seat_number  VARCHAR(5),
    IN  p_price        DECIMAL(10,2),
    OUT p_success      BOOLEAN,
    OUT p_message      VARCHAR(200)
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_success = FALSE;
        SET p_message = 'Ошибка БД при оформлении билета';
    END;

    START TRANSACTION;

    SELECT COUNT(*) INTO v_exists
    FROM tickets
    WHERE flight_id = p_flight_id AND passenger_id = p_passenger_id;

    IF v_exists > 0 THEN
        SET p_success = FALSE;
        SET p_message = 'Пассажир уже имеет билет на этот рейс';
        ROLLBACK;
    ELSEIF fn_free_seats(p_flight_id) <= 0 THEN
        SET p_success = FALSE;
        SET p_message = 'Нет свободных мест на рейсе';
        ROLLBACK;
    ELSE
        INSERT INTO tickets (flight_id, passenger_id, seat_number, price)
        VALUES (p_flight_id, p_passenger_id, p_seat_number, p_price);

        COMMIT;
        SET p_success = TRUE;
        SET p_message = 'Билет успешно оформлен';
    END IF;
END$$
DELIMITER ;