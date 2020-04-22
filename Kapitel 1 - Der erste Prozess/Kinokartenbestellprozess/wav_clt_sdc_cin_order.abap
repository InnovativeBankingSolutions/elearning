CLASS /wav/clt_sdc_cin_order DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_single_data_container
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_authority_data
         REDEFINITION .
    METHODS get_data_id
         REDEFINITION .

    METHODS get_order_number
      RETURNING VALUE(re_order_number) TYPE /wav/et_order_number.

    METHODS set_order_number
      IMPORTING im_order_number TYPE /wav/et_order_number.

    METHODS set_discount_code
      IMPORTING im_discount_code TYPE /wav/et_discount_code.

    METHODS get_discount_code
      RETURNING VALUE(re_discount_code) TYPE /wav/et_discount_code.

    METHODS get_provided_discount
      RETURNING VALUE(re_provided_discount) TYPE /wav/et_discount.

    METHODS set_provided_discount
      IMPORTING im_provided_discount TYPE /wav/et_discount.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      order_number      TYPE /wav/et_order_number,
      discount_code     TYPE /wav/et_discount_code,
      provided_discount TYPE /wav/et_discount.

ENDCLASS.



CLASS /wav/clt_sdc_cin_order IMPLEMENTATION.
  METHOD get_authority_data.

  ENDMETHOD.

  METHOD get_data_id.
    re_data_id = CONV #( order_number ).
  ENDMETHOD.

  METHOD get_order_number.
    re_order_number = order_number.
  ENDMETHOD.

  METHOD set_order_number.
    order_number = im_order_number.
  ENDMETHOD.

  METHOD set_discount_code.
    discount_code = im_discount_code.
  ENDMETHOD.

  METHOD get_discount_code.
    re_discount_code = discount_code.
  ENDMETHOD.

  METHOD get_provided_discount.
    re_provided_discount = provided_discount.
  ENDMETHOD.

  METHOD set_provided_discount.
    provided_discount = im_provided_discount.
  ENDMETHOD.


ENDCLASS.