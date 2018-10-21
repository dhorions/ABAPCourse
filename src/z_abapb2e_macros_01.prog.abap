*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_MACROS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ABAPB2E_MACROS_01.

*--Macro Definitions

*--Simple macro that writes 3 variables on a new line
DEFINE _println.
  write : / &1,  &2,  &3.
end-of-definition.


*--Usage
_println 'One' 'Two' 'Three'.


*--Call the same macro multiple times
_println : '11' '12' '13',
           '21' '22' '23',
           '31' '32' '33'.
*--The same code without using a macro
  write : / '11',  '12',  '13'.
  write : / '21',  '22',  '23'.
  write : / '31',  '32',  '33'.
