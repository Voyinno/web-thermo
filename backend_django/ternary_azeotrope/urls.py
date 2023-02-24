from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("run", views.run, name="run"),
    path(
        "add_component",
        views.add_component,
        name="add_component",
    ),
    path(
        "add_relation",
        views.add_relation,
        name="add_relation",
    ),
    path(
        "edit_component",
        views.edit_component,
        name="edit_component",
    ),
    path(
        "edit_relation",
        views.edit_relation,
        name="edit_relation",
    ),
    path(
        "delete_tables/<str:compound_id>",
        views.delete_tables,
        name="delete_tables",
    ),
    path(
        "delete_relation/<str:compound_id>",
        views.delete_relation,
        name="delete_relation",
    ),
]
