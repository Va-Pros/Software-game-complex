//
// Created by arti1208 on 14.04.2022.
//

#include "SimpleProtectionTool.h"

SimpleProtectionTool::SimpleProtectionTool(const QString& type) : type(type){}

QString SimpleProtectionTool::getSubtype(){
    return type;
}
