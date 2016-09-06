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

// this function gets the attenuation value relative *from* the provided unit *to* the acre_player
// e.g. what the local acre_player attenuation scale value is.
// returns 0-1

private _listener = acre_player;
params ["_speaker"];
private _attenuate = 0;

private _vehListener = vehicle _listener;
private _vehSpeaker = vehicle _speaker;

if(_vehListener == _vehSpeaker) then {
    private _listenerTurnedOut = isTurnedOut _listener;
    private _speakerTurnedOut = isTurnedOut _speaker;
    if(!(_listenerTurnedOut && _speakerTurnedOut)) then {

        private _listenerCompartment = [_listener] call EFUNC(lib,getCompartment);
        private _speakerCompartment = [_speaker] call EFUNC(lib,getCompartment);
        if(_speakerCompartment != _listenerCompartment) then {
            // acre_player sideChat format["1 lc: %1 sc: %2 %3", _listenerCompartment, _speakerCompartment, (getNumber(configFile >> "CfgVehicles" >> (typeOf _vehListener) >> "ACRE" >> "attenuation" >> _speakerCompartment >> _listenerCompartment))];
            _attenuate = ((getNumber(configFile >> "CfgVehicles" >> (typeOf _vehListener) >> "ACRE" >> "attenuation" >> _speakerCompartment >> _listenerCompartment)));
        };
        if(_speakerTurnedOut || _listenerTurnedOut) then {
            // acre_player sideChat format["2 lc: %1 sc: %2 %3", _listenerCompartment, _speakerCompartment, (getNumber(configFile >> "CfgVehicles" >> (typeOf _vehListener) >> "ACRE" >> "attenuation" >> _speakerCompartment >> _listenerCompartment))];
            _attenuate = ([_listener] call FUNC(getVehicleAttenuation))*0.5;
        };
    };
} else {
    if(_vehListener != _listener) then {
        private _listenerTurnedOut = isTurnedOut _listener;
        if(!_listenerTurnedOut) then {
            // acre_player sideChat format["1 %1 %2", _attenuate, (1-(getNumber(configFile >> "CfgVehicles" >> (typeOf (vehicle _listener)) >> "insideSoundCoef")))];
            _attenuate = _attenuate + ([_listener] call FUNC(getVehicleAttenuation)); //((getNumber(configFile >> "CfgVehicles" >> (typeOf _vehListener) >> "insideSoundCoef")));
        };
    };
    if(_vehSpeaker != _speaker) then {
        private _speakerTurnedOut = isTurnedOut _speaker;
        if(!_speakerTurnedOut) then {
            // acre_player sideChat format["2 %1 %2", _attenuate, (1-(getNumber(configFile >> "CfgVehicles" >> (typeOf (vehicle _speaker)) >> "insideSoundCoef")))];
            _attenuate = _attenuate + ([_speaker] call FUNC(getVehicleAttenuation)); //((getNumber(configFile >> "CfgVehicles" >> (typeOf _vehSpeaker) >> "insideSoundCoef")));
        };
    };
};

(_attenuate min 1);
