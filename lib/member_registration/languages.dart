import 'languages.dart';

class Language {
  Language(this.isoCode, this.name);

  final String name;
  final String isoCode;

  Language.fromMap(Map<String, String> map)
      : name = map['name']!,
        isoCode = map['isoCode']!;

  /// Returns the Language matching the given ISO code from the standard list.
  factory Language.fromIsoCode(String isoCode) =>
      Languages.defaultLanguages.firstWhere((l) => l.isoCode == isoCode);

  bool operator ==(o) =>
      o is Language && name == o.name && isoCode == o.isoCode;

  @override
  int get hashCode => isoCode.hashCode;
}

class Languages {
  static Language get abkhazian => Language('ab', 'Abkhaze');
  static Language get afar => Language('aa', 'Afar');
  static Language get afrikaans => Language('af', 'Afrikaans');
  static Language get akan => Language('ak', 'Akan');
  static Language get albanian => Language('sq', 'Albanais');
<<<<<<< HEAD
  static Language get amharic => Language('am', 'Amharique');
  static Language get arabic => Language('ar', 'Arabe');
  static Language get aragonese => Language('an', 'Aragonais');
  static Language get armenian => Language('hy', 'Arménien');
  static Language get assamese => Language('as', 'Assamais');
  static Language get avaric => Language('av', 'Avar');
  static Language get avestan => Language('ae', 'Avestique');
  static Language get aymara => Language('ay', 'Aymara');
  static Language get azerbaijani => Language('az', 'Azéri');
=======
  static Language get dutch => Language('nl', 'Allemand');
  static Language get english => Language('en', 'Anglais');
  static Language get amharic => Language('am', 'Amharic');
  static Language get arabic => Language('ar', 'Arabe');
  static Language get aragonese => Language('an', 'Aragonese');
  static Language get armenian => Language('hy', 'Armenien');
  static Language get assamese => Language('as', 'Assamese');
  static Language get avaric => Language('av', 'Avaric');
  static Language get avestan => Language('ae', 'Avestan');
  static Language get aymara => Language('ay', 'Aymara');
  static Language get azerbaijani => Language('az', 'Azerbaijanai');
>>>>>>> avivob
  static Language get bambara => Language('bm', 'Bambara');
  static Language get bashkir => Language('ba', 'Bachkir');
  static Language get basque => Language('eu', 'Basque');
<<<<<<< HEAD
  static Language get belarusian => Language('be', "Biélorusse");
  static Language get english => Language('en', 'Anglais');
  static Language get esperanto => Language('eo', 'Espéranto');
  static Language get estonian => Language('et', 'Estonien');
  static Language get ewe => Language('ee', 'Éwé');
  static Language get faroese => Language('fo', 'Féroïen');
  static Language get fijian => Language('fj', 'Fidjien');
  static Language get finnish => Language('fi', 'Finnois');
  static Language get french => Language('fr', 'Français');
  static Language get fulah => Language('ff', 'Peul');
  static Language get gaelic => Language('gd', 'Gaélique écossais');
  static Language get galician => Language('gl', 'Galicien');
=======
  static Language get belarusian => Language('be', 'Bielorusse');
  static Language get bengali => Language('bn', 'Bengali');
  static Language get bihariLanguages => Language('bh', 'Bihari Languages');
  static Language get bislama => Language('bi', 'Bislama');
  static Language get bosnian => Language('bs', 'Bosniaque');
  static Language get breton => Language('br', 'Breton');
  static Language get bulgarian => Language('bg', 'Bulgare');
  static Language get burmese => Language('my', 'Burmese');
  static Language get catalan => Language('ca', 'Catalan');
  static Language get centralKhmer => Language('km', 'Central Khmer');
  static Language get chamorro => Language('ch', 'Chamorro');
  static Language get chechen => Language('ce', 'Chechen');
  static Language get chewaNyanja => Language('ny', 'Chewa (Nyanja)');
  static Language get chineseSimplified =>
      Language('zh_Hans', 'Chinois (Simplifié)');
  static Language get chineseTraditional =>
      Language('zh_Hant', 'Chinois (Traditionnel)');
  static Language get churchSlavonic => Language('cu', 'Church Slavonic');
  static Language get chuvash => Language('cv', 'Chuvash');
  static Language get cornish => Language('kw', 'Cornish');
  static Language get corsican => Language('co', 'Corse');
  static Language get cree => Language('cr', 'Cree');
  static Language get croatian => Language('hr', 'Croate');
  static Language get czech => Language('cs', 'Czech');
  static Language get danish => Language('da', 'Danois');
  static Language get dhivehi => Language('dv', 'Dhivehi');
  static Language get dzongkha => Language('dz', 'Dzongkha');

