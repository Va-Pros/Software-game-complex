#include "utils/enums.h"

Role::Role() : value(Role::UNDEFINED) {}
Role::Role(Role::RoleEnum role) : value(role) {}

QString Role::rolesStrings[] = {QString("Attacker"), QString("Defender"), QString("Undefined")};

Role::RoleEnum Role::getRole() { return value; }
void Role::setRole(RoleEnum role) { value = role; }
QString Role::toString() { return rolesStrings[value]; }
