CLASS /wav/clt_xgw_seats_available DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_opening_gateway
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_opening_gateway~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_xgw_seats_available IMPLEMENTATION.

  METHOD /wav/if_opening_gateway~execute.

*    DATA(ldc_film_seat) = CAST /wav/clt_ldc_film_seat( CAST /wav/clt_sdc_cin_order( im_data_container )->get_dc_for_cat( '/WAV/LDCT_FILM_SEAT' ) ).

     DATA(sdc_order) = CAST /WAV/CLT_SDC_CIN_ORDER( im_data_container ).


     DATA(ldc_film_seat) = CAST /WAV/CLT_LDC_FILM_SEAT( sdc_order->get_dc_for_cat( '/WAV/LDCT_FILM_SEAT' ) ).

    "Prüfen, ob alle Sitzplätze verfügbar sind
    DATA: everything_available TYPE boolean VALUE abap_true.
    LOOP AT ldc_film_seat->get_tab_dc( ) ASSIGNING FIELD-SYMBOL(<concrete_dc>).
      DATA(seat_dc) = CAST /wav/clt_sdc_film_seat( <concrete_dc> ).
      DATA(seat_number) = seat_dc->get_seat_number( ).
      DATA(seat_row) = seat_dc->get_seat_row( ).
      SELECT SINGLE is_available FROM /wav/tt_cinema WHERE
          seat_number = @seat_number AND
          seat_row = @seat_row INTO @DATA(is_seat_available).

      "Wenn ein Sitzplatz nicht verfügbar ist soll in das Log geschrieben werden
      IF is_seat_available = abap_false.
        everything_available = abap_false.
        seat_dc->set_is_available( abap_false ).
      ELSE.
        seat_dc->set_is_available( abap_true ).
      ENDIF.
    ENDLOOP.

    IF everything_available = abap_false.
      INSERT CONV #( 'NOT_AVAILABLE' ) INTO TABLE re_tab_decision.
    ELSE.
      INSERT CONV #( 'AVAILABLE' ) INTO TABLE re_tab_decision.
    ENDIF.
  ENDMETHOD.
ENDCLASS.