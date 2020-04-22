CLASS /wav/clt_sdc_item DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_single_data_container
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_item_number
      RETURNING VALUE(re_item_number) TYPE /wav/et_item_number.

    METHODS set_item_number
      IMPORTING im_item_number TYPE /wav/et_item_number.

    METHODS get_item_count
      RETURNING VALUE(re_item_count) TYPE /wav/et_item_count.

    METHODS set_item_count
      IMPORTING im_item_count TYPE /wav/et_item_count.

    METHODS set_is_available
      IMPORTING im_available TYPE boolean.

    METHODS get_is_available
      RETURNING VALUE(re_is_available) TYPE boolean.

    METHODS get_data_id
         REDEFINITION .
    METHODS get_authority_data
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: item_number      TYPE /wav/et_item_number,
          item_available   TYPE boolean,
          item_count       TYPE /wav/et_item_count.

ENDCLASS.



CLASS /wav/clt_sdc_item IMPLEMENTATION.


  METHOD get_authority_data.
  ENDMETHOD.


  METHOD get_data_id.
  ENDMETHOD.

  METHOD get_item_number.
    re_item_number = item_number.
  ENDMETHOD.

  METHOD set_item_number.
    item_number = im_item_number.
  ENDMETHOD.

  METHOD get_item_count.
    re_item_count = item_count.
  ENDMETHOD.

  METHOD set_item_count.
    item_count = im_item_count.
  ENDMETHOD.

  METHOD set_is_available.
    item_available = im_available.
  ENDMETHOD.

  METHOD get_is_available.
    re_is_available = item_available.
  ENDMETHOD.

ENDCLASS.