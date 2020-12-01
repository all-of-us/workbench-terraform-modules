variable sumologic_users {
  description = "List of user attributes for SumoLogic"
  type = list(object({
    first_name  = string
    last_name   = string
    email       = string
    role_ids    = list(string)
    transfer_to = string
  }))
}
