module SoberSwag
  module Reporting
    ##
    # Reporting outputs.
    #
    # These outputs can tell you what their acceptable views are.
    module Output
      autoload(:Base, 'sober_swag/reporting/output/base')
      autoload(:Bool, 'sober_swag/reporting/output/bool')
      autoload(:Defer, 'sober_swag/reporting/output/defer')
      autoload(:Described, 'sober_swag/reporting/output/described')
      autoload(:Interface, 'sober_swag/reporting/output/interface')
      autoload(:List, 'sober_swag/reporting/output/list')
      autoload(:MergeObjects, 'sober_swag/reporting/output/merge_objects')
      autoload(:Null, 'sober_swag/reporting/output/null')
      autoload(:Number, 'sober_swag/reporting/output/number')
      autoload(:Object, 'sober_swag/reporting/output/object')
      autoload(:Partitioned, 'sober_swag/reporting/output/partitioned')
      autoload(:Referenced, 'sober_swag/reporting/output/referenced')
      autoload(:Struct, 'sober_swag/reporting/output/struct')
      autoload(:Text, 'sober_swag/reporting/output/text')
      autoload(:ViaMap, 'sober_swag/reporting/output/via_map')
      autoload(:Viewed, 'sober_swag/reporting/output/viewed')
    end
  end
end
