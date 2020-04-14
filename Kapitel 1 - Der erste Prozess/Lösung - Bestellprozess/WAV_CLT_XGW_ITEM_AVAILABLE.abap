CLASS /wav/clt_xgw_item_available DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_opening_gateway
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_opening_gateway~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_xgw_item_available IMPLEMENTATION.


  METHOD /wav/if_opening_gateway~execute.
    DATA(sdc_order) = CAST /wav/clt_sdc_item_order( im_data_container ).
    DATA(tab_item) = CAST /wav/clt_ldc_item( sdc_order->get_dc_for_cat( '/WAV/LDCT_ITEM' ) )->get_tab_dc( ).

    DATA: one_item_unavailable TYPE boolean VALUE abap_false.
    LOOP AT tab_item ASSIGNING FIELD-SYMBOL(<item>).
      DATA(sdc_item) = CAST /wav/clt_sdc_item( <item> ).
      DATA(item_count) = NEW /wav/clt_item_stock_dao( )->get_stock_cnt_for_item_number( sdc_item->get_item_number( ) ).
      IF item_count <= 0.
        sdc_item->set_is_available( abap_false ).
        one_item_unavailable = abap_true.
      ELSE.
        sdc_item->set_is_available( abap_true ).
      ENDIF.
    ENDLOOP.

    IF one_item_unavailable = abap_true.
      INSERT CONV #( 'NOT_AVAILABLE' ) INTO TABLE re_tab_decision.
    ELSE.
      INSERT CONV #( 'AVAILABLE' ) INTO TABLE re_tab_decision.
    ENDIF.

  ENDMETHOD.
ENDCLASS.