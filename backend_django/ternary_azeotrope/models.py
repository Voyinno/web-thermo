from django.contrib.sessions.models import Session
from django.core.exceptions import ValidationError
from django.db import models


class Component(models.Model):
    """
    Component model : represents a single component in a mixture.

    Attributes:
        name (str): The name of the component.
        a (float): The first parameter of the component.
        b (float): The second parameter of the component.
        c (float): The third parameter of the component.
    """

    name = models.CharField(max_length=100)
    a = models.FloatField()
    b = models.FloatField()
    c = models.FloatField()
    sessions = models.ManyToManyField(
        Session, blank=True, related_name="components"
    )

    def __str__(self):
        return f"{self.name} (a={self.a}, b={self.b}, c={self.c})"

    @staticmethod
    def fields():
        return ["ID", "Name", "A", "B", "C"]


class BinaryRelation(models.Model):
    """
    BinaryRelation model : represents the binary relationship between two components.

    Attributes:
        component1 (ForeignKey): The first component in the relation.
        component2 (ForeignKey): The second component in the relation.
        a12 (float): The first interaction parameter between component1 and component2.
        a21 (float): The first interaction parameter between component2 and component1.
        alpha (float): The second interaction parameter between component1 and component2.
    """

    component1 = models.ForeignKey(
        Component, on_delete=models.CASCADE, related_name="component1"
    )
    component2 = models.ForeignKey(
        Component, on_delete=models.CASCADE, related_name="component2"
    )
    a12 = models.FloatField()
    a21 = models.FloatField()
    alpha = models.FloatField()
    sessions = models.ManyToManyField(
        Session, blank=True, related_name="relations"
    )

    def __str__(self):
        return f"{self.component1.name} - {self.component2.name} (a12={self.a12}, a21={self.a21}, alpha={self.alpha})"

    @staticmethod
    def fields():
        return ["ID", "Component 1", "Component 2", "A12", "A21", "Alpha"]
