from .helpers.utils import *
from .models import BinaryRelation, Component
import json


def common_context(request):
    """
    A function that returns a common context to be used in multiple views
    :param request: HTTP request object
    :return: A dictionary of common context variables
    """
    # Retrieve the compounds associated with the session
    components = list(compounds_of_session(request.session.session_key))

    # Return the common context variables as a dictionary
    return {
        "components": components,  # A list of components associated with the session
        "components_json": json.dumps(
            [c.id for c in components]
        ),  # A JSON string of component IDs
        "relations": relations_of_session(
            request.session.session_key
        ),  # A list of binary relations associated with the session
        "component_keys": Component.fields(),  # A list of fields for the Component model
        "relation_keys": BinaryRelation.fields(),  # A list of fields for the BinaryRelation model
    }
