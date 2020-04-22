CLASS /wav/clt_tk_send_bill_letter DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS /wav/clt_tk_send_bill_letter IMPLEMENTATION.

  METHOD /wav/if_task~execute.
    DATA(sdc_order) = CAST /wav/clt_sdc_item_order( im_data_container ).
    DATA(sdc_buyer) = CAST /wav/clt_sdc_buyer( sdc_order->get_dc_for_cat( '/WAV/SDCT_BUYER ' ) ).

    "Die Rechnung in Höhe von &1 wurde per Brief an &2 &3 versendet
    log_session->add_message(
      EXPORTING
        im_message_type      = /wav/co_message_type=>success
        im_message_class     = '/WAV/MCT_ORDER'
        im_message_number    = 003
        im_message_variable1 = CONV #( sdc_order->get_invoice_amount( ) )
        im_message_variable2 = sdc_buyer->get_address( ) ).
  ENDMETHOD.
ENDCLASS.