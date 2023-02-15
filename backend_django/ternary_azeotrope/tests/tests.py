from django.test import TestCase
from ternary_azeotrope.helpers.user import User
from ternary_azeotrope.models import Component


# Create your tests here.
class UserTestCase(TestCase):
    def setUp(self):
        pass

    def test(self):
        user = User()

        # for now I only check on the terminal, assert will be added later
        user.components = [Component(name="Acetone", a=0, b=0, c=0)]
        # print("components", user.components)
        user.edit_component("Acetone", a=4)
        user.add_component("Methanol", 1, 1, 1)
        # print("components", user.components)
        user.edit_component("Methanol", a=3, b=10)
        # print("components", user.components)