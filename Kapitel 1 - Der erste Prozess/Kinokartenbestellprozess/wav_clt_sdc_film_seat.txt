CLASS /wav/clt_sdc_film_seat DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_single_data_container
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_authority_data
         REDEFINITION .
    METHODS get_data_id
         REDEFINITION .

    METHODS get_seat_number
      RETURNING VALUE(re_seat_number) TYPE /wav/et_seat_number.

    METHODS get_seat_row
      RETURNING VALUE(re_seat_row) TYPE /wav/et_seat_row.

    METHODS set_seat_row
      IMPORTING im_seat_row TYPE /wav/et_seat_row.

    METHODS set_seat_number
      IMPORTING im_seat_number TYPE /wav/et_seat_number.

    METHODS is_available
      RETURNING VALUE(re_is_available) TYPE boolean.

    METHODS set_is_available
      IMPORTING im_is_available TYPE boolean.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      seat_number       TYPE /wav/et_seat_number,
      seat_row          TYPE /wav/et_seat_row,
      seat_is_available TYPE boolean.

ENDCLASS.



CLASS /wav/clt_sdc_film_seat IMPLEMENTATION.


  METHOD get_authority_data.
  ENDMETHOD.

  METHOD get_data_id.
    re_data_id = CONV #( seat_row && seat_number ).
  ENDMETHOD.

  METHOD get_seat_number.
    re_seat_number = seat_number.
  ENDMETHOD.

  METHOD get_seat_row.
    re_seat_row = seat_row.
  ENDMETHOD.

  METHOD set_seat_row.
    seat_row = im_seat_row.
  ENDMETHOD.

  METHOD set_seat_number.
    seat_number = im_seat_number.
  ENDMETHOD.

  METHOD is_available.
    re_is_available = seat_is_available.
  ENDMETHOD.

  METHOD set_is_available.
    seat_is_available = im_is_available.
  ENDMETHOD.
ENDCLASS.