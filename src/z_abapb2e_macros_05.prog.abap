*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_MACROS_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abapb2e_macros_05.
INCLUDE z_abapb2e_macros_05_macros.

DATA : lt_flights TYPE TABLE OF flightm WITH HEADER LINE,
       go_alvgrid TYPE REF TO cl_gui_alv_grid.



SELECT-OPTIONS : s_dcity FOR lt_flights-dcity.

START-OF-SELECTION.
*--Select the data
  SELECT * FROM flightm INTO TABLE lt_flights
  WHERE dcity IN s_dcity.

*--Display the data in ALV grid
  PERFORM display_alv TABLES lt_flights.


  INCLUDE z_abapb2e_macros_05_displayf01.
  INCLUDE z_abapb2e_macros_05_pai.
