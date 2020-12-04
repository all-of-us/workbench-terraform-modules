
PROJECT = ARGV[0].freeze
DATASET = ARGV[1].freeze
module_path = 'module.workbench.module.reporting.module.main.google_bigquery_table.main'.freeze

command = %w[terraform import #{module_path}[\"${table}" projects/#{project}}]
