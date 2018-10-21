*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_MACROS_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ABAPB2E_MACROS_03.

data : go_rnd       TYPE REF TO cl_abap_random,
       g_macro_days type i,
       l_start      type dats,
       l_end        type dats,
       l_rnd_date   type dats.
*--Initialize the pseudo-random number generator class
define _init_rnd.
    if go_rnd is initial.
      go_rnd = cl_abap_random=>create( ).
    endif.
end-of-definition.
*--get a random date between two dates
DEFINE _random_date.
  _init_rnd. "initialize random nr object if not done yet
*--Check how many days between the two provided dates
  if &1 > &2.
     g_macro_days = &1 - &2.
  else.
     g_macro_days = &2 - &1.
  endif.
*--Create a random nr
  g_macro_days = go_rnd->intinrange( low = 0 high = g_macro_days ).

  if &1 > &2.
     &3 = &2 + g_macro_days.
  else.
     &3 = &1 + g_macro_days.
  endif.
END-OF-DEFINITION.


*--Get a random date between two dates
*--Being able to use the macro random_date makes our code a lot more readable.
l_start = '20180101'.
l_end   = '20181231'.
do 10 times.
  _random_date l_start l_end l_rnd_date.
  write : / l_rnd_date.
enddo.

uline.


*--Equivalent code without macros
l_start = '20180101'.
l_end   = '20181231'.
do 10 times.
  if go_rnd is initial.
    go_rnd = cl_abap_random=>create( ).
  endif.
*--Check how many days between the two provided dates
  if l_start > l_end.
     g_macro_days = l_start - l_end.
  else.
     g_macro_days = l_end - l_start.
  endif.
*--Create a random nr
  g_macro_days = go_rnd->intinrange( low = 0 high = g_macro_days ).
  if l_start > l_end.
     l_rnd_date = l_end + g_macro_days.
  else.
     l_rnd_date = l_start + g_macro_days.
  endif.
  write : / l_rnd_date.
enddo.
