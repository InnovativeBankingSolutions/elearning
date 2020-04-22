CLASS /wav/clt_dmap_cin_ticket_order DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /wav/if_content_implementation .
    INTERFACES /wav/if_fill_dc_with_data .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_dmap_cin_ticket_order IMPLEMENTATION.
  METHOD /wav/if_fill_dc_with_data~fill_dc_with_data.
    FIELD-SYMBOLS <str_order> TYPE /wav/st_order_input.
    ASSIGN im_generic_data TO <str_order>.

    DATA(dc_order) = CAST /wav/clt_sdc_cin_order( im_data_container ).
    dc_order->set_order_number( /wav/cl_timestamp_util=>get_utc_timestamp( ) ).
    dc_order->set_discount_code( <str_order>-discount_code ).

    "Kunden-Datencontainer befüllen
    DATA(sdc_customer) = CAST /wav/clt_sdc_customer( dc_order->get_dc_for_cat( '/WAV/SDCT_CUSTOMER' ) ).
    sdc_customer->set_customer_first_name( <str_order>-first_name ).
    sdc_customer->set_customer_last_name( <str_order>-last_name ).
    sdc_customer->set_customer_number( <str_order>-customer_number ).

    "Liste mit Sitzplätzen befüllen
    DATA(ldc_seat) = CAST /wav/clt_ldc_film_seat( dc_order->get_dc_for_cat( '/WAV/LDCT_FILM_SEAT' ) ).
    LOOP AT <str_order>-tab_seat ASSIGNING FIELD-SYMBOL(<str_seat>).
      DATA(sdc_seat) = CAST /wav/clt_sdc_film_seat( NEW /wav/cl_dc_boundary( )->create( '/WAV/SDCT_FILM_SEAT' ) ).
      sdc_seat->set_seat_row( <str_seat>-seat_row ).
      sdc_seat->set_seat_number( <str_seat>-seat_number ).
      TRY.
          ldc_seat->add_dc( sdc_seat ).
        CATCH /wav/cx_dc_has_wrong_cat.
          "Kann hier nicht vorkommen
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.