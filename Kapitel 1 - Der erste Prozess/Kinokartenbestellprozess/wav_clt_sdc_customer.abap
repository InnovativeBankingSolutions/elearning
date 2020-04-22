CLASS /wav/clt_sdc_customer DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_single_data_container
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_authority_data
         REDEFINITION .
    METHODS get_data_id
         REDEFINITION .

    METHODS get_customer_number
      RETURNING VALUE(re_cust_number) TYPE /wav/et_customer_number.

    METHODS set_customer_number
      IMPORTING im_customer_number TYPE /wav/et_customer_number.

    METHODS get_customer_first_name
      RETURNING VALUE(re_first_name) TYPE /wav/et_customer_first_name.

    METHODS set_customer_first_name
      IMPORTING im_first_name TYPE /wav/et_customer_first_name.

    METHODS get_customer_last_name
      RETURNING VALUE(re_last_name) TYPE /wav/et_customer_last_name.

    METHODS set_customer_last_name
      IMPORTING im_last_name TYPE /wav/et_customer_last_name.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: first_name TYPE /wav/et_customer_first_name,
          last_name  TYPE /wav/et_customer_last_name,
          number     TYPE /wav/et_customer_number.

ENDCLASS.



CLASS /wav/clt_sdc_customer IMPLEMENTATION.


  METHOD get_authority_data.
  ENDMETHOD.


  METHOD get_data_id.
    re_data_id = CONV #( number ).
  ENDMETHOD.

  METHOD get_customer_number.
    re_cust_number = number.
  ENDMETHOD.

  METHOD set_customer_number.
    number = im_customer_number.
  ENDMETHOD.

  METHOD get_customer_first_name.
    re_first_name = first_name.
  ENDMETHOD.

  METHOD set_customer_first_name.
    first_name = im_first_name.
  ENDMETHOD.

  METHOD get_customer_last_name.
    re_last_name = last_name.
  ENDMETHOD.

  METHOD set_customer_last_name.
    last_name = im_last_name.
  ENDMETHOD.
ENDCLASS.