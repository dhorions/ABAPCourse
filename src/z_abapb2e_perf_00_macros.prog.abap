*&---------------------------------------------------------------------*
*& Include Z_PERFORMANCE_00_MACROS
*&---------------------------------------------------------------------*
Data : go_rnd     TYPE REF TO cl_abap_random,
       g_rnd_int  TYPE i.
*--A few macro's to get semi-random data
*  This is good enough data for our purposes
* ( don't complain if we have a flight from Paris to Paris for 500€ where all the crew has the same name)
define _init_rnd.
    if go_rnd is initial.
      go_rnd = cl_abap_random=>create( ).
    endif.
end-of-definition.
DEFINE _rnd_city.
  _init_rnd.
  g_rnd_int = go_rnd->intinrange( low = 0 high = 14 ).
  CASE g_rnd_int.
    WHEN 0.
        &1 = 'Brussels'.
    WHEN 1.
        &1 = 'Barcelona'.
    WHEN 2.
        &1 = 'Heidelberg'.
    WHEN 3.
        &1 = 'Kopenhagen'.
    WHEN 4.
        &1 = 'Prague'.
    WHEN 5.
        &1 = 'Paris'.
    WHEN 6.
        &1 = 'London'.
    WHEN 7.
        &1 = 'Birmingham'.
    WHEN 8.
        &1 = 'Toulouse'.
    WHEN 9.
        &1 = 'Amsterdam'.
    WHEN 10.
        &1 = 'Dublin'.
    WHEN 11.
        &1 = 'Rome'.
    WHEN 12.
        &1 = 'Warsaw'.
    WHEN 13.
        &1 = 'Budapest'.
    WHEN 14.
        &1 = 'Riga'.


  ENDCASE.
END-OF-DEFINITION.
DEFINE _rnd_person.
  g_rnd_int = go_rnd->intinrange( low = 0 high = 11 ).
  CASE g_rnd_int.
    WHEN 0.
        &1 = 'Joanne'.
    WHEN 1.
        &1 = 'James'.
    WHEN 2.
        &1 = 'Jim'.
    WHEN 3.
        &1 = 'Johannes'.
    WHEN 4.
        &1 = 'Jeremy'.
    WHEN 5.
        &1 = 'Jane'.
    WHEN 6.
        &1 = 'Jacob'.
    WHEN 7.
        &1 = 'Joshua'.
    WHEN 8.
        &1 = 'Jore'.
    WHEN 9.
        &1 = 'Joseph'.
    WHEN 10.
        &1 = 'Justin'.
    WHEN 11.
        &1 = 'Jacalyn'.

  ENDCASE.
END-OF-DEFINITION.
DEFINE _rnd_lname.
  g_rnd_int = go_rnd->intinrange( low = 0 high = 11 ).
  CASE g_rnd_int.
    WHEN 0.
        &1 = 'Jameson'.
    WHEN 1.
        &1 = 'Jones'.
    WHEN 2.
        &1 = 'Jennings'.
    WHEN 3.
        &1 = 'Jans'.
    WHEN 4.
        &1 = 'Johanssen'.
    WHEN 5.
        &1 = 'Joplin'.
    WHEN 6.
        &1 = 'Jimenez'.
    WHEN 7.
        &1 = 'Jensen'.
    WHEN 8.
        &1 = 'Jarvis'.
    WHEN 9.
        &1 = 'Juarez'.
    WHEN 10.
        &1 = 'Jacks'.
    WHEN 11.
        &1 = 'Jacobs'.

  ENDCASE.
END-OF-DEFINITION.
DEFINE _rnd_discount.
  g_rnd_int = go_rnd->intinrange( low = 1 high = 4 ).
  CASE g_rnd_int.
    WHEN 1.
        &1 = '10%'.
    WHEN 2.
        &1 = '25%'.
    WHEN 3.
        &1 = '50%'.
    WHEN 4.
        &1 = '100%'.
  ENDCASE.
END-OF-DEFINITION.
DEFINE _rnd_date.
  g_rnd_int = go_rnd->intinrange( low = 0 high = 100 ).
  &1 = sy-datum.
  ADD g_rnd_int TO &1.
END-OF-DEFINITION.
DEFINE _rnd_time.
  g_rnd_int = go_rnd->intinrange( low = 0 high = 86400 ).
  &1 = '000000'.
  ADD g_rnd_int TO &1 .
END-OF-DEFINITION.

DEFINE _rnd_flag.
  g_rnd_int = go_rnd->intinrange( low = 0 high = 1 ).
  IF g_rnd_int = 1.
    &1 = 'X'.
  ELSE.
    &1 = ''.
  ENDIF.
END-OF-DEFINITION.

DEFINE _rnd_num.
  g_rnd_int = go_rnd->intinrange( low = &2 high = &3 ).
  &1 = g_rnd_int.
END-OF-DEFINITION.
