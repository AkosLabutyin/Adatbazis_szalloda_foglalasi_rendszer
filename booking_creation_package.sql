CREATE OR REPLACE PACKAGE PKG_BOOKING_CREATION AS
    ROOM_NOT_AVAILABLE_EXC EXCEPTION;
    PRAGMA EXCEPTION_INIT(ROOM_NOT_AVAILABLE_EXC, -20101);

    PROCEDURE CREATE_BOOKING(
        P_GUEST_NAME VARCHAR,
        P_PHONE_NUMBER VARCHAR,
        P_EMAIL VARCHAR,
        P_ROOM_TYPE VARCHAR,
        P_CHECK_IN_DATE TIMESTAMP,
        P_CHECK_OUT_DATE TIMESTAMP,
        P_SERVICE VARCHAR
    );

    FUNCTION CREATE_GUEST(
        P_GUEST_NAME IN VARCHAR,
        P_PHONE_NUMBER IN VARCHAR,
        P_EMAIL IN VARCHAR
    ) RETURN NUMBER;
END PKG_BOOKING_CREATION;

CREATE OR REPLACE PACKAGE BODY PKG_BOOKING_CREATION AS

    FUNCTION CREATE_GUEST(
        P_GUEST_NAME IN VARCHAR,
        P_PHONE_NUMBER IN VARCHAR,
        P_EMAIL IN VARCHAR
    ) RETURN NUMBER IS
        V_GUEST_ID NUMBER;
    BEGIN
        INSERT INTO GUESTS(
            GUEST_NAME,
            PHONE_NUMBER,
            EMAIL
        ) VALUES(
            P_GUEST_NAME,
            P_PHONE_NUMBER,
            P_EMAIL
        ) RETURNING ID INTO V_GUEST_ID;
        RETURN V_GUEST_ID;
    END CREATE_GUEST;

    PROCEDURE CREATE_BOOKING(
        P_GUEST_NAME VARCHAR,
        P_PHONE_NUMBER VARCHAR,
        P_EMAIL VARCHAR,
        P_ROOM_TYPE VARCHAR,
        P_CHECK_IN_DATE TIMESTAMP,
        P_CHECK_OUT_DATE TIMESTAMP,
        P_SERVICE VARCHAR
    )IS
        V_GUEST_ID             NUMBER;
        V_ROOM_ID              NUMBER;
        V_TOTAL_PRICE          NUMBER;
        V_ROOM_PRICE_PER_NIGHT NUMBER;
        V_BOOKING_ID           NUMBER;
    BEGIN
        BEGIN --guest check
            SELECT
                ID INTO V_GUEST_ID
            FROM
                GUESTS
            WHERE
                EMAIL = P_EMAIL;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_GUEST_ID := CREATE_GUEST(
                    P_GUEST_NAME => P_GUEST_NAME,
                    P_PHONE_NUMBER => P_PHONE_NUMBER,
                    P_EMAIL => P_EMAIL
                );
        END;

        BEGIN --room check
            SELECT
                ID,
                PRICE_PER_NIGHT INTO V_ROOM_ID,
                V_ROOM_PRICE_PER_NIGHT
            FROM
                ROOMS
            WHERE
                ROOM_TYPE = P_ROOM_TYPE
                AND IS_AVAILABLE = 'Y';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE ROOM_NOT_AVAILABLE_EXC;
                RETURN;
        END;

        BEGIN
            PKG_ROOM_AVAILABILITY.update_room_availability( v_room_id );
            V_TOTAL_PRICE := V_ROOM_PRICE_PER_NIGHT * EXTRACT(DAY FROM (P_CHECK_OUT_DATE - P_CHECK_IN_DATE));
            INSERT INTO BOOKINGS (
                GUEST_ID,
                ROOM_ID,
                CHECK_IN_DATE,
                CHECK_OUT_DATE,
                TOTAL_PRICE
            ) VALUES (
                V_GUEST_ID,
                V_ROOM_ID,
                P_CHECK_IN_DATE,
                P_CHECK_OUT_DATE,
                V_TOTAL_PRICE
            ) RETURNING BOOKING_ID INTO V_BOOKING_ID;
        END;

        BEGIN
            PKG_BOOKING_MODIFICATIONS.ADD_SERVICE(
                P_BOOKING_ID => V_BOOKING_ID,
                P_SERVICE_NAME => P_SERVICE
            );
        END;
    END CREATE_BOOKING;
END PKG_BOOKING_CREATION;

SET SERVEROUTPUT ON;
BEGIN
    PKG_BOOKING_CREATION.CREATE_BOOKING(
        P_GUEST_NAME => 'Akssss Lab',
        P_PHONE_NUMBER => '1234567890',
        P_EMAIL => 'akos.v345345i@example.com',
        P_ROOM_TYPE => 'Suite',
        P_CHECK_IN_DATE => TO_TIMESTAMP('2024-12-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        P_CHECK_OUT_DATE => TO_TIMESTAMP('2024-12-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        P_SERVICE => 'Breakfast'
    );
END;