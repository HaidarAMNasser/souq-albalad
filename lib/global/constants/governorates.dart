
enum Governorates {
  damascus,
  rif_dimashq,
  aleppo,
  daraa,
  deir_ez_zor,
  hama,
  homs,
  al_hasakah,
  idleb,
  tartus,
  quneitra,
  Latakia,
  raqqa,
  suwayda;
  static Governorates fromString(String s) => switch (s) {
  "damascus" => damascus,
  "rif_dimashq" => rif_dimashq,
  "aleppo" => aleppo,
  "daraa" => daraa,
  "deir_ez_zor" => deir_ez_zor,
  "hama" => hama,
  "homs" => homs,
  "al_hasakah" => al_hasakah,
  "idleb" => idleb,
  "tartus" => tartus,
  "quneitra" => quneitra,
  "Latakia" => Latakia,
  "raqqa" => raqqa,
  "suwayda" => suwayda,
  _ => suwayda
  };
}
