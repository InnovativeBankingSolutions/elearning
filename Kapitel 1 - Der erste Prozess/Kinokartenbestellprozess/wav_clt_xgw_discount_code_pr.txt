CLASS /wav/clt_xgw_discount_code_pr DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_opening_gateway
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_opening_gateway~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_xgw_discount_code_pr IMPLEMENTATION.


  METHOD /wav/if_opening_gateway~execute.
    DATA(order_sdc) = CAST /wav/clt_sdc_cin_order( im_data_container ).

    "Einfachheitshalber wird geprüft, ob irgeindein Code eingegeben wurde
    IF order_sdc->get_discount_code( ) IS INITIAL.
      INSERT CONV #( 'NO_CODE_PROVIDED' ) INTO TABLE re_tab_decision.
    ELSE.
      INSERT CONV #( 'CODE_PROVIDED' ) INTO TABLE re_tab_decision.
    ENDIF.
  ENDMETHOD.
ENDCLASS.