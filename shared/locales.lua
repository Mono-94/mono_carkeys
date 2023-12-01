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
        DoorsVehicleKeyBind = 'Abrir/Cerrar vehículo',
         PlateMetadata = 'Matrícula: **%s**',
    },
    ['EN'] = {
        VehicleOpen = 'Vehicle open',
        VehicleClose = 'Vehicle closed',
        DoorsVehicleKeyBind = 'Open/Close vehicle',
        PlateMetadata = 'License plate: **%s**',
    },
    ['PL'] = {
        VehicleOpen = 'Pojazd otwarty',
        VehicleClose = 'Pojazd zamknięty',
        DoorsVehicleKeyBind = 'Otwórz/Zamknij pojazd',
        PlateMetadata = 'Numer rejestracyjny: **%s**',

    },
    ['FR'] = {
        VehicleOpen = 'Véhicule ouvert',
        VehicleClose = 'Véhicule fermé',
        DoorsVehicleKeyBind = 'Ouvrir/Fermer le véhicule',
        PlateMetadata = 'Plaque d\'immatriculation : **%s**',
    },
    ['IT'] = {
        VehicleOpen = 'Veicolo aperto',
        VehicleClose = 'Veicolo chiuso',
        DoorsVehicleKeyBind = 'Apri/chiudi il veicolo',
        PlateMetadata = 'Targa: **%s**',

    },
    ['PT'] = {
        VehicleOpen = 'Veículo aberto',
        VehicleClose = 'Veículo fechado',
        DoorsVehicleKeyBind = 'Abrir/Fechar veículo',
        PlateMetadata = 'Placa: **%s**',
    },
}
