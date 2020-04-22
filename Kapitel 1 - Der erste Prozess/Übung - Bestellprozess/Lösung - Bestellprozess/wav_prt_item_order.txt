REPORT /wav/prt_item_order.

TRY.
    /wav/cl_authority_util=>check_authority_for_report( sy-repid ).

    DATA str_input_data TYPE /wav/st_item_order_input_data.
    str_input_data-name = 'Bärbel Beispiel'.
    str_input_data-address = '12345 Beispielhausen'.
    str_input_data-comm_channel = 'LETTERMAIL'.
    str_input_data-tab_item = VALUE #( ( item_number = 1 item_count = 2 ) ( item_number = 2 item_count = 10 ) ).
    str_input_data-mail_address = 'bbeispiel@ibs-banking.com'.

    NEW /wav/cl_process_start_boundary( )->start_process(
        EXPORTING
            im_process_id = '/WAV/PRT_ITEM_ORDER'
            im_generic_data = str_input_data
        IMPORTING
            ex_process_run_id        = DATA(process_run_id)
            ex_data_container        = DATA(dc)
            ex_is_passed_through     = DATA(is_passed_through)
            ex_tab_message           = DATA(tab_message)
            ex_prun_info_state_graph = DATA(prun_info_graph) ).

    NEW /wav/cl_log_boundary( )->display_session( prun_info_graph->get_main_log_session( )->get_session_id( ) ).

  CATCH /wav/cx_framework INTO DATA(cx).
    /wav/cl_show_popup=>display_exception_in_popup( cx ).
ENDTRY.