locals {
  configuration_properties_merged = [
    for cp in var.configuration_properties :
    { for k, v in merge(
      lookup(var.configuration_properties_profiles, lookup(cp, "profile_ref", ""), {}), # use profile_ref to look up profile map
      cp                                                                                          # and merge with config properties
    ) : k => v if k != "profile_ref" }                                                            # and remove profile_ref key/pair from resulting map
  ]
}