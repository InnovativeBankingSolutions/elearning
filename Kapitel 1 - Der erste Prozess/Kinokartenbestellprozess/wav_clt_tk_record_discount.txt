CLASS /wav/clt_tk_record_discount DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_tk_record_discount IMPLEMENTATION.


  METHOD /wav/if_task~execute.
    DATA(sdc_order) = CAST /wav/clt_sdc_cin_order( im_data_container ).

    "Ist ein Rabattcode eingetragen, so wird 10% Rabatt vermerkt
    IF sdc_order->get_discount_code( ) IS NOT INITIAL.
        sdc_order->set_provided_discount( 10 ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.