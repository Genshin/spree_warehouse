object @variant
extends "spree/api/v1/variants/variant"
child(:option_values => :option_values) { attributes *option_value_attributes }
child(:container_taxons => :container_taxons) { attributes *container_taxon_attributes }