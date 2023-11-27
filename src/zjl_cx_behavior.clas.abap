CLASS zjl_cx_behavior DEFINITION
  PUBLIC
  INHERITING FROM cx_no_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    INTERFACES if_abap_behv_message .

    DATA o_uifield TYPE zjl_uifield .

    CONSTANTS: BEGIN OF co_err_unknown,
                 msgid TYPE symsgid VALUE 'ZJL_RAP',
                 msgno TYPE symsgno VALUE '003',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF co_err_unknown.

    CONSTANTS: BEGIN OF co_err_number_range,
                 msgid TYPE symsgid VALUE 'ZJL_RAP',
                 msgno TYPE symsgno VALUE '011',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF co_err_number_range.

    METHODS constructor
      IMPORTING
        !severity TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !uifield  TYPE zjl_uifield OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zjl_cx_behavior IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    o_uifield  = uifield.

    CLEAR me->textid.

    me->if_abap_behv_message~m_severity = severity.

    IF NOT textid IS INITIAL.
      if_t100_message~t100key = textid.
      RETURN.
    ENDIF.

    IF NOT sy-msgid IS INITIAL
    OR NOT sy-msgno IS INITIAL.
      if_t100_message~t100key-msgid = sy-msgid.
      if_t100_message~t100key-msgno = sy-msgno.
      if_t100_message~t100key-attr1 = sy-msgv1.
      if_t100_message~t100key-attr2 = sy-msgv2.
      if_t100_message~t100key-attr3 = sy-msgv3.
      if_t100_message~t100key-attr4 = sy-msgv4.
      RETURN.
    ENDIF.

    if_t100_message~t100key = if_t100_message=>default_textid.

  ENDMETHOD.
ENDCLASS.
