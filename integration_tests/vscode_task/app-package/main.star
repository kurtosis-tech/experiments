postgres_module = import_module("github.com/kurtosis-tech/postgres-package/main.star")

def run(plan, args):
    # Start Postgres DB.  URL is stored in postgres_run_output.url 
    postgres_run_output = postgres_module.run(plan, args)

    # Build app config with app image, api port and postgres url
    config = ServiceConfig(
        image = "app:0.1",
        ports = {
            "api" : PortSpec(number = 443, transport_protocol = "TCP"),
        },
        env_vars = {
            "POSTGRES_URL": postgres_run_output.url
        }
    )

    # Start app service
    service = plan.add_service(name = "app", config = config)

    # Integration tests
    recipe = GetHttpRequestRecipe(
		endpoint = "/test",
		port_id = "api",
	)
    response = plan.request(recipe = recipe, service_name = "app")
    plan.assert(response["code"], "==", 200)
