*&---------------------------------------------------------------------*
*& Include          Z_ABAPB2E_MACROS_05_MACROS
*&---------------------------------------------------------------------*


*--Macro to change ALV column settings  in field catalog table ( form prepare_field_catalog )
  DEFINE _adjust_alv_column.
    READ TABLE et_fieldcat WITH KEY fieldname = &1 ASSIGNING <field>.
    IF sy-subrc = 0.
      <field>-&2 = &3.
    ELSE.
      MESSAGE e001(00) WITH 'Unknown column ' &1.
    ENDIF.
  END-OF-DEFINITION.

*--Macro to add sort fields to alv sorting table   ( form prepare_sorting )
  DEFINE _sort_alv_column.
    ADD 1 TO ls_sort-spos.
    ls_sort-fieldname = &1 .
    ls_sort-up = 'X'.
    APPEND ls_sort TO  et_sort.
  END-OF-DEFINITION.
