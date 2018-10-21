*&---------------------------------------------------------------------*
*& Report Z_ABAPB2E_MACROS_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ABAPB2E_MACROS_02.
data :l_index like sy-index.


*--Macro definition
*--the macro is defined here, and the variable l_result is not in scope.
*--A macro inherits the scope of the location where it is called from
*--If you call a macro from a location where the variable is not in scope
*--The code will not compile
define _multiply.
   l_result = &1 * &2.
end-of-definition.


start-of-selection.
do 10 times.
  l_index = sy-index.
  write : / 'Multiplication table of ' , l_index.
  perform multiplication_table using l_index .
  uline.
enddo.

form multiplication_table using i_factor type i.
  data : l_result type i,
         l_index like sy-index.
  do 10 timeS.
    l_index = sy-index.
    _multiply l_index i_factor.
    write : / l_index, 'X', i_factor , '=', l_result.
  enddo.
endform.
*--This form will not compile, since the variable l_result used in macro m_multiply is not in scope
*form incorrect_form.
*    m_multiply 1 2.
*endform.
