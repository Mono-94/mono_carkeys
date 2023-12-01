function Text(key, ...)
    local translation = Carkey.Locales[Carkey.Lang][key]
    if translation then
        return (translation):format(...)
    else
        return 'Not locale: ' .. key
    end
end

Carkey.Locales = {
    ['ES'] = {
        VehicleOpen = 'Vehículo abierto',
        VehicleClose = 'Vehículo cerrado',
        DoorsVehicleKeyBind = 'Abrir/Cerrar vehículo'
    },
    ['EN'] = {
        VehicleOpen = 'Vehicle open',
        VehicleClose = 'Vehicle closed',
        DoorsVehicleKeyBind = 'Open/Close vehicle',
    },
    ['PL'] = {
        VehicleOpen = 'Pojazd otwarty',
        VehicleClose = 'Pojazd zamknięty',
        DoorsVehicleKeyBind = 'Otwórz/Zamknij pojazd',

    },
    ['FR'] = {
        VehicleOpen = 'Véhicule ouvert',
        VehicleClose = 'Véhicule fermé',
        DoorsVehicleKeyBind = 'Ouvrir/Fermer le véhicule',
    },
    ['IT'] = {
        VehicleOpen = 'Veicolo aperto',
        VehicleClose = 'Veicolo chiuso',
        DoorsVehicleKeyBind = 'Apri/chiudi il veicolo',

    },
    ['PT'] = {
        VehicleOpen = 'Veículo aberto',
        VehicleClose = 'Veículo fechado',
        DoorsVehicleKeyBind = 'Abrir/Fechar veículo',
    },
}
