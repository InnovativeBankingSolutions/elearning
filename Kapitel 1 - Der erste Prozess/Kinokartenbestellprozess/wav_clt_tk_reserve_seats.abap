CLASS /wav/clt_tk_reserve_seats DEFINITION
  PUBLIC
  INHERITING FROM /wav/cl_task
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /wav/if_task~execute
         REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /wav/clt_tk_reserve_seats IMPLEMENTATION.


  METHOD /wav/if_task~execute.
    "In dieser Aktivität kommt (gemäß Signatur im Customizing) der Listendatencontainer für Sitzplätze an.
    DATA(dc) = CAST /wav/clt_ldc_film_seat( im_data_container ).
    DATA(tab_sdc_seat) = dc->get_tab_dc( ).

    LOOP AT tab_sdc_seat ASSIGNING FIELD-SYMBOL(<concrete_dc>).
      DATA(sdc_seat) = CAST /wav/clt_sdc_film_seat( <concrete_dc> ).
      DATA(seat_row) = sdc_seat->get_seat_row( ).
      DATA(seat_number) = sdc_seat->get_seat_number( ).

      UPDATE /WAV/TT_CINEMA SET is_available = ABAP_FALSE WHERE seat_number = seat_number AND seat_row = seat_row.
      "Aus Einfachheitsgründne  prüfen wir hier nicht nach, ob ein Fehler bei dem Update passiert.
      "Diese Aktivität  kann aufgrund der eignenen Signatur auch in anderen Prozessen verwendet werden - in diesem
      "globalen Prozess haben wir allerdings im Vorfeld schon geprüft, ob der Sitzplatz frei ist. Für das Beispiel sind wir
      "also sicher, dass die Sitzplätze an dieser Stelle frei sind.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.