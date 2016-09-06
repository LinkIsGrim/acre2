/*
 * Author: ACRE2Team
 * SHORT DESCRIPTION
 *
 * Arguments:
 * 0: ARGUMENT ONE <TYPE>
 * 1: ARGUMENT TWO <TYPE>
 *
 * Return Value:
 * RETURN VALUE <TYPE>
 *
 * Example:
 * [ARGUMENTS] call acre_COMPONENT_fnc_FUNCTIONNAME
 *
 * Public: No
 */
 
#include "script_component.hpp"

/*
 *  This function returns if the radios internal
 *  speaker is active.
 *
 *  Type of Event:
 *      Data
 *  Event:
 *      isExternalAudio
 *  Event raised by:
 *      - Several functions
 *
 *  Parsed parameters:
 *      0:  Radio ID
 *      1:  Event (-> "isExternalAudio")
 *      2:  Eventdata (-> [])
 *      3:  Radiodata
 *      4:  Remote Call (-> false)
 *
 *  Returned parameters:
 *      current volume (to the power of 3
 *      for cubic function)
*/


params ["_radioId", "_event", "_eventData", "_radioData"];

(HASH_GET(_radioData, "audioPath") == "INTSPEAKER")
