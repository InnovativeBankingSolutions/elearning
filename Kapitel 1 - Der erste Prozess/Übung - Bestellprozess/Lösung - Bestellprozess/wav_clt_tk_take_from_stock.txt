CLASS /wav/clt_tk_take_from_stock DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS /wav/clt_tk_take_from_stock IMPLEMENTATION.

  METHOD /wav/if_task~execute.
    "Ermitteln des Listendatencontainers mit den bestellten Artikeln
    DATA(sdc_order) = CAST /wav/clt_sdc_item_order( im_data_container ).
    DATA(tab_item) = CAST /wav/clt_ldc_item( sdc_order->get_dc_for_cat( '/WAV/LDCT_ITEM' ) )->get_tab_dc( ).

    LOOP AT tab_item ASSIGNING FIELD-SYMBOL(<item>).
      DATA(sdc_item) = CAST /wav/clt_sdc_item( <item> ).

      "An dieser Stelle erfolgt der Zugriff auf die Datenbank - alternativ über ein DAO, dass den Datenbankzugriff ersetzt.
      NEW /wav/clt_item_stock_dao( )->reduce_stock_for_item_number(
          im_item_number = sdc_item->get_item_number( )
          im_count       = sdc_item->get_item_count( ) ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.