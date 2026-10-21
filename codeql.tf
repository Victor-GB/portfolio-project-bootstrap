resource "restapi_object" "codeql_default_setup" {
  for_each = local.content_ready_repositories

  object_id    = each.value.full_name
  path         = "/repos/${each.value.full_name}/code-scanning/default-setup"
  read_path    = "/repos/${each.value.full_name}/code-scanning/default-setup"
  update_path  = "/repos/${each.value.full_name}/code-scanning/default-setup"
  destroy_path = "/repos/${each.value.full_name}/code-scanning/default-setup"

  create_method  = "PATCH"
  read_method    = "GET"
  update_method  = "PATCH"
  destroy_method = "PATCH"

  data = jsonencode({
    state       = "configured"
    query_suite = "default"
    runner_type = "standard"
  })

  destroy_data = jsonencode({
    state = "not-configured"
  })

  ignore_changes_to = [
    "languages",
    "threat_model",
    "updated_at",
    "schedule",
    "runner_label",

  ]

}