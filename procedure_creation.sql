CREATE OR REPLACE PROCEDURE restore_room_availability(p_room_id IN NUMBER) AS
BEGIN
    UPDATE Rooms
    SET is_available = 'Y'
    WHERE id = p_room_id;
END restore_room_availability;

CREATE OR REPLACE PROCEDURE update_room_availability(p_room_id IN NUMBER) AS
BEGIN
    UPDATE Rooms
    SET is_available = 'N'
    WHERE id = p_room_id;
END update_room_availability;
