# Import the necessary modules
from django.urls import path
from . import views

# Define the URL patterns for the app
urlpatterns = [
    # Define a URL pattern for the home page that maps to the "index" view
    path("", views.index, name="index"),
    # Define a URL pattern for the "run" page that maps to the "run" view
    path("run", views.run, name="run"),
    # Define a URL pattern for adding a new component that maps to the "add_component" view
    path("add_component", views.add_component, name="add_component"),
    # Define a URL pattern for adding a new relation that maps to the "add_relation" view
    path("add_relation", views.add_relation, name="add_relation"),
    # Define a URL pattern for editing an existing component that maps to the "edit_component" view
    path("edit_component", views.edit_component, name="edit_component"),
    # Define a URL pattern for editing an existing relation that maps to the "edit_relation" view
    path("edit_relation", views.edit_relation, name="edit_relation"),
    # Define a URL pattern for deleting a compound that maps to the "delete_compound" view
    path(
        "delete_compound/<str:compound_id>",
        views.delete_compound,
        name="delete_compound",
    ),
    # Define a URL pattern for deleting a relation that maps to the "delete_relation" view
    path(
        "delete_relation/<str:relation_id>",
        views.delete_relation,
        name="delete_relation",
    ),
]
