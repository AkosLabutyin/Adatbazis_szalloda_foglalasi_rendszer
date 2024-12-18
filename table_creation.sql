CREATE TABLE GUESTS(
    ID NUMBER PRIMARY KEY,
    GUEST_NAME VARCHAR(250) NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL,
    EMAIL VARCHAR(40) NOT NULL
);
alter table GUESTS
add (created_time timestamp(6) DEFAULT SYSDATE);

CREATE TABLE ROOMS(
    ID NUMBER PRIMARY KEY,
    ROOM_TYPE VARCHAR(20) NOT NULL,
    PRICE_PER_NIGHT NUMBER NOT NULL,
    IS_AVAILABLE VARCHAR(1) DEFAULT 'Y' CHECK(IS_AVAILABLE IN ( 'Y', 'N' ) )
);
alter table ROOMS
add (created_time timestamp(6) DEFAULT SYSDATE);

CREATE TABLE BOOKINGS(
    BOOKING_ID NUMBER PRIMARY KEY,
    GUEST_ID NUMBER NOT NULL CONSTRAINT GUEST_FK REFERENCES GUESTS(ID),
    ROOM_ID NUMBER NOT NULL CONSTRAINT ROOM_FK REFERENCES ROOMS(ID),
    CHECK_IN_DATE TIMESTAMP(6) NOT NULL,
    CHECK_OUT_DATE TIMESTAMP(6) NOT NULL,
    TOTAL_PRICE NUMBER NOT NULL
);
alter table BOOKINGS
add (created_time timestamp(6) DEFAULT SYSDATE);

CREATE TABLE SERVICES(
    SERVICE_ID NUMBER PRIMARY KEY,
    SERVICE_NAME VARCHAR(20) NOT NULL,
    PRICE NUMBER NOT NULL
);

alter table SERVICES
add (created_time timestamp(6) DEFAULT SYSDATE);

CREATE TABLE BOOKING_SERVICES(
    BOOKING_SERVICE_ID NUMBER PRIMARY KEY,
    BOOKING_ID NUMBER NOT NULL CONSTRAINT BOOKING_FK REFERENCES BOOKINGS(BOOKING_ID),
    SERVICE_ID NUMBER NOT NULL CONSTRAINT SERVICE_FK REFERENCES SERVICES(SERVICE_ID),
    QUANTITY NUMBER
);
alter table BOOKING_SERVICES
add (created_time timestamp(6) DEFAULT SYSDATE);