*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_MACROS_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ABAPB2E_MACROS_04.

data :
 lt_flights type table of flightm with header line,
 begin of ls_flight_a,
  ID            type FL_ID,
  DCITY         type FL_FROM,
  ACITY         type FL_TO,
  DTIME         type FL_TIME,
 end of ls_flight_a,
 begin of ls_flight_b,
  flight_ID      type FL_ID,
  Departure_CITY type FL_FROM,
  arrival_CITY   type FL_TO,
  Departure_TIME type FL_TIME,
 end of ls_flight_b.





parameters : p_dcity type FL_FROM lower case.
start-of-selection.
*--Get the flight data
select * from flightm into table lt_flights where dcity = p_dcity.

*--Move the data from the lt_flights table to the structure ls_flight_a.
loop at lt_flights.
*--All fields have the same name, so move-corresponding can be used
  move-corresponding lt_flights to ls_flight_a.
endloop.

*--Move the data from the lt_flights table to the structure ls_flight_a.
loop at lt_flights.
*--All fields do not have the same name
  ls_flight_b-flight_ID       =  lt_flights-id.
  ls_flight_b-Departure_CITY  =  lt_flights-dcity.
  ls_flight_b-arrival_CITY    =  lt_flights-acity.
  ls_flight_b-Departure_TIME  =  lt_flights-dtime.
endloop.

define _move.
  &2-&4 = &1-&3.
end-of-definition.
*--Let's rewrite this using a macro
loop at lt_flights.
  _move  lt_flights ls_flight_b :
          id         flight_ID,
          dcity      departure_city,
          acity      arrival_city,
          dtime      departure_time.

endloop.

*--Partial field name substitution

define _set_city.
  &1-&2_city = &3.
end-of-definition.

_set_city ls_flight_b  :
  arrival   'New-York',
  departure 'Chicago'.

write : ls_flight_b-arrival_city, ls_flight_b-departure_city.
