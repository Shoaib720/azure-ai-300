global_configs = {
  environment = "dev"
  location = "East US"
  resource_group_name = "rg-ai300"
  suffix = "01"
  project = "ai300"
}

# virtual_machine_size = "Standard_DS1_v2"

aad_user_object_id = "3cc4ff24-e590-469b-b147-2713837dde2c"

machine_workspace_name = "mlworkspace-ai300-dev01"

network_configs = {
  virtual_network_name = "ml-ai300-dev01"
  subnet_name = "mlsnet-ai300-dev01"
}