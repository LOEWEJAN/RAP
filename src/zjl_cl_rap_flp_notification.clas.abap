class ZJL_CL_RAP_FLP_NOTIFICATION definition
  public
  final
  create public .

public section.

  interfaces /IWNGW/IF_NOTIF_PROVIDER .

  constants CO_TYPE_KEY_BATCHEVENT type /IWNGW/NOTIFICATION_TYPE_KEY value 'BatchEventRaised' ##NO_TEXT.
  constants CO_PARAM_NAME_EVENTID type /IWNGW/IF_NOTIF_PROVIDER=>TY_S_NOTIFICATION_TYPE_ID-TYPE_KEY value 'EventID' ##NO_TEXT.
  constants CO_PARAM_NAME_EVENTPARAM type /IWNGW/IF_NOTIF_PROVIDER=>TY_S_NOTIFICATION_TYPE_ID-TYPE_KEY value 'EventParameter' ##NO_TEXT.
  constants CO_PROVIDER_ID type /IWNGW/IF_NOTIF_PROVIDER=>TY_S_PROVIDER-ID value 'ZMSGPIA' ##NO_TEXT.
  constants CO_TYPE_KEY_FREETEXT type /IWNGW/NOTIFICATION_TYPE_KEY value 'FreeTextNotification' ##NO_TEXT.
  constants CO_PARAM_NAME_TEXT01 type /IWNGW/IF_NOTIF_PROVIDER=>TY_S_NOTIFICATION_TYPE_ID-TYPE_KEY value 'Text01' ##NO_TEXT.
  constants CO_PARAM_NAME_USER type /IWNGW/IF_NOTIF_PROVIDER=>TY_S_NOTIFICATION_TYPE_ID-TYPE_KEY value 'User' ##NO_TEXT.
  constants CO_PARAM_NAME_TEXT02 type /IWNGW/IF_NOTIF_PROVIDER=>TY_S_NOTIFICATION_TYPE_ID-TYPE_KEY value 'Text02' ##NO_TEXT.
  PROTECTED SECTION.
private section.
ENDCLASS.



CLASS ZJL_CL_RAP_FLP_NOTIFICATION IMPLEMENTATION.


  METHOD /IWNGW/IF_NOTIF_PROVIDER~GET_NOTIFICATION_PARAMETERS.

    CLEAR et_parameter.

    DATA(l_langu) = sy-langu.

    SET LANGUAGE iv_language.

    CASE iv_type_key.
      WHEN co_type_key_batchevent.
        et_parameter = VALUE #( ( name         = co_param_name_eventid
                                  type         = /iwngw/if_notif_provider=>gcs_parameter_types-type_string
                                  is_sensitive = abap_true )
                                ( name         = co_param_name_eventparam
                                  type         = /iwngw/if_notif_provider=>gcs_parameter_types-type_string
                                  is_sensitive = abap_true )
                               ).
      WHEN co_type_key_freetext.
        et_parameter = VALUE #( ( name         = co_param_name_text01
                                  type         = /iwngw/if_notif_provider=>gcs_parameter_types-type_string
                                  is_sensitive = abap_false )
                                ( name         = co_param_name_text02
                                  type         = /iwngw/if_notif_provider=>gcs_parameter_types-type_string
                                  is_sensitive = abap_false )
                                ( name         = co_param_name_user
                                  type         = /iwngw/if_notif_provider=>gcs_parameter_types-type_string
                                  is_sensitive = abap_true )
                               ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE /iwngw/cx_notif_provider.
    ENDCASE.

    SET LANGUAGE l_langu.

  ENDMETHOD.


  METHOD /IWNGW/IF_NOTIF_PROVIDER~GET_NOTIFICATION_TYPE.

    CLEAR: es_notification_type.
    clear: et_notification_action.

    CASE iv_type_key.
      WHEN co_type_key_batchevent.
        es_notification_type-version      = iv_type_version.
        es_notification_type-type_key     = iv_type_key.
        es_notification_type-is_groupable = abap_true.
      WHEN co_type_key_freetext.
        es_notification_type-version      = iv_type_version.
        es_notification_type-type_key     = iv_type_key.
        es_notification_type-is_groupable = abap_false.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE /iwngw/cx_notif_provider.
    ENDCASE.

  ENDMETHOD.


  METHOD /IWNGW/IF_NOTIF_PROVIDER~GET_NOTIFICATION_TYPE_TEXT.

    CLEAR: es_type_text.
    CLEAR: et_action_text.

    DATA(l_langu) = sy-langu.

    SET LANGUAGE iv_language.

    es_type_text-template_grouped = iv_type_key.

    CASE iv_type_key.
      WHEN co_type_key_batchevent.
        es_type_text-template_public  = ''.
        es_type_text-description      = 'Batch Ereignis wurde ausgelöst'(029).
*       es_type_text-subtitle         = ''.
        MESSAGE ID '/ALICE/Z' TYPE 'I' NUMBER 007
                WITH 'Ereignis:'(027)
                     '{' && co_param_name_eventid && '}'
                     'Parameter:'(028)
                     '{' && co_param_name_eventparam && '}'
                INTO es_type_text-template_sensitive.

      WHEN co_type_key_freetext.
        es_type_text-template_public    = ''.
        es_type_text-description        = 'Persönliche Nachricht'(030).
        MESSAGE ID '/ALICE/Z' TYPE 'I' NUMBER 007
                WITH '{' && co_param_name_user && '}'
                     'sagt:'(031)
                     '{' && co_param_name_text01 && '}'
                     '{' && co_param_name_text02 && '}'
                INTO es_type_text-template_sensitive.


      WHEN OTHERS.
        RAISE EXCEPTION TYPE /iwngw/cx_notif_provider.

    ENDCASE.

    SET LANGUAGE l_langu.

  ENDMETHOD.


  METHOD /IWNGW/IF_NOTIF_PROVIDER~HANDLE_ACTION.

    CLEAR es_result.

* For now always return success if IDs are set, no persistence in this test provider
    IF iv_notification_id IS INITIAL.
      es_result-success = abap_false.
      es_result-action_msg_txt = TEXT-a01.
    ELSEIF iv_action_key IS INITIAL.
      es_result-success = abap_false.
      es_result-action_msg_txt = TEXT-a02.
    ELSE.
      CASE iv_action_key.
          " Handle action
        WHEN OTHERS.
      ENDCASE.
      es_result-success          = abap_true.
      es_result-delete_on_return = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD /IWNGW/IF_NOTIF_PROVIDER~HANDLE_BULK_ACTION.

    CLEAR et_notif_result.

    LOOP AT it_bulk_notif ASSIGNING FIELD-SYMBOL(<ls_bulk_notif>).

      IF <ls_bulk_notif>-id IS INITIAL.
        APPEND VALUE #( id               = space
                        success          = abap_false
                        delete_on_return = abap_false
                      ) TO et_notif_result.
        CONTINUE.
      ENDIF.

      CASE <ls_bulk_notif>-action_key.
          "handle action
        WHEN OTHERS.
          APPEND VALUE #( id               = <ls_bulk_notif>-id
                          type_key         = <ls_bulk_notif>-type_key
                          type_version     = <ls_bulk_notif>-type_version
                          success          = abap_false
                          delete_on_return = abap_false
                         ) TO et_notif_result.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