  static Language get esperanto => Language('eo', 'Esperanto');
  static Language get estonian => Language('et', 'Estonian');
  static Language get ewe => Language('ee', 'Ewe');
  static Language get faroese => Language('fo', 'Faroese');
  static Language get fijian => Language('fj', 'Fijian');
  static Language get finnish => Language('fi', 'Finnish');
  static Language get french => Language('fr', 'Français');
  static Language get fulah => Language('ff', 'Fulah');
  static Language get gaelic => Language('gd', 'Gaelic');
  static Language get galician => Language('gl', 'Galician');
>>>>>>> avivob
  static Language get ganda => Language('lg', 'Ganda');
  static Language get georgian => Language('ka', 'Géorgien');
  static Language get german => Language('de', 'Allemand');
  static Language get greek => Language('el', 'Grec');
  static Language get guarani => Language('gn', 'Guarani');
  static Language get gujarati => Language('gu', 'Gujarati');
  static Language get haitian => Language('ht', 'Haïtien');
  static Language get hausa => Language('ha', 'Haoussa');
  static Language get hebrew => Language('he', 'Hébreu');
  static Language get herero => Language('hz', 'Herero');
  static Language get hindi => Language('hi', 'Hindi');
  static Language get hiriMotu => Language('ho', 'Hiri Motu');
  static Language get hungarian => Language('hu', 'Hongrois');
  static Language get icelandic => Language('is', 'Islandais');
  static Language get ido => Language('io', 'Ido');
  static Language get igbo => Language('ig', 'Igbo');
  static Language get indonesian => Language('id', 'Indonésien');
  static Language get interlingua => Language('ia', 'Interlingua');
  static Language get interlingue => Language('ie', 'Occidental');
  static Language get inuktitut => Language('iu', 'Inuktitut');
  static Language get inupiaq => Language('ik', 'Inupiaq');
  static Language get irish => Language('ga', 'Irlandais');
  static Language get italian => Language('it', 'Italien');
  static Language get japanese => Language('ja', 'Japonais');
  static Language get javanese => Language('jv', 'Javanais');
  static Language get kalaallisut => Language('kl', 'Groenlandais');
  static Language get kannada => Language('kn', 'Kannada');
  static Language get kanuri => Language('kr', 'Kanouri');
  static Language get kashmiri => Language('ks', 'Cachemiri');
  static Language get kazakh => Language('kk', 'Kazakh');
  static Language get kikuyu => Language('ki', 'Kikuyu');
  static Language get kinyarwanda => Language('rw', 'Kinyarwanda');
  static Language get kirghiz => Language('ky', 'Kirghize');
  static Language get komi => Language('kv', 'Komi');
  static Language get kongo => Language('kg', 'Kongo');
  static Language get korean => Language('ko', 'Coréen');
  static Language get kuanyama => Language('kj', 'Kwanyama');
  static Language get pushto => Language('ps', 'Pachto');
  static Language get quechua => Language('qu', 'Quechua');
  static Language get romanian => Language('ro', 'Roumain');
  static Language get romansh => Language('rm', 'Romanche');
  static Language get rundi => Language('rn', 'Kirundi');
  static Language get russian => Language('ru', 'Russe');
  static Language get samoan => Language('sm', 'Samoan');
  static Language get sango => Language('sg', 'Sango');
  static Language get sanskrit => Language('sa', 'Sanskrit');
  static Language get sardinian => Language('sc', 'Sarde');
  static Language get serbian => Language('sr', 'Serbe');
  static Language get shona => Language('sn', 'Shona');
  static Language get sichuanYi => Language('ii', 'Yi de Sichuan');
  static Language get sindhi => Language('sd', 'Sindhi');
  static Language get sinhala => Language('si', 'Singhalais');
  static Language get slovak => Language('sk', 'Slovaque');
  static Language get slovenian => Language('sl', 'Slovène');
  static Language get somali => Language('so', 'Somali');
  static Language get sothoSouthern => Language('st', 'Sotho du Sud');
  static Language get spanish => Language('es', 'Espagnol');
  static Language get sundanese => Language('su', 'Soundanais');
  static Language get swahili => Language('sw', 'Swahili');
  static Language get swati => Language('ss', 'Swati');
  static Language get swedish => Language('sv', 'Suédois');
  static Language get tagalog => Language('tl', 'Tagalog');
  static Language get tahitian => Language('ty', 'Tahitien');
  static Language get tajik => Language('tg', 'Tadjik');
  static Language get tamil => Language('ta', 'Tamoul');
  static Language get tatar => Language('tt', 'Tatar');
  static Language get telugu => Language('te', 'Télougou');
  static Language get thai => Language('th', 'Thaï');
  static Language get tibetan => Language('bo', 'Tibétain');
  static Language get tigrinya => Language('ti', 'Tigrigna');
  static Language get bengali => Language('bn', 'Bengali');
  static Language get bihariLanguages => Language('bh', 'Languages Bihar');
  static Language get bislama => Language('bi', 'Bichelamar');
  static Language get bosnian => Language('bs', 'Bosniaque');
  static Language get breton => Language('br', 'Breton');
  static Language get bulgarian => Language('bg', 'Bulgare');
  static Language get burmese => Language('my', 'Birman');
  static Language get catalan => Language('ca', 'Catalan');
  static Language get centralKhmer => Language('km', 'Khmer central');
  static Language get chamorro => Language('ch', 'Chamorro');
  static Language get chechen => Language('ce', 'Tchétchène');
  static Language get chewaNyanja => Language('ny', 'Chichewa (Nyanja)');
  static Language get chineseSimplified =>
      Language('zh_Hans', 'Chinois (Simplifié)');
  static Language get chineseTraditional =>
      Language('zh_Hant', 'Chinois (Traditionnel)');
  static Language get churchSlavonic => Language('cu', 'Slavon ecclésiastique');
  static Language get chuvash => Language('cv', 'Tchouvache');
  static Language get cornish => Language('kw', 'Cornique');
  static Language get corsican => Language('co', 'Corse');
  static Language get cree => Language('cr', 'Cree');
  static Language get croatian => Language('hr', 'Croate');
  static Language get czech => Language('cs', 'Tchèque');
  static Language get danish => Language('da', 'Danois');
  static Language get dhivehi => Language('dv', 'Maldivien');
  static Language get dutch => Language('nl', 'Néerlandais');
  static Language get dzongkha => Language('dz', 'Dzongkha');
  static Language get tongaTongaIslands =>
      Language('to', 'Tongan (Îles Tonga)');
  static Language get tsonga => Language('ts', 'Tsonga');
  static Language get tswana => Language('tn', 'Tswana');
  static Language get turkish => Language('tr', 'Turc');
  static Language get turkmen => Language('tk', 'Turkmène');
  static Language get twi => Language('tw', 'Twi');
  static Language get uighur => Language('ug', 'Ouïghour');
  static Language get ukrainian => Language('uk', 'Ukrainien');
  static Language get urdu => Language('ur', 'Ourdou');
  static Language get uzbek => Language('uz', 'Ouzbek');
  static Language get venda => Language('ve', 'Venda');
  static Language get vietnamese => Language('vi', 'Vietnamien');
  static Language get volapuk => Language('vo', 'Volapük');
  static Language get polish => Language('po', 'Polonais');
  static Language get portuguese => Language('ptg', 'Portugaise');

