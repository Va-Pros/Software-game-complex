function mapModel(model, mapFunction) {
    if (Array.isArray(model)) return model.map(mapFunction)
    const mapped = [];
    for (var i = 0; i < model.count; i++) {
        mapped.push(mapFunction(model.get(i)));
    }
    return mapped;
}

function findIndexInModel(model, filterFunction) {
    for (var i = 0; i < model.count; i++) {
        const item = model.get(i);
        if (filterFunction(item)) return i;
    }
    return -1;
}

function findInModel(model, filterFunction) {
    for (var i = 0; i < model.count; i++) {
        const item = model.get(i);
        if (filterFunction(item)) return item;
    }
    return undefined;
}


function findAllIndicesInModel(model, filterFunction) {
    const mapped = [];
    for (var i = 0; i < model.count; i++) {
        const item = model.get(i);
        if (filterFunction(item)) mapped.push(i);
    }
    return mapped;
}

function findAllInModel(model, filterFunction) {
    const mapped = [];
    for (var i = 0; i < model.count; i++) {
        const item = model.get(i);
        if (filterFunction(item)) mapped.push(item);
    }
    return mapped;
}
