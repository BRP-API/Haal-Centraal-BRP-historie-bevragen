import csv
import json

def set_field_value(target_object, field_name, value):
    target_object[field_name] = value

def map_dictionary(src_dict, fields_to_map):
    target_object = {}

    target_object['id'] = src_dict.get('id')

    for field in fields_to_map.keys():
        value = src_dict.get(field)
        if not value:
            continue

        field_to_map = fields_to_map.get(field)
        subfields_to_map = field_to_map.split('.')
        tmp_object = target_object

        for subfield in subfields_to_map:
            if subfield == subfields_to_map[-1]:
                set_field_value(tmp_object, subfield, value)
                continue
            elif not tmp_object.get(subfield):
                tmp_object[subfield] = {}
            tmp_object = tmp_object[subfield]

    return target_object

def convert_gba_v_testdata(fields_to_map, gba_v_testdata_file, gba_v_testdata_json_file):
    """
    Convert the GBA V test data file to a CSV file.
    """
    target = []

    with open(gba_v_testdata_file, 'r', encoding='utf-8-sig') as src:
        src_reader = csv.DictReader(src, delimiter=';')

        for row in src_reader:
            target_object = map_dictionary(row, fields_to_map)

            del target_object['id']
            if target_object != {}:
                if target_object.get('burgerservicenummer') is None:
                    last_object = target[-1]
                    target_object['burgerservicenummer'] = last_object['burgerservicenummer']
                    if target_object.get('verblijfplaats') is not None and last_object.get('verblijfplaats') is not None:
                        if last_object['verblijfplaats'].get('datumAanvangAdreshouding') is not None:
                            target_object['verblijfplaats']['datumEindeAdreshouding'] = last_object['verblijfplaats']['datumAanvangAdreshouding']
                        if last_object['verblijfplaats'].get('datumAanvangAdresBuitenland') is not None:
                            target_object['verblijfplaats']['datumEindeAdresBuitenland'] = last_object['verblijfplaats']['datumAanvangAdresBuitenland']

                target.append(target_object)

    with open(gba_v_testdata_json_file, 'w', encoding='utf-8') as dst:
        dst.write(json.dumps(target, indent=2, ensure_ascii=False))

fields_to_map = {
    '01.01.20': 'burgerservicenummer',
    '07.70.10': 'geheimhoudingPersoonsgegevens',
    '08.10.10': 'verblijfplaats.functieAdres.code',
    '08.10.30': 'verblijfplaats.datumAanvangAdreshouding',
    '08.11.10': 'verblijfplaats.straat',
    '08.11.15': 'verblijfplaats.naamOpenbareRuimte',
    '08.11.20': 'verblijfplaats.huisnummer',
    '08.11.30': 'verblijfplaats.huisletter',
    '08.11.40': 'verblijfplaats.huisnummertoevoeging',
    '08.11.50': 'verblijfplaats.aanduidingBijHuisnummer.code',
    '08.11.60': 'verblijfplaats.postcode',
    '08.11.70': 'verblijfplaats.woonplaats',
    '08.11.80': 'verblijfplaats.adresseerbaarObjectIdentificatie',
    '08.11.90': 'verblijfplaats.nummeraanduidingIdentificatie',
    '08.12.10': 'verblijfplaats.locatiebeschrijving',
    '08.13.10': 'verblijfplaats.land.code',
    '08.13.20': 'verblijfplaats.datumAanvangAdresBuitenland',
    '08.13.30': 'verblijfplaats.regel1',
    '08.13.40': 'verblijfplaats.regel2',
    '08.13.50': 'verblijfplaats.regel3',
    '08.72.10': 'verblijfplaats.aangifteAdreshouding',
    '08.83.10': 'verblijfplaats.inOnderzoek.aanduidingGegevensInOnderzoek',
    '08.83.20': 'verblijfplaats.inOnderzoek.datumIngangOnderzoek'
}

convert_gba_v_testdata(fields_to_map, '20220502_Testset_persoonslijsten_proefomgeving_GBA-V.csv', '../src/config/BrpHistorieMock/test-data.json')
