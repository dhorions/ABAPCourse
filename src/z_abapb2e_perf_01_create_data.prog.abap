*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_PERF_01_CREATE_DATA
*&---------------------------------------------------------------------*
*& Create Sample data for the FLIGHT - Tables
*& This data will be used later for performance analysis and
*& performance improvement
*&---------------------------------------------------------------------*
REPORT Z_ABAPB2E_PERF_01_CREATE_DATA.
INCLUDE Z_ABAPB2E_PERF_00_MACROS.
*INCLUDE  Z_PERFORMANCE_00_MACROS.
DATA : lt_flightm TYPE TABLE OF flightm WITH HEADER LINE,
       lt_flights TYPE TABLE OF flights WITH HEADER LINE,
       lt_flightp TYPE TABLE OF flightp WITH HEADER LINE,
       lt_flightb TYPE TABLE OF flightb WITH HEADER LINE,
       l_id       TYPE numc5.

PARAMETERS : nflight TYPE i,
             ndays   TYPE i,
             clr     TYPE flag.


START-OF-SELECTION.
*--clear previous sample data
*--This will DELETE all data from the tables : FLIGHTM, FLIGHTS, FLIGHTP and FLIGHTB
  IF clr = 'X'.
    DELETE FROM flightm.
    DELETE FROM flights.
    DELETE FROM flightp.
    DELETE FROM flightb.
    COMMIT WORK.
  ENDIF.
*--Generate sample data
  DO nflight TIMES.
*--Flight master Data
    ADD 1 TO l_id.
    lt_flightm-id      = l_id.
    lt_flightm-curr = 'EUR'.
    _rnd_city lt_flightm-dcity.
    _rnd_city lt_flightm-acity.
    if lt_flightm-acity = lt_flightm-dcity.
        _rnd_city lt_flightm-dcity.
    endif.
    _rnd_time lt_flightm-dtime.
    _rnd_num lt_flightm-cap 100 250.
    _rnd_flag lt_flightm-line.
    IF lt_flightm-line = 'X'.
      lt_flightm-charter = ''.
    ELSE.
      lt_flightm-charter = 'X'.
    ENDIF.
    _rnd_num lt_flightm-price 100 lt_flightm-cap.
    APPEND lt_flightm.
    DO ndays TIMES.
*  --Attendants
      lt_flights-id         =  lt_flightm-id.
      _rnd_date lt_flights-dat.
      _rnd_person lt_flights-pilot.
      _rnd_person lt_flights-copilot.
      _rnd_person lt_flights-attend1.
      _rnd_person lt_flights-attend2.
      _rnd_person lt_flights-attend3.
      _rnd_person lt_flights-attend4.
      APPEND    lt_flights.
*  --Ooccupancy
      _rnd_num lt_flightp-booking 0 lt_flightm-cap.
      lt_flightp-id       =  lt_flightm-id.
      lt_flightp-dat      =  lt_flights-dat.
      APPEND   lt_flightp.
*  --Bookings
      lt_flightb-id      =  lt_flightm-id.
      lt_flightb-dat     =  lt_flights-dat.
      DO lt_flightp-booking TIMES.
        lt_flightb-seatno = sy-index.
        _rnd_person lt_flightb-firstname.
        _rnd_lname lt_flightb-lastname.
        _rnd_flag lt_flightb-fl_smoker.
        CLEAR : lt_flightb-classf, lt_flightb-classf,lt_flightb-classe.
        _rnd_flag lt_flightb-classf.
        IF lt_flightb-classf = ''.
          _rnd_flag lt_flightb-classb.
          IF lt_flightb-classb = ''.
            _rnd_flag lt_flightb-classe.
          ENDIF.
        ENDIF.
        _rnd_flag lt_flightb-meal.
        _rnd_flag lt_flightb-service.
        _rnd_discount lt_flightb-discout.
        APPEND lt_flightb.
      ENDDO.
    ENDDO.

  ENDDO.

*--Enter data in database
  MODIFY flights FROM table lt_flights.
  MODIFY flightb FROM table lt_flightb.
  MODIFY flightp FROM table lt_flightp.
  MODIFY flightm FROM table lt_flightm.
  COMMIT WORK.
