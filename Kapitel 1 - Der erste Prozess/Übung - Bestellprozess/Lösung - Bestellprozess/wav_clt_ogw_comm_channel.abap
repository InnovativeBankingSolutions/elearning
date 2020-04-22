CLASS /wav/clt_ogw_comm_channel DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_opening_gateway
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_opening_gateway~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_ogw_comm_channel IMPLEMENTATION.


  METHOD /wav/if_opening_gateway~execute.
    DATA(order_sdc) = CAST /wav/clt_sdc_item_order( im_data_container ).

    CASE order_sdc->get_comm_channel( ).
      WHEN 'LETTER'.
        INSERT CONV #( 'LETTER' ) INTO TABLE re_tab_decision.
      WHEN 'MAIL'.
        INSERT CONV #( 'MAIL' ) INTO TABLE re_tab_decision.
      WHEN 'LETTERMAIL'.
        INSERT CONV #( 'LETTER' ) INTO TABLE re_tab_decision.
        INSERT CONV #( 'MAIL' ) INTO TABLE re_tab_decision.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.