CLASS /wav/clt_tk_log_not_available DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_tk_log_not_available IMPLEMENTATION.


  METHOD /wav/if_task~execute.

    "Ermitteln des Listendatencontainers mit den bestellten Artikeln
    DATA(sdc_order) = CAST /wav/clt_sdc_item_order( im_data_container ).
    DATA(tab_item) = CAST /wav/clt_ldc_item( sdc_order->get_dc_for_cat( '/WAV/LDCT_ITEM' ) )->get_tab_dc( ).

    LOOP AT tab_item ASSIGNING FIELD-SYMBOL(<item>).
      DATA(sdc_item) = CAST /wav/clt_sdc_item( <item> ).

      IF NOT sdc_item->get_is_available( ).
        "Der Artikel &1  ist nicht mehr ausreichend verfügbar
        log_session->add_message(
          EXPORTING
            im_message_type      = /wav/co_message_type=>error
            im_message_class     = '/WAV/MCT_ORDER'
            im_message_number    =  001
            im_message_variable1 =  conv #( sdc_item->get_item_number( ) ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.