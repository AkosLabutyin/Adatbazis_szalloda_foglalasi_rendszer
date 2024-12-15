-- Insert date into Guests table 
INSERT INTO GUESTS (
    guest_NAME,
    PHONE_NUMBER,
    EMAIL
) VALUES (
    'John Doe',
    '1234567890',
    'john.doe@example.com'
);
INSERT INTO GUESTS (
    guest_NAME,
    PHONE_NUMBER,
    EMAIL
) VALUES (
    'Jane Smith',
    '9876543210',
    'jane.smith@example.com'
);
INSERT INTO GUESTS (
    guest_NAME,
    PHONE_NUMBER,
    EMAIL
) VALUES (
    'Alice Brown',
    '4567891230',
    'alice.brown@example.com'
);

-- Insert date into Rooms table 
INSERT INTO ROOMS (
    ROOM_TYPE,
    PRICE_PER_NIGHT,
    IS_AVAILABLE
) VALUES (
    'Single',
    50,
    'N'
);
INSERT INTO ROOMS (
    ROOM_TYPE,
    PRICE_PER_NIGHT,
    IS_AVAILABLE
) VALUES (
    'Double',
    75,
    'Y'
);
INSERT INTO ROOMS (
    ROOM_TYPE,
    PRICE_PER_NIGHT,
    IS_AVAILABLE
) VALUES (
    'Suite',
    120,
    'N'
);

-- Insert date into Bookings table 
INSERT INTO BOOKINGS (
    GUEST_ID,
    ROOM_ID,
    CHECK_IN_DATE,
    CHECK_OUT_DATE,
    TOTAL_PRICE
) VALUES (
    2340,
    1508,
    TO_DATE('2024-12-20', 'YYYY-MM-DD'),
    TO_DATE('2024-12-22', 'YYYY-MM-DD'),
    240
);
INSERT INTO BOOKINGS (
    GUEST_ID,
    ROOM_ID,
    CHECK_IN_DATE,
    CHECK_OUT_DATE,
    TOTAL_PRICE
) VALUES (
    2341,
    1506,
    TO_DATE('2024-12-25', 'YYYY-MM-DD'),
    TO_DATE('2024-12-27', 'YYYY-MM-DD'),
    100
);

-- Insert date into Services table 
INSERT INTO SERVICES (
    SERVICE_NAME,
    PRICE
) VALUES (
    'Room Cleaning',
    20
);
INSERT INTO SERVICES (
    SERVICE_NAME,
    PRICE
) VALUES (
    'Breakfast',
    15
);
INSERT INTO SERVICES (
    SERVICE_NAME,
    PRICE
) VALUES (
    'Laundry Service',
    10
);

-- Insert data into Booking_Services table
INSERT INTO BOOKING_SERVICES (
    BOOKING_ID,
    SERVICE_ID,
    QUANTITY
) VALUES (
    6500,
    7500,
    1
);
INSERT INTO BOOKING_SERVICES (
    BOOKING_ID,
    SERVICE_ID,
    QUANTITY
) VALUES (
    6500,
    7501,
    2
);
INSERT INTO BOOKING_SERVICES (
    BOOKING_ID,
    SERVICE_ID,
    QUANTITY
) VALUES (
    6501,
    7502,
    3
);