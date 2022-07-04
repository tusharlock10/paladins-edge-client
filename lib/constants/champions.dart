import "package:paladinsedge/data_classes/champions/index.dart" as data_classes;
import "package:flutter/material.dart";

abstract class ChampionRoles {
  static const damage = "Damage";
  static const flank = "Flank";
  static const tank = "Tank";
  static const support = "support";
}

final Map<String, data_classes.ChampionDamage> championDamageType = {
  "Amplification":
      data_classes.ChampionDamage(name: "Amplification", color: Colors.pink),
  "Area Damage":
      data_classes.ChampionDamage(name: "Area Damage", color: Colors.red),
  "Crowd Control":
      data_classes.ChampionDamage(name: "Crowd Control", color: Colors.teal),
  "Direct Damage":
      data_classes.ChampionDamage(name: "Direct Damage", color: Colors.red),
  "Heal": data_classes.ChampionDamage(name: "Heal", color: Colors.green),
  "Movement":
      data_classes.ChampionDamage(name: "Movement", color: Colors.amber),
  "Protective":
      data_classes.ChampionDamage(name: "Protective", color: Colors.lightBlue),
  "Reveal": data_classes.ChampionDamage(name: "Reveal", color: Colors.amber),
  "Shield": data_classes.ChampionDamage(name: "Shield", color: Colors.indigo),
  "Stance Change":
      data_classes.ChampionDamage(name: "Stance Change", color: Colors.pink),
  "Stealth": data_classes.ChampionDamage(name: "Stealth", color: Colors.blue),
  "Ultimate":
      data_classes.ChampionDamage(name: "Ultimate", color: Colors.orange),
};
