CLASS /wav/clt_sdc_buyer DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_single_data_container
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_address
      RETURNING VALUE(re_address) TYPE /wav/et_buyer_adress.

    METHODS set_address
      IMPORTING im_address TYPE /wav/et_buyer_adress.

    METHODS get_mail_address
      RETURNING VALUE(re_mail_address) TYPE /wav/et_mail_adress.

    METHODS set_mail_address
      IMPORTING im_mail_address TYPE /wav/et_mail_adress.

    METHODS get_name
      RETURNING
        VALUE(re_name) TYPE /wav/et_buyer_name.
    METHODS set_name
      IMPORTING im_name TYPE /wav/et_buyer_name.

    METHODS get_data_id
         REDEFINITION .
    METHODS get_authority_data
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      address      TYPE /wav/et_buyer_adress,
      mail_address TYPE /wav/et_mail_adress,
      name         TYPE /wav/et_buyer_name.

ENDCLASS.



CLASS /wav/clt_sdc_buyer IMPLEMENTATION.

  METHOD get_authority_data.
  ENDMETHOD.

  METHOD get_data_id.
    re_data_id = name.
  ENDMETHOD.

  METHOD get_name.
    re_name = me->name.
  ENDMETHOD.

  METHOD set_name.
    me->name = im_name.
  ENDMETHOD.

  METHOD get_address.
    re_address = address.
  ENDMETHOD.

  METHOD set_address.
    address = im_address.
  ENDMETHOD.

  METHOD get_mail_address.
    re_mail_address = mail_address.
  ENDMETHOD.

  METHOD set_mail_address.
    mail_address = im_mail_address.
  ENDMETHOD.

ENDCLASS.