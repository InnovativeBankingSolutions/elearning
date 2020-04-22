*&---------------------------------------------------------------------*
*& Report  /wav/rt_start_cin_ticket_order
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT /wav/rt_start_cin_ticket_order.

TRY.
    /wav/cl_authority_util=>check_authority_for_report( sy-repid ).


    DATA(tab_seat_to_reserve) = VALUE /wav/tyht_seat(
                                   ( seat_row = 'D' seat_number = '4' )
                                   ( seat_row = 'D' seat_number = '5' )
                                   ( seat_row = 'E' seat_number = '4' )
                                   ( seat_row = 'E' seat_number = '5' ) ).


    DATA(str_order) = VALUE /wav/st_order_input(
       first_name       = 'Alex'
       last_name        = 'Beispiel'
       customer_number  = '42'
       discount_code    = 'RABATT2020'
       tab_seat         = tab_seat_to_reserve ).


    NEW /wav/cl_process_start_boundary( )->start_process(
            EXPORTING
                im_process_id            = '/WAV/PRT_CINEMA_TICKET_ORDER'
                im_generic_data          = str_order
            IMPORTING
                ex_process_run_id        = DATA(process_run_id)
                ex_data_container        = DATA(dc) ).

    WRITE 'Pozesslauf-ID des Hauptprozesses:' && ` ` && process_run_id.

  CATCH /wav/cx_framework INTO DATA(cx).
    /wav/cl_show_popup=>display_exception_in_popup( cx ).
ENDTRY.