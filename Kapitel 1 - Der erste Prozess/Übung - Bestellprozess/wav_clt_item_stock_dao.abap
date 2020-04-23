CLASS /wav/clt_item_stock_dao DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_stock_cnt_for_item_number
      IMPORTING
        im_item_number        TYPE /wav/et_item_number
      RETURNING
        VALUE(re_stock_count) TYPE /wav/et_item_count.

    METHODS reduce_stock_for_item_number
      IMPORTING
        !im_item_number TYPE /wav/et_item_number
        !im_count       TYPE /wav/et_item_count.

    METHODS get_item_price
      IMPORTING
        im_item_number       TYPE /wav/et_item_number
      RETURNING
        VALUE(re_item_price) TYPE /wav/et_item_price.

    METHODS constructor.

  PROTECTED SECTION.

  PRIVATE SECTION.


    DATA: tab_item_stock TYPE /wav/tyht_item_stock.
ENDCLASS.



CLASS /wav/clt_item_stock_dao IMPLEMENTATION.
  METHOD constructor.
    DATA str_item_stock TYPE /wav/st_item_stock.

    str_item_stock-item_number = '1'.
    str_item_stock-item_stock_count = 7.
    str_item_stock-item_price = 75.
    str_item_stock-item_currency = 'EUR'.
    INSERT str_item_stock INTO TABLE tab_item_stock.

    str_item_stock-item_number = '2'.
    str_item_stock-item_stock_count = 100.
    str_item_stock-item_price = 20.
    str_item_stock-item_currency = 'EUR'.
    INSERT str_item_stock INTO TABLE tab_item_stock.

    str_item_stock-item_number = '3'.
    str_item_stock-item_stock_count = 25.
    str_item_stock-item_price = 100.
    str_item_stock-item_currency = 'EUR'.
    INSERT str_item_stock INTO TABLE tab_item_stock.

    str_item_stock-item_number = '4'.
    str_item_stock-item_stock_count = 1.
    str_item_stock-item_price = 5.
    str_item_stock-item_currency = 'EUR'.
    INSERT str_item_stock INTO TABLE tab_item_stock.

    str_item_stock-item_number = '5'.
    str_item_stock-item_stock_count = 0.
    str_item_stock-item_price = 120.
    str_item_stock-item_currency = 'EUR'.
    INSERT str_item_stock INTO TABLE tab_item_stock.

  ENDMETHOD.

  METHOD get_stock_cnt_for_item_number.
    READ TABLE tab_item_stock ASSIGNING FIELD-SYMBOL(<str_item_stock>) WITH TABLE KEY item_number = im_item_number.
    IF sy-subrc = 0.
      re_stock_count = <str_item_stock>-item_stock_count.
    ENDIF.
  ENDMETHOD.

  METHOD reduce_stock_for_item_number.
    READ TABLE tab_item_stock ASSIGNING FIELD-SYMBOL(<str_item_stock>) WITH TABLE KEY item_number = im_item_number.

    "Aus Vereinfachungsgründen wird hier einfach die Menge abgezogen, ohne eine Fehlermeldung auszugeben.
    <str_item_stock>-item_stock_count = <str_item_stock>-item_stock_count - im_count.
  ENDMETHOD.

  METHOD get_item_price.
    READ TABLE tab_item_stock ASSIGNING FIELD-SYMBOL(<str_item_stock>) WITH TABLE KEY item_number = im_item_number.
    re_item_price = <str_item_stock>-item_price.
  ENDMETHOD.

ENDCLASS.