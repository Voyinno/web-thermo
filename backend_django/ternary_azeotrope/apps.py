# Import the necessary modules
from django.apps import AppConfig


# Define a new AppConfig subclass for the "ternary_azeotrope" app
class TernaryAzeotropeConfig(AppConfig):
    # Set the default auto field to use for models in the app
    default_auto_field = "django.db.models.BigAutoField"

    # Set the name of the app
    name = "ternary_azeotrope"

    # Define a "ready" method that imports the signals module when the app is ready
    def ready(self) -> None:
        from . import signals
