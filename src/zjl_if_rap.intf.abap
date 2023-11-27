interface ZJL_IF_RAP
  public .


  types:
    tp_xflag TYPE x LENGTH 1 .
  types:
    tpt_message TYPE STANDARD TABLE OF REF TO zjl_cx_behavior WITH EMPTY KEY .

  constants CO_FEATURE_ENABLED type ZJL_ENABLE value '00' ##NO_TEXT.
  constants CO_FEATURE_DISABLED type ZJL_ENABLE value '01' ##NO_TEXT.
  constants CO_FEATURE_MANDATORY type ZJL_ENABLE value '01' ##NO_TEXT.
  constants CO_FEATURE_READONLY type ZJL_ENABLE value '02' ##NO_TEXT.
  constants CO_SEVERITY_ERROR type ZJL_SEVERITY value 'E' ##NO_TEXT.
  constants CO_SEVERITY_INFORMATION type ZJL_SEVERITY value 'I' ##NO_TEXT.
  constants CO_SEVERITY_WARNING type ZJL_SEVERITY value 'W' ##NO_TEXT.
  constants CO_SEVERITY_SUCCESS type ZJL_SEVERITY value 'S' ##NO_TEXT.
  constants CO_MODSTAT_CREATE type ZJL_MODE value 'C' ##NO_TEXT.
  constants CO_MODSTAT_READ type ZJL_MODE value 'R' ##NO_TEXT.
  constants CO_MODSTAT_UPDATE type ZJL_MODE value 'U' ##NO_TEXT.
  constants CO_MODSTAT_DELETE type ZJL_MODE value 'D' ##NO_TEXT.
  constants CO_FEATURE_UPDATE type ZJL_FEATURE value 'Update' ##NO_TEXT.
  constants CO_FEATURE_DELETE type ZJL_FEATURE value 'Delete' ##NO_TEXT.
  constants CO_FEATURE_CREATE type ZJL_FEATURE value 'Create' ##NO_TEXT.
  constants:
    co_msgid TYPE c LENGTH 20 value 'ZJL_RAP' ##NO_TEXT.
  constants CO_DETAIL_LEVEL_1 type BALLEVEL value '1' ##NO_TEXT.
  constants CO_DETAIL_LEVEL_2 type BALLEVEL value '2' ##NO_TEXT.
endinterface.
