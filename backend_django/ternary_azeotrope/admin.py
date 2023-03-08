from django.contrib import admin
from django.contrib.sessions.models import Session

from .models import BinaryRelation, Component

# Register your models here.


class ComponentAdmin(admin.ModelAdmin):
    """
    Admin class for the Component model.

    list_display -- A tuple of field names to display in the admin list view.
    filter_horizontal -- A tuple of fields to use in a horizontal filter widget.
    """

    list_display = ("id", "name", "a", "b", "c")
    filter_horizontal = ("sessions",)


class BinaryRelationAdmin(admin.ModelAdmin):
    """
    Admin class for the BinaryRelation model.

    list_display -- A tuple of field names to display in the admin list view.
    filter_horizontal -- A tuple of fields to use in a horizontal filter widget.
    """

    list_display = ("id", "component1", "component2", "a12", "a21", "alpha")
    filter_horizontal = ("sessions",)


class SessionAdmin(admin.ModelAdmin):
    """
    Admin class for the Session model.

    list_display -- A list of field names to display in the admin list view.
    _session_data -- A method to display the decoded session data.
    """

    def _session_data(self, obj):
        return obj.get_decoded()

    list_display = ["session_key", "_session_data", "expire_date"]


# Register the models and their admin classes with the admin site.
admin.site.register(Session, SessionAdmin)
admin.site.register(Component, ComponentAdmin)
admin.site.register(BinaryRelation, BinaryRelationAdmin)