  static List<Language> defaultLanguages = [
    Languages.abkhazian,
    Languages.afar,
    Languages.afrikaans,
    Languages.akan,
    Languages.albanian,
    Languages.amharic,
    Languages.arabic,
    Languages.aragonese,
    Languages.armenian,
    Languages.assamese,
    Languages.avaric,
    Languages.avestan,
    Languages.aymara,
    Languages.azerbaijani,
    Languages.bambara,
    Languages.bashkir,
    Languages.basque,
    Languages.belarusian,
    Languages.bengali,
    Languages.bihariLanguages,
    Languages.bislama,
    Languages.bosnian,
    Languages.breton,
    Languages.bulgarian,
    Languages.burmese,
    Languages.catalan,
    Languages.centralKhmer,
    Languages.chamorro,
    Languages.chechen,
    Languages.chewaNyanja,
    Languages.chineseSimplified,
    Languages.chineseTraditional,
    Languages.churchSlavonic,
    Languages.chuvash,
    Languages.cornish,
    Languages.corsican,
    Languages.cree,
    Languages.croatian,
    Languages.czech,
    Languages.danish,
    Languages.dhivehi,
    Languages.dutch,
    Languages.dzongkha,
    Languages.english,
    Languages.esperanto,
    Languages.estonian,
    Languages.ewe,
    Languages.faroese,
    Languages.fijian,
    Languages.finnish,
    Languages.french,
    Languages.fulah,
    Languages.gaelic,
    Languages.galician,
    Languages.ganda,
    Languages.georgian,
    Languages.german,
    Languages.greek,
    Languages.guarani,
    Languages.gujarati,
    Languages.haitian,
    Languages.hausa,
    Languages.hebrew,
    Languages.herero,
    Languages.hindi,
    Languages.hiriMotu,
    Languages.hungarian,
    Languages.icelandic,
    Languages.ido,
    Languages.igbo,
    Languages.indonesian,
    Languages.interlingua,
    Languages.interlingue,
    Languages.inuktitut,
    Languages.inupiaq,
    Languages.irish,
    Languages.italian,
    Languages.japanese,
    Languages.javanese,
    Languages.kalaallisut,
    Languages.kannada,
    Languages.kanuri,
    Languages.kashmiri,
    Languages.kazakh,
    Languages.kikuyu,
    Languages.kinyarwanda,
    Languages.kirghiz,
    Languages.komi,
    Languages.kongo,
    Languages.korean,
    Languages.kuanyama,
    Languages.polish,
    Languages.portuguese,
    Languages.pushto,
    Languages.quechua,
    Languages.romanian,
    Languages.romansh,
    Languages.rundi,
    Languages.russian,
    Languages.samoan,
    Languages.sango,
    Languages.sanskrit,
    Languages.sardinian,
    Languages.serbian,
    Languages.shona,
    Languages.sichuanYi,
    Languages.sindhi,
    Languages.sinhala,
    Languages.slovak,
    Languages.slovenian,
    Languages.somali,
    Languages.sothoSouthern,
    Languages.spanish,
    Languages.sundanese,
    Languages.swahili,
    Languages.swati,
    Languages.swedish,
    Languages.tagalog,
    Languages.tahitian,
    Languages.tajik,
    Languages.tamil,
    Languages.tatar,
    Languages.telugu,
    Languages.thai,
    Languages.tibetan,
    Languages.tigrinya,
    Languages.tongaTongaIslands,
    Languages.tsonga,
    Languages.tswana,
    Languages.turkish,
    Languages.turkmen,
    Languages.twi,
    Languages.uighur,
    Languages.ukrainian,
    Languages.urdu,
    Languages.uzbek,
    Languages.venda,
    Languages.vietnamese,
    Languages.volapuk,
  ];
}
