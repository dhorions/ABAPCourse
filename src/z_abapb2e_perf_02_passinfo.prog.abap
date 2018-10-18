*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_PERF_02_PASSINFO
*&---------------------------------------------------------------------*
*&  Overview of number of tickets and price payed per passenger
*&  for this excercise, we'll ignore currencies and assume everything
*& is in euros
*&---------------------------------------------------------------------*
REPORT Z_ABAPB2E_PERF_02_PASSINFO.
tables : flightb.
*--Internal table to calculate and hold the discounted price per passenger per flight
data :
       begin of lt_passenger_price occurs 0,
         id                 type FL_ID,
          firstname        type FL_FNAME,
          lastname         type FL_LNAME,
          DISCOUT           type FL_DISCNT,
          base_price        type FL_PRICE,
          discounted_price  type FL_PRICE,
      end of lt_passenger_price,
      begin of lt_passenger_total occurs 0,
          firstname        type FL_FNAME,
          lastname         type FL_LNAME,
          base_price        type FL_PRICE,
          discounted_price  type FL_PRICE,
          numflights        type i,
      end of lt_passenger_total,
      lt_flightm type  table of flightm
      with header line,
      l_multiplier  type p decimals 2.

select-options :
 s_first for flightb-firstname,
 s_last  for flightb-lastname,
 s_dat   for flightb-dat.


start-of-selection.
*--Get all bookins for passengers, including discount.
select id firstname lastname discout
  from flightb
  into corresponding fields of table lt_passenger_price
  where firstname in s_first and
        lastname  in s_last  and
        dat       in s_dat.
*--Get all flight master data
select * from flightm into table lt_flightm order by id.
*--Calculate the discounted price
loop at   lt_passenger_price.
  case lt_passenger_price-discout.
    when '10%'.
        l_multiplier = '0.90'.
    when '25%'.
        l_multiplier = '0.75'.
    when '50%'.
        l_multiplier = '0.50'.
    when '100%'.
        l_multiplier = '0.00'.
  endcase.
*--Find the flight
  read table lt_flightm with key id = lt_passenger_price-id.
  if sy-subrc = 0.
*--calculate the discounted price
    lt_passenger_price-base_price       = lt_flightm-price.
    lt_passenger_price-discounted_price = lt_flightm-price * l_multiplier.
  endif.
  modify   lt_passenger_price.
endloop.
*--Calculate passenger totals
loop at lt_passenger_price.
   move-corresponding lt_passenger_price to lt_passenger_total.
   lt_passenger_total-numflights = 1.
   collect lt_passenger_total.
endloop.

sort lt_passenger_total by discounted_price descending.
write :  1 'Firstname', 15 'Lastname', 30 'Discounted Price', 50 'Base Price'.
uline.
loop at lt_passenger_total.
    write : 1   lt_passenger_total-firstname,
            15  lt_passenger_total-lastname,
            30  lt_passenger_total-discounted_price,
            50  lt_passenger_total-base_price.
    new-line.
endloop.
