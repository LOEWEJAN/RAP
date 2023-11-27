class ZJL_CX_BEHAVIOR_STATIC_CHECK definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_MESSAGE .
  interfaces IF_T100_DYN_MSG .
  interfaces IF_ABAP_BEHV_MESSAGE .

  data O_UIFIELD type ZJL_UIFIELD .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !O_UIFIELD type ZJL_UIFIELD optional .
protected section.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZJL_CX_BEHAVIOR_STATIC_CHECK IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->O_UIFIELD = O_UIFIELD .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
