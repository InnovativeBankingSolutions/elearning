CLASS /wav/clt_order_exercise_map DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /wav/if_content_implementation .
    INTERFACES /wav/if_fill_dc_with_data .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_order_exercise_map IMPLEMENTATION.


  METHOD /wav/if_fill_dc_with_data~fill_dc_with_data.
    FIELD-SYMBOLS <str_input_data> TYPE /wav/st_item_order_input_data.

    ASSIGN im_generic_data TO <str_input_data>.
    DATA(dc) = CAST /wav/clt_sdc_item_order( im_data_container ).

    dc->set_comm_channel( <str_input_data>-comm_channel ).
    DATA(buyer_dc) = CAST /wav/clt_sdc_buyer( dc->get_dc_for_cat( '/WAV/SDCT_BUYER' ) ).
    buyer_dc->set_address( <str_input_data>-address ).
    buyer_dc->set_mail_address( <str_input_data>-mail_address ).
    buyer_dc->set_name( <str_input_data>-name ).

    DATA(item_list_dc) = CAST /wav/clt_ldc_item( dc->get_dc_for_cat( '/WAV/LDCT_ITEM' ) ).

    LOOP AT <str_input_data>-tab_item ASSIGNING FIELD-SYMBOL(<str_item>).
      DATA(item_dc) = CAST /wav/clt_sdc_item( NEW /wav/cl_dc_boundary( )->create( '/WAV/SDCT_ITEM' ) ).

      item_dc->set_item_count( <str_item>-item_count ).
      item_dc->set_item_number( <str_item>-item_number ).

      item_list_dc->add_dc( item_dc ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.