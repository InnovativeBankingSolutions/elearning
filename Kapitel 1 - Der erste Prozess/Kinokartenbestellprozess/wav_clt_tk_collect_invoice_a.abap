CLASS /wav/clt_tk_collect_invoice_a DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_tk_collect_invoice_a IMPLEMENTATION.


  METHOD /wav/if_task~execute.
    DATA(sdc_order) = CAST /wav/clt_sdc_cin_order( im_data_container ).

    "Anzahl der Tickets ermitteln
    DATA(ldc_seat) = CAST /wav/clt_ldc_film_seat(  sdc_order->get_dc_for_cat( '/WAV/LDCT_FILM_SEAT' ) ).
    DATA(amount) = lines( ldc_seat->get_tab_dc( ) ).

    "Ein Ticket kostet 13.50 €
    DATA: sum TYPE /wav/et_ticket_order_sum.
    sum = amount * '13.50'.

    IF sdc_order->get_discount_code( ) IS NOT INITIAL.
      "Rabatt verrechnen
      DATA(discount) =  ( sum * sdc_order->get_provided_discount( ) ) / 100.
      sum = sum - discount.
    ENDIF.

    "Kunde ermitteln
    DATA(sdc_customer) = CAST /wav/clt_sdc_customer( sdc_order->get_dc_for_cat( '/WAV/SDCT_CUSTOMER' ) ).

    NEW /wav/clt_banking_connector( )->invoice(
        im_amount          =  sum
        im_customer_number = sdc_customer->get_customer_number( ) ).
  ENDMETHOD.
ENDCLASS.