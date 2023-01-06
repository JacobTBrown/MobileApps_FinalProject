class Descriptors {
  Descriptors();

  static const MYTH_GREEK = 'Greek';
  static const MYTH_NORSE = 'Norse';
  static const MYTH_EGYPTIAN = 'Egyptian'; 

  static const TYPE_PHYSICAL = 'Physical';
  static const TYPE_MAGICAL = 'Magical';
  static const TYPE_RANGED = 'Ranged';

  static const THEME_POWER = 'Power';
  static const THEME_SURVIVAL = 'Survival';
  static const THEME_NOBITITY = 'Nobility';
  static const THEME_DIPLOMACY = 'Diplomacy';
  static const THEME_GROWTH = 'Growth';
  static const THEME_FAITH = 'Faith';

  static String getMyth(String val) {
    switch(val) {
      case MYTH_GREEK:
        getMythGreek(); break;
      case MYTH_NORSE:
        getMythNorse(); break;
      case MYTH_EGYPTIAN:
        getMythEgyptian(); break;
    }
  }

  static String getType(String val) {
    switch(val) {
      case TYPE_MAGICAL:
        getTypeMagical(); break;
      case TYPE_PHYSICAL:
        getTypePhysical(); break;
      case TYPE_RANGED:
        getTypeRanged(); break;
    }
  }

  static String getTheme(String val) {
    switch(val) {
      case THEME_DIPLOMACY:
        getThemeDiplomacy(); break;
      case THEME_FAITH:
        getThemeFaith(); break;
      case THEME_GROWTH:
        getThemeGrowth(); break;
      case THEME_NOBITITY:
        getThemeNobility(); break;
      case THEME_POWER:
        getThemePower(); break;
      case THEME_SURVIVAL:
        getThemeSurvival(); break;
    }
  }

  static String getMythEgyptian() {
    return MYTH_EGYPTIAN;
  }

  static String getMythNorse() {
    return MYTH_NORSE;
  }

  static String getMythGreek() {
    return MYTH_GREEK;
  }
  
  static String getTypeRanged() {
    return TYPE_RANGED;
  }

  static String getTypeMagical() {
    return TYPE_MAGICAL;
  }

  static String getTypePhysical() {
    return TYPE_PHYSICAL;
  }

  static String getThemeFaith() {
    return THEME_FAITH;
  }

  static String getThemeGrowth() {
    return THEME_GROWTH;
  }

  static String getThemeDiplomacy() {
    return THEME_DIPLOMACY;
  }

  static String getThemeNobility() {
    return THEME_NOBITITY;
  }

  static String getThemeSurvival() {
    return THEME_SURVIVAL;
  }
  
  static String getThemePower() {
    return THEME_POWER;
  }
}