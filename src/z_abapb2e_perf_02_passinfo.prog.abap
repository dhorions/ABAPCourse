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
          first_name        type FL_FNAME,
          last_name         type FL_LNAME,
          DISCOUT           type FL_DISCNT,
          base_price        type FL_PRICE,
          discounted_price  type FL_PRICE,
      end of lt_passenger_price,
      begin of lt_passenger_total occurs 0,
          first_name        type FL_FNAME,
          last_name         type FL_LNAME,
          base_price        type FL_PRICE,
          discounted_price  type FL_PRICE,
          numflights        type i,
      end of lt_passenger_total,
      l_multiplier  type p decimals 2.
field-symbols : <pp> like lt_passenger_price.
select-options :
 s_first for flightb-firstname,
 s_last  for flightb-lastname,
 s_dat   for flightb-dat.


start-of-selection.
*--Get all flights for passengers, including discount.
select
    b~firstname
    b~lastname
    b~discout
    m~price as base_price

  from flightb as b
  inner join flightm as m on
    b~id = m~id
  into table lt_passenger_price
  where firstname in s_first and
        lastname  in s_last  and
        dat       in s_dat.
*--Calculate the discounted price
loop at   lt_passenger_price assigning <pp>.
  case <pp>-discout.
    when '10%'.
        l_multiplier = '0.90'.
    when '25%'.
        l_multiplier = '0.75'.
    when '50%'.
        l_multiplier = '0.50'.
    when '100%'.
        l_multiplier = '0.00'.
  endcase.
  <pp>-discounted_price = <pp>-base_price * l_multiplier.
*  modify   lt_passenger_price.
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
    write : 1   lt_passenger_total-first_name,
            15  lt_passenger_total-last_name,
            30  lt_passenger_total-discounted_price,
            50  lt_passenger_total-base_price.
    new-line.
endloop.
