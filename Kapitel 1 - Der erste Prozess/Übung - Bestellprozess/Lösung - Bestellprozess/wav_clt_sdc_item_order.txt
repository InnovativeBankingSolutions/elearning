CLASS /wav/clt_sdc_item_order DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_single_data_container
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_data_id
         REDEFINITION .
    METHODS get_authority_data
         REDEFINITION .

    METHODS get_order_discount
      RETURNING VALUE(re_order_discount) TYPE /wav/et_order_discount.

    METHODS set_order_discount
      IMPORTING im_order_discount TYPE /wav/et_order_discount.

    METHODS set_invoice_amount
      IMPORTING im_invoice_amount TYPE /wav/et_item_price.

    METHODS get_invoice_amount
      RETURNING VALUE(re_invoice_amount) TYPE /wav/et_item_price.

    METHODS set_comm_channel
      IMPORTING im_comm_channel TYPE /wav/et_comm_channel.

    METHODS get_comm_channel
      RETURNING VALUE(re_comm_channel) TYPE /wav/et_comm_channel.



  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: order_discount        TYPE /wav/et_order_discount,
          invoice_amount        TYPE /wav/et_item_price,
          communication_channel TYPE /wav/et_comm_channel.


ENDCLASS.



CLASS /wav/clt_sdc_item_order IMPLEMENTATION.


  METHOD get_authority_data.
  ENDMETHOD.


  METHOD get_data_id.
  ENDMETHOD.

  METHOD get_order_discount.
    re_order_discount = order_discount.
  ENDMETHOD.

  METHOD set_order_discount.
    order_discount = im_order_discount.
  ENDMETHOD.

  METHOD set_invoice_amount.
    invoice_amount = im_invoice_amount.
  ENDMETHOD.

  METHOD get_invoice_amount.
    re_invoice_amount =  invoice_amount.
  ENDMETHOD.

  METHOD set_comm_channel.
    communication_channel = im_comm_channel.
  ENDMETHOD.

  METHOD get_comm_channel.
    re_comm_channel = communication_channel.
  ENDMETHOD.

ENDCLASS.