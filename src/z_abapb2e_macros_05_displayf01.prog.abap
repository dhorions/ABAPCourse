*----------------------------------------------------------------------*
***INCLUDE Z_ABAPB2E_MACROS_05_DISPLAYF01.
*----------------------------------------------------------------------*
FORM display_alv  TABLES  it_flights STRUCTURE flightm.
  DATA: lo_container TYPE REF TO cl_gui_custom_container,
        lt_fieldcat  TYPE lvc_t_fcat,
        lt_sort      TYPE lvc_t_sort.
  IF go_alvgrid IS INITIAL .
*----Creating custom container instance
    CREATE OBJECT lo_container
      EXPORTING
        container_name              = 'ALV_GRID'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*--Exception handling
    ENDIF.
*----Creating ALV Grid instance
    CREATE OBJECT go_alvgrid
      EXPORTING
        i_parent          = lo_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      MESSAGE e001(00) WITH 'Creating ALV Grid failed'.
    ENDIF.
*----Preparing field catalog.
    PERFORM prepare_field_catalog CHANGING lt_fieldcat.
    PERFORM prepare_sorting       CHANGING lt_sort.
*--functions
    CALL METHOD go_alvgrid->set_table_for_first_display
      CHANGING
        it_outtab                     = it_flights[]
        it_fieldcatalog               = lt_fieldcat
        IT_SORT                       = lt_sort
*       IT_FILTER                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
      MESSAGE e001(00) WITH 'Displaying ALV Grid failed'.
    ENDIF.
    CALL SCREEN 0001.
  ELSE .
    CALL METHOD go_alvgrid->refresh_table_display
      EXCEPTIONS
        finished = 1
        OTHERS   = 2.
    IF sy-subrc <> 0.
      MESSAGE e001(00) WITH 'Refreshing ALV Grid failed'.
    ENDIF.
  ENDIF .
ENDFORM.
FORM prepare_field_catalog  CHANGING et_fieldcat TYPE lvc_t_fcat .
*  DATA ls_fcat TYPE lvc_s_fcat.
  FIELD-SYMBOLS <field> TYPE lvc_s_fcat.
*--Load initial field catalog from structure
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'FLIGHTM'
    CHANGING
      ct_fieldcat            = et_fieldcat[]
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    MESSAGE e001(00) WITH 'Prepare field catalog failed'.
  ENDIF.





*--Without Macro, the code could look like this
    READ TABLE et_fieldcat WITH KEY fieldname = 'ID' ASSIGNING <field>.
    if sy-subrc = 0.
      <field>-key     = ''.
      <field>-coltext = 'Flight ID'(t01).
    else.
      MESSAGE e001(00) WITH 'Unknown column ' 'ID'.
    endif.
    READ TABLE et_fieldcat WITH KEY fieldname = 'DCITY' ASSIGNING <field>.
    if sy-subrc = 0.
      <field>-hotspot = ''.
      <field>-coltext = 'Departing From'(t02).
    else.
      MESSAGE e001(00) WITH 'Unknown column ' 'DCITY'.
    endif.
    READ TABLE et_fieldcat WITH KEY fieldname = 'PRICE' ASSIGNING <field>.
    if sy-subrc = 0.
      <field>-decimals = 2.
      <field>-coltext  = 'Ticket Price'(t03).
    else.
      MESSAGE e001(00) WITH 'Unknown column ' 'PRICE'.
    endif.
    READ TABLE et_fieldcat WITH KEY fieldname = 'LINE' ASSIGNING <field>.
    if sy-subrc = 0.
      <field>-checkbox  = 'X'.
      <field>-outputlen = 15.
    else.
      MESSAGE e001(00) WITH 'Unknown column ' 'LINE'.
    endif.
    READ TABLE et_fieldcat WITH KEY fieldname = 'CHARTER' ASSIGNING <field>.
    if sy-subrc = 0.
      <field>-checkbox  = 'X'.
      <field>-outputlen = 15.
    else.
      MESSAGE e001(00) WITH 'Unknown column ' 'CHARTER'.
    endif.




ENDFORM.
FORM prepare_sorting  CHANGING et_sort TYPE lvc_t_sort.
  DATA ls_sort TYPE lvc_s_sort.

*--Without Macro, the code could look like this
    ls_sort-up = 'X'.
    add 1 to ls_sort-spos.
    ls_sort-fieldname = 'DCITY' .
    append ls_sort to et_sort.
    add 1 to ls_sort-spos.
    ls_sort-fieldname = 'ACITY' .
    append ls_sort to et_sort.
    add 1 to ls_sort-spos.
    ls_sort-fieldname = 'DTIME' .
    append ls_sort to et_sort.
    add 1 to ls_sort-spos.
    ls_sort-fieldname = 'PRICE' .
    append ls_sort to et_sort.



ENDFORM.
