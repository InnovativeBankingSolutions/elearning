CLASS /wav/clt_tk_determine_discount DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS /wav/clt_tk_determine_discount IMPLEMENTATION.

  METHOD /wav/if_task~execute.
    "Ermitteln des Listendatencontainers mit den bestellten Artikeln
    DATA(sdc_order) = CAST /wav/clt_sdc_item_order( im_data_container ).
    DATA(tab_item) = CAST /wav/clt_ldc_item( sdc_order->get_dc_for_cat( '/WAV/LDCT_ITEM' ) )->get_tab_dc( ).

    DATA: max_sum TYPE /wav/et_item_price.
    LOOP AT tab_item ASSIGNING FIELD-SYMBOL(<item>).
      DATA(sdc_item) = CAST /wav/clt_sdc_item( <item> ).
      max_sum = max_sum + ( sdc_item->get_item_price( ) * sdc_item->get_item_count( ) ).
    ENDLOOP.

    "Je nach Einkaufspreis wird ein Rabatt vermerkt
    IF max_sum >= 100 AND max_sum < 300.
        sdc_order->set_order_discount( 10 ).
    ELSEIF max_sum >= 300 AND max_sum < 500.
        sdc_order->set_order_discount( 15 ).
    ELSEIF max_sum >= 500.
        sdc_order->set_order_discount( 20 ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.