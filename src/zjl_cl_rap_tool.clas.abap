class ZJL_CL_RAP_TOOL definition
  public
  final
  create public .

public section.

  class-methods GET_BADI
    importing
      !I_BADI_NAME type ENHBADIID
    returning
      value(RR_BADI) type ref to CL_BADI_BASE
    raising
      ZJL_CX_BEHAVIOR_STATIC_CHECK .
protected section.
private section.
ENDCLASS.



CLASS ZJL_CL_RAP_TOOL IMPLEMENTATION.


  METHOD get_badi.

    GET BADI rr_badi TYPE (i_badi_name).

    IF cl_badi_query=>number_of_implementations( badi = rr_badi ) GT 1.
      RAISE EXCEPTION TYPE zjl_cx_behavior_static_check MESSAGE e010(zjl_rap) WITH i_badi_name.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
