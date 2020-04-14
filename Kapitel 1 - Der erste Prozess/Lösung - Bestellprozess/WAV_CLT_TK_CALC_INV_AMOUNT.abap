CLASS /wav/clt_tk_calc_inv_amount DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: /wav/if_task~execute REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS /wav/clt_tk_calc_inv_amount IMPLEMENTATION.

  METHOD /wav/if_task~execute.
    DATA(sdc_order) = CAST /wav/clt_sdc_item_order( im_data_container ).
    DATA(tab_item) = CAST /wav/clt_ldc_item( sdc_order->get_dc_for_cat( '/WAV/LDCT_ITEM' ) )->get_tab_dc( ).

    DATA: max_sum TYPE /wav/et_item_price.
    LOOP AT tab_item ASSIGNING FIELD-SYMBOL(<item>).
      DATA(sdc_item) = CAST /wav/clt_sdc_item( <item> ).
      max_sum = max_sum + ( sdc_item->get_item_price( ) * sdc_item->get_item_count( ) ).
    ENDLOOP.

    DATA(invoice_amount) = max_sum - ( ( max_sum * sdc_order->get_order_discount( ) ) / 100 ).

    "Die Gesamthöhe (inkl. errechneter Rabatt) wird am Datencontainer vermerkt
    sdc_order->set_invoice_amount( CONV #( invoice_amount ) ).
  ENDMETHOD.

ENDCLASS.