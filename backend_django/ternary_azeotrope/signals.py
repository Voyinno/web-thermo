# Import necessary modules
from django.contrib.sessions.models import Session
from django.db.models.signals import post_delete, pre_delete
from django.dispatch import receiver

# Import helper functions from the local "helpers" module
from .helpers import utils


# Define a signal receiver function that will be called before a session is deleted
@receiver(pre_delete, sender=Session)
def pre_delete_session(sender, instance, **kwargs):
    """
    A signal receiver function that is called before a session is deleted from the database.

    Arguments:
    - sender: The model class that emitted the signal (Session).
    - instance: The instance of the model that is being deleted.
    - kwargs: Additional keyword arguments that may be passed to the signal.
    """

    # Print a message indicating that the session is being deleted and its data is being cleared
    print(f"Deleting session {instance.pk} and clearing its data ...")

    # Retrieve the session instance from the database using prefetch_related to optimize performance
    instance = Session.objects.prefetch_related("components", "relations").get(
        pk=instance.pk
    )

    # Call a helper function to clear the session data
    utils.clear_session_data(
        session_key=instance.pk,
        compounds=instance.components.all(),
        relations=instance.relations.all(),
    )


# Define a signal receiver function that will be called after a session is deleted
@receiver(post_delete, sender=Session)
def post_delete_session(sender, **kwargs):
    """
    A signal receiver function that is called after a session is deleted from the database.

    Arguments:
    - sender: The model class that emitted the signal (Session).
    - kwargs: Additional keyword arguments that may be passed to the signal.
    """

    # This function doesn't do anything, but it's here as an example of a post-delete signal receiver.
    # If you need to perform any actions after a session is deleted, you can add them to this function.
    pass
