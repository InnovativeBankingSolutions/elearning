CLASS /wav/clt_tk_log_seats_not_av DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_tk_log_seats_not_av IMPLEMENTATION.
  METHOD /wav/if_task~execute.
    DATA(sdc_order) = CAST /wav/clt_sdc_cin_order( im_data_container ).

    DATA(sdc_customer) = CAST /wav/clt_sdc_customer( sdc_order->get_dc_for_cat( '/WAV/SDCT_CUSTOMER' ) ).
    DATA(ldc_seat) = CAST /wav/clt_ldc_film_seat(  sdc_order->get_dc_for_cat( '/WAV/LDCT_FILM_SEAT' ) ).

    LOOP AT ldc_seat->get_tab_dc( ) ASSIGNING FIELD-SYMBOL(<concrete_dc>).
      DATA(seat_dc) = CAST /wav/clt_sdc_film_seat( <concrete_dc> ).
      IF seat_dc->is_available( ) = abap_false.
        "Für den Kunden &1 &2 mit der Nummer &3 ist der Platz &4 nicht verfügbar
        DATA(seat_id) = seat_dc->get_seat_row( ) && seat_dc->get_seat_number( ).
        log_session->add_message(
            im_message_type      =  /wav/co_msg_type=>error
            im_message_class     =  '/WAV/MCT_TICKT_ORDR'
            im_message_number    =  001
            im_message_variable1 =  sdc_customer->get_customer_first_name( )
            im_message_variable2 =  sdc_customer->get_customer_last_name( )
            im_message_variable3 =  CONV #( sdc_customer->get_customer_number( ) )
            im_message_variable4 =  CONV #( seat_id ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.